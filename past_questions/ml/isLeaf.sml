datatype 'a tree = Empty | Node of 'a * 'a tree * 'a tree;

fun listleaf Empty  = []|
  listleaf (Node(v, Empty, Empty)) l = lf v::l |
  listleaf (Node(v, left, right)) = listleaf(left) @ listleaf(right)

(* This approach might be inefficient for large trees due to the '@' operation
* *)
