(*
 * Problems Set 3
 * ================
 * - More higher-order functions
 * - More user-defined types
 *)



(* ===> Tail-recursive List.map again <===
 *
 * Fold rules!
 *)

let map (f : 'a -> 'b) (l : 'a list) =
  List.fold_left (fun p e -> (f e)::p) [] (List.rev l) ;;

let filter (f : 'a -> bool) (l : 'a list) =
  List.fold_left (fun p e -> if (f e) then e::p else p) [] (List.rev l) ;;




(* ===> Trees <=== *)

(* We want to implement a generic tree structure - each node could hold a value
 * of any type; and each node could have as many nodes as needed. This structure
 * can thus represent arbitrary planar trees.
 *)

(*
 * A tree node is a tuple of value and a list of nodes
 *)
type 'a tree = Node of ('a * 'a tree list);;


(*
 * An example int tree
 *)
let mytree = Node(1, [Node(2, []);
                      Node(3, [Node(4, [Node(5, [])]);
                               Node(6, []);
                               Node(7, [Node(8, []);
                                        Node(9, [Node(10, [])])])])])
;;


(*
 * Mirror image of a tree
 *)
let rec reflect_tree (Node(v, children) :'a tree) :'a tree =
  Node(v, List.rev (List.map reflect_tree children))
;;

reflect_tree mytree = Node(1, [Node(3, [Node(7, [Node(9, [Node(10,[])]);
                                                 Node(8, [])]);
                                        Node(6, []);
                                        Node(4, [Node(5, [])])]);
                               Node(2, [])])
;;


(*
 * Pick only those nodes which are left-most child of some other node.
 *)
let rec getLeftMost (Node(_, tl) :'a tree) :'a list =
  match tl with
    [] -> []
  | Node(v, l)::_ -> v::(List.fold_left (fun p y -> p @ (getLeftMost y)) [] tl)
;;

getLeftMost mytree = [2; 4; 5; 8; 10];;
getLeftMost (reflect_tree mytree) = [3; 7; 9; 10; 5];;
