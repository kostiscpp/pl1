datatype 'a btree = Empty |
        Node of 'a * 'a btree * 'a btree

(* left, root, right *)
fun inorder Empty = () |
  inorder (Node (int value, tree_left, tree_right)) = (inorder(tree_left);
  print(value ^ "\n");
  inorder(tree_right));

(* left, right, root *)
fun postorder Empty = () |
  postorder (Node (int value, tree_left, tree_right)) = (postorder(tree_left);
  postorder(tree_right); print(value ^ "\n"));

(* root, left, right *)
fun preorder Empty = () |
  preorder (Node (int value, tree_left, tree_right)) = (print(value ^
  "\n"); preorder(tree_left); preorder(tree_right));

val tree = Node(2, Node(1, Empty, Empty), Node(3, Empty, Node(4, Empty, Empty)));

preorder tree;
postorder tree;
inorder tree;
