import java.io.File;
import java.io.FileNotFoundException;
import java.util.Stack;
import java.util.Scanner;

class Tree {
    long val;
    Tree left, right;
    long minVal = 1000001;

    Tree(long v) {
        val = v;
        left = right = null;
    }
}

public class Arrange {

    public static Tree mkTree(Scanner scanner) {
        Stack<Tree> stack = new Stack<>();
        Tree root = null, curr = null;

        while (scanner.hasNext()) {
            if (scanner.hasNextLong()) {
                long num = scanner.nextLong();
                if (num != 0) {
                    Tree newNode = new Tree(num);
                    if (curr == null) {
                        root = newNode;
                    } else if (curr.left == null) {
                        curr.left = newNode;
                    } else {
                        curr.right = newNode;
                    }
                    stack.push(newNode);
                    curr = newNode;
                } else {
                    if (!stack.isEmpty()) {
                        curr = stack.pop();
                    }
                }
            } else {
                scanner.next(); 
            }
        }

        return root;
    }

    public static void arrange(Tree root, long N) {
        if (root == null) return;
        Stack<Tree> stack1 = new Stack<>();
        Stack<Tree> stack2 = new Stack<>();
        stack1.push(root);

        while (!stack1.isEmpty()) {
            Tree node = stack1.pop();
            stack2.push(node);

            if (node.left != null) {
                stack1.push(node.left);
            }
            if (node.right != null) {
                stack1.push(node.right);
            }
        }

        while (!stack2.isEmpty()) {
            Tree node = stack2.pop();
            long l = (node.left != null) ? node.left.minVal : N + 1;
            long r = (node.right != null) ? node.right.minVal : N + 1;

            if (l > r && l <= N && r <= N) {
                Tree temp = node.left;
                node.left = node.right;
                node.right = temp;
                l = r;
            } else if (l == N + 1 || r == N + 1) {
                if ((l != N + 1 && node.val < l) || (r != N + 1 && node.val > r)) {
                    Tree temp = node.left;
                    node.left = node.right;
                    node.right = temp;
                    l = r;
                }
            }
            node.minVal = (l == N+1 ? node.val : l);
        }
    }

    public static void printTree(Tree t) {
        Stack<Tree> stack = new Stack<>();
        Tree curr = t;
        boolean first = true;

        while (!stack.isEmpty() || curr != null) {
            while (curr != null) {
                stack.push(curr);
                curr = curr.left;
            }
            curr = stack.pop();
            if (first) {
                System.out.print(curr.val);
                first = false;
            } else {
                System.out.print(" " + curr.val);
            }
            curr = curr.right;
        }
    }

    public static void main(String[] args) {
        try (Scanner scanner = new Scanner(new File(args[0]))) {
            if (!scanner.hasNextLong()) {
                System.out.println("Error reading file");
                return;
            }
            long N = scanner.nextLong();
            Tree t = mkTree(scanner);
            arrange(t, N);
            printTree(t);
            System.out.println();
        } catch (FileNotFoundException e) {
            System.out.println("Error opening file");
        }
    }
}
