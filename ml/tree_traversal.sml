datatype btree = Empty |
        Node of int * btree * btree

(* left, root, right *)
fun inorder Empty = () |
  inorder (Node (value, tree_left, tree_right)) = (inorder(tree_left);
  print(Int.toString value ^ "\n");
  inorder(tree_right));

(* left, right, root *)
fun postorder Empty = () |
  postorder (Node (value, tree_left, tree_right)) = (postorder(tree_left);
  postorder(tree_right); print(Int.toString value ^ "\n"));

(* root, left, right *)
fun preorder Empty = () |
  preorder (Node (value, tree_left, tree_right)) = (print(Int.toString value ^
  "\n"); preorder(tree_left); preorder(tree_right));

val tree = Node(2, Node(1, Empty, Empty), Node(3, Empty, Node(4, Empty, Empty)));

preorder tree;
postorder tree;
inorder tree;
