(*
 * Problems Set 2
 * ================
 * - User-Defined Data Types
 * - Constructors for Variants
 * - Pattern Matching on Constructors
 *)



(* ===> Fast exponentiation <=== *)

let rec exp (a : int) (b : int) : int =
  if b = 0 then 1
  else if (b mod 2 = 1) then (a * (exp a (b - 1)))
  else let z = (exp a (b / 2)) in z * z
;;



(* ===> Even faster Fibonacci! <=== *)

(* Can Fibonacci computation be seen as a simple exponentiation?
 * Yes, matrix exponentiation. *)

type fibmat = int * int * int * int

let mult_fibmat ((tl1, tr1, bl1, br1) : fibmat) ((tl2, tr2, bl2, br2) : fibmat)
  : fibmat =
  (
    tl1 * tl2 + tr1 * bl2,
    tl1 * tr2 + tr1 * br2,
    bl1 * tl2 + br1 * bl2,
    bl1 * tr2 + br1 * br2
  )
;;

let sq_fibmat (m : fibmat) : fibmat = mult_fibmat m m ;;

let rec exp_fibmat (m : fibmat) (n : int) : fibmat =
  if (n = 0) then (1, 0, 1, 0)
  else if (n mod 2 = 1) then (mult_fibmat m (exp_fibmat (sq_fibmat m) (n / 2)))
  else exp_fibmat (sq_fibmat m) (n / 2)
;;

let fib3 (n : int) : int =
  let (m : fibmat) = (1, 1, 1, 0) in
    if n < 2 then n
    else let ((tl, tr, bl, br) : fibmat) = exp_fibmat m (n - 2) in tl
;;



(* ===> Tail-recursive List.map <=== *)

let rev_map (f : 'a -> 'b) (l : 'a list) : 'b list =
  let rec helper (acc : 'b list) (remaining : 'a list) : 'b list =
    match remaining with
      [] -> acc
    | h::t -> helper ((f h)::acc) t
  in helper [] l
;;

let rev (l : 'a list) : 'a list =
  let rec helper (acc : 'a list) (remaining : 'a list) : 'a list =
    match remaining with
      [] -> acc
    | h::t-> helper (h::acc) t
  in helper [] l
;;

let map (f : 'a -> 'b) (l : 'a list) = rev_map f (rev l) ;;



(* ===> Peano Arithmetic <=== *)

(* In Peano Arithmetic, we have 2 symbols - Zero and Succ which we use to
 * represent all numbers. Succ a constructor representing the successor
 * relation. So, Succ(Zero) is the peano equivalent of decimal 1. Similarly
 * Succ(Succ(Succ(Zero))) is equivalent to 3 and so on. *)

(*
 * A Peano number can either be Zero or Succ of another Peano number
 *)
type peano = Zero | Succ of peano


(*
 * Convert a Peano number to equivalent decimal number
 *)
let rec pToI (p: peano) :int =
  match p with
    Zero    -> 0
  | Succ(q) -> 1 + (pToI q)
;;

pToI Zero = 0;;
pToI (Succ(Succ(Succ(Zero)))) = 3;;


(*
 * Convert a Peano number to equivalent decimal number
 *)
let rec iToP (i: int) :peano =
  if i = 0 then Zero
           else Succ(iToP(i-1))
;;

iToP 0 = Zero;;
iToP 2 = Succ(Succ(Zero));;


(*
 * Add 2 peano numbers and produce their sum as a peano number
 *)
let rec add ((p1, p2) :peano * peano) :peano =
  match p1 with
    Zero    -> p2
  | Succ(q) -> add (q, Succ(p2))
;;

add (Succ(Succ(Zero)), Succ(Zero)) = Succ(Succ(Succ(Zero)));;


(*
 * Multiply 2 peano numbers and produce their sum as a peano number
 *)
let rec multiply ((p1, p2) :peano * peano) :peano =
  match p1 with
    Zero    -> Zero
  | Succ(q) -> add (p2, multiply (q, p2))
;;

multiply (Succ(Succ(Zero)), Succ(Succ(Zero))) = Succ(Succ(Succ(Succ(Zero))));;
