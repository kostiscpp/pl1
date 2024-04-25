datatype btree = Empty
               | Leaf of int
               | Node of btree * btree

fun cntleaves Empty = 0 |
  cntleaves (Leaf _) = 1|
  cntleaves (Node (tree_right, tree_left)) = (cntleaves tree_right) + (cntleaves tree_left);

val sampleTree = Node(Node(Leaf 1, Empty), Leaf 2);

val numberOfLeaves = cntleaves sampleTree;

print (Int.toString numberOfLeaves ^ "\n");
