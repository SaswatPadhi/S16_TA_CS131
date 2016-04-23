(*
 * Problems Set 4
 * ================
 * - Exceptions
 * - Modules and Functors
 *)



(*
 * Product of a list using fold, exiting early on a zero
 *)
let productf (l :int list) :int =
  try
    List.fold_left (fun p x -> if x = 0 then raise Exit else p * x) 1 l
  with Exit -> 0
;;

productf [1;2;3;0;4;5;6] = 0;;
productf [10;1;2;3] = 60;;


(*
 * Product of a list using recursion, inefficient
 *
 * Inefficient, because it makes n multiplications
 * after seeing a 0. n = position of 0
 *)
let rec product1 (l :int list) :int =
  match l with
    []   -> 1
  | 0::_ -> 0
  | h::t -> h * (product1 t)
;;

product1 [1;2;3;0;4;5;6] = 0;;
product1 [10;1;2;3] = 60;;



(*
 * Product of a list using recursion, inefficient
 *
 * Same inefficiency as above, makes n-1 multiplications
 * because of badly used exception handling
 *)
let rec product2 (l :int list) :int =
  match l with
    []   -> 1
  | 0::_ -> raise Exit
  | h::t -> try h * (product2 t) with Exit -> 0
;;

product2 [1;2;3;0;4;5;6] = 0;;
product2 [10;1;2;3] = 60;;



(*
 * Product of a list using recursion, inefficient
 *
 * Same as product1! We immediately catch the exception after raising it.
 *)
let rec product3 (l :int list) :int =
  try (match l with
        []   -> 1
      | 0::_ -> raise Exit
      | h::t -> h * (product3 t))
  with Exit -> 0
;;

product3 [1;2;3;0;4;5;6] = 0;;
product3 [10;1;2;3] = 60;;



(*
 * Product of a list using recursion, efficient
 *
 * Makes no multiplications after seeing a 0
 *)
let product4 (l :int list) :int =
  let rec product4h (r :int list) :int =
    match r with
        []   -> 1
      | 0::_ -> raise Exit
      | h::t -> h * (product4h t)
  in try product4h l with Exit -> 0
;;

product4 [1;2;3;0;4;5;6] = 0;;
product4 [10;1;2;3] = 60;;




(* ===> Sets: Unordered & Ordered <=== *)

(*
 * A Comparator module for ordering
 *
 * This is an abstract module, only a signature
 *)
module type Comparator =
  sig
    type e
    val lte: e -> e -> bool
  end
;;


(*
 * A Comparator module for ordering integers
 *
 * This is a concrete module, which implements Comparator
 *)
module IntComparator : (Comparator with type e = int) =
  struct
    type e = int
    let lte x y = (x <= y)
  end
;;

IntComparator.lte 2 3 = true;;
IntComparator.lte 5 5 = true;;
IntComparator.lte 5 3 = false;;


(*
 * A Comparator module for ordering strings
 *
 * This is a concrete module, which implements Comparator
 *)
module StringComparator : (Comparator with type e = string) =
  struct
    type e = string
    let lte x y = (x <= y)
    let gte x y = (x <= y)
  end
;;

StringComparator.lte "hey" "hi" = true;;
StringComparator.lte "hola" "hi" = false;;


(*
 * An abstract SET module
 *)
module type SET =
  functor (C :Comparator) ->
    sig
      type set
      val emptyset: unit -> set
      val contains: set -> C.e -> bool
      val add: set -> C.e -> set
      val to_list: set -> C.e list
    end
;;


(*
 * An UnorderedSet module
 *)
module UnorderedSet :SET =
  functor (C :Comparator) ->
    struct
      type set = Empty | NonEmpty of (C.e * set)

      let emptyset() = Empty

      let rec contains s e =
        match s with
          Empty         -> false
        | NonEmpty(x,t) -> if C.lte x e && C.lte e x then true else contains t e

      let add s e =
        if contains s e then s else NonEmpty(e,s)

      let rec to_list s =
        match s with
          Empty         -> []
        | NonEmpty(x,t) -> x::(to_list t)
    end
;;


(*
 * IntegerUnorderedSet module
 *)
module IUS = UnorderedSet(IntComparator);;

let s = IUS.add (IUS.add (IUS.add (IUS.emptyset()) 3) 4) 1;;
IUS.to_list s = [1;4;3];;
IUS.contains s 4 = true;;
IUS.contains s 2 = false;;


(*
 * An OrderedSet module
 *)
module OrderedSet :SET =
  functor (C :Comparator) ->
    struct
      type set = C.e list

      let emptyset() = []

      let rec contains s e =
        match s with
          []                  -> false
        | h::t when C.lte e h -> C.lte h e
        | _::t                -> contains t e

      let rec add s e =
        match s with
          []                  -> [e]
        | h::t when C.lte e h -> if C.lte h e then s else e::h::t
        | h::t                -> h::(add t e)

      let to_list s =
        List.fold_left (fun p x -> x::p) [] (List.rev s)
    end
;;


(*
 * StringSortedSet module
 *)
module SSS = OrderedSet(StringComparator);;

let s = SSS.add (SSS.add (SSS.add (SSS.emptyset()) "string") "set") "sorted";;
SSS.to_list s = ["set"; "sorted"; "string"];;
SSS.contains s "set" = true;;
SSS.contains s "saswat" = false;;
