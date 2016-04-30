(*
 * Problems Set 5
 * ================
 * - Laziness
 *)


(*
 * A lazy list, which produces values only when the user demands it
 *)
type 'a lazylist = Nil | Cons of 'a * (unit -> 'a lazylist);;


(*
 * A finite lazy list
 *)
let l123 = Cons(1, (fun () -> Cons(2, (fun () -> Cons(3, (fun () -> Nil))))));;

(*
 * An infinite lazy list with all ones
 *)
let rec all_ones = Cons(1, (fun () -> all_ones));;

(*
 * An infinite lazy list with all whole numbers
 *)
let nat =
  let rec from i = Cons(i, (fun () -> from (i + 1)))
  in from 0;;


(*
 * Obtain the nth element of a lazy list
 *)
let rec nth (n :int) (l :'a lazylist) :'a =
  match l with Nil -> raise Exit
             | Cons(h, t) -> if n = 0 then h else nth (n-1) (t ())
;;


(*
 * Append two lazy lists, to produce a new lazy list
 *
 * Note that we don't want to generate the first list completely, since it might
 * be an infinite one
 *)
let rec append (l1 :'a lazylist) (l2 :'a lazylist) :'a lazylist =
  match l1 with
    Nil -> l2
  | Cons(h, t) -> Cons(h, (fun () -> let x = t ()
                                     in if x = Nil then l2 else (append x l2)))
;;

let l123ones = append l123 all_ones;;

nth 1 l123ones = 2;;
nth 10 l123ones = 1;;
nth 100 l123ones = 1;;


(*
 * Map a function over a lazy list
 *)
let rec map (f :('a -> 'b)) (l :'a lazylist) : 'b lazylist =
  match l with
    Nil -> Nil
  | Cons(h, t) -> Cons((f h), (fun () -> map f (t ())))
;;

let l123ones10 = map (fun x -> 10 * x) l123ones;;

nth 1 l123ones10 = 20;;
nth 10 l123ones10 = 10;;
nth 100 l123ones10 = 10;;

let evens = map (( * ) 2) nat;;

nth 1 evens = 2;;
nth 10 evens = 20;;
nth 100 evens = 200;;
