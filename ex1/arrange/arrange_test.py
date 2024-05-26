import random
import matplotlib.pyplot as plt
import networkx as nx
import subprocess
import sys
import copy
import time
from collections import deque

def visualize_tree(root):
    G = nx.DiGraph()
    if not root:
        return G

    queue = deque([(root, None)])  # Initialize a deque with the root node and its parent (None)
    while queue:
        node, parent = queue.popleft()
        if parent is not None:
            G.add_edge(parent.value, node.value)
        G.add_node(node.value)
        if node.left:
            queue.append((node.left, node))
        if node.right:
            queue.append((node.right, node))

    pos = nx.spring_layout(G)  # or use other layout algorithms
    nx.draw(G, pos, with_labels=True, node_size=700, node_color="lightblue", font_size=20, font_weight="bold")
    plt.show()

class TreeNode:
    def __init__(self, value):
        self.value = value
        self.left = None
        self.right = None


def generate_random_tree(size):
    used_values = set()
    while True:
        root = TreeNode(0)
        stack = [(root, size)]
        is_leaf = True
 
        while stack:
            node, node_size = stack.pop()
            if node_size[0] <= 0 or random.random() < 0.2:
                continue
            is_leaf = False
            while True:
                value = random.randint(1, 10000000)
                if value not in used_values:
                    break
            used_values.add(value)
            node_size[0] -= 1
            #print(node_size[0])
            node.value = value
            node.left = TreeNode(0)
            node.right = TreeNode(0)
            stack.append((node.right, node_size))
            stack.append((node.left, node_size))
 
        if not is_leaf:
            return root

def preorder_traversal(node, output_file):
    stack = [node]
    while stack:
        current = stack.pop()
        if current:
            output_file.write(str(current.value) + " ")
            stack.append(current.right)
            stack.append(current.left)

def execute_executables(executable1, executable2, filename):
    output_file1 = "output_executable1.txt"
    output_file2 = "output_executable2.txt"

    with open(output_file1, 'w') as f1:
        subprocess.run([executable1, filename], stdout=f1)

    with open(output_file2, 'w') as f2:
        subprocess.run([executable2, filename], stdout=f2)

    return output_file1, output_file2

if __name__ == "__main__":
    # Increase recursion limit
    sys.setrecursionlimit(100000)

    diff = 0

    while (not diff):
        # Generate random tree
        tree_size_printed = 1000000#random.randint(1, 10000)
        tree_size = [copy.deepcopy(tree_size_printed)]
        random_tree = generate_random_tree(tree_size)


        # Write preorder traversal to file
        with open("random_tree.txt", 'w') as tree_file:
            tree_file.write(str(tree_size_printed) + "\n")
            preorder_traversal(random_tree, tree_file)
        break
        # Execute executables and store their outputs
#        executable1 = "./arrange"
#        executable2 = "./arrange_c"
#        output_file1, output_file2 = execute_executables(executable1, executable2, "random_tree.txt")
        
        # Read the outputs
#        with open(output_file1, 'r') as f1, open(output_file2, 'r') as f2:
#            output1 = f1.read().strip()
#            output2 = f2.read().strip()

        # Compare outputs
 #       if output1 == output2:
 #           print("Outputs are the same")
#        else:
#            print("Outputs are different")
#            diff = 1
