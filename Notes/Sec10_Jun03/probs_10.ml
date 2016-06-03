type 'a btree = Empty | Node of 'a btree * 'a * 'a btree;;

let rec isSorted :'a list -> bool = function
    [] -> true
  | [_] -> true
  | a::b::rest -> (a <= b) && isSorted rest
;;

let rec inOrder :'a btree -> 'a list = function
    Empty -> []
  | Node(l, c, r) -> (inOrder l) @ (c :: (inOrder r))
;;

let isBST (t :'a btree) :bool = isSorted (inOrder t);;

(*
 * isBST above runs in linear time O(n),
 *  where n is the number of nodes in the tree
 *
 * The following is an alternative recursive implementation,
 * which also runs in linear time O(n).
 *)

let isBSTrec (t :'a btree) :bool =
  let rec isBSTrec_helper (t :'a btree) (min :int) (max :int) :bool =
    match t with Empty -> true
               | Node(l, c, r) -> min <= c && c < max &&
                                 (isBSTrec_helper l min c) &&
                                 (isBSTrec_helper r c max)
  in isBSTrec_helper t (-max_int) max_int;;
