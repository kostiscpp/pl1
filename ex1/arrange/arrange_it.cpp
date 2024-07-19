#include <cstdio>
#include <cstdlib>
#include <stack>
#include <vector>
#include <limits>
#include <algorithm>
#include <utility>
#define ll long long

using namespace std;

struct tree {
    ll val;
    tree *left, *right;
    ll min_val = 1000001;
    tree(ll v) : val(v), left(nullptr), right(nullptr), min_val(1000001) {}
};

tree *mk_tree(FILE *f) {
    stack<tree**> st;
    tree *root = nullptr, **curr = &root;
    ll num;

    while (fscanf(f, "%lld", &num) != EOF) {
        if (num) {
            *curr = new tree(num);
            st.push(&((*curr)->right));
            curr = &((*curr)->left); 
        } else {
            if (st.empty()) break;
            curr = st.top();
            st.pop();
        }
    }

    return root;
}

void arrange(tree* root, ll N) {
    if (root == nullptr) return;
    stack<tree*> stack1;
    stack<tree*> stack2;
    tree* node;
    stack1.push(root);
    
    while (!stack1.empty()) {
        node = stack1.top();
        stack1.pop();
        stack2.push(node);

        if (node->left) {
            stack1.push(node->left);
        }
        if (node->right) {
            stack1.push(node->right);
        }
    }

    while (!stack2.empty()) {
        node = stack2.top();
        stack2.pop();
        ll l = node->left ? node->left->min_val : N+1;
        ll r = node->right ? node->right->min_val : N+1;
        if (l > r && l <= N && r <= N) {
            tree *tmp = node->left;
            node->left = node->right;
            node->right = tmp;
            l = r;
        } else if (l == N+1 || r == N+1) {
            if ((l != N+1 && node->val < l) || (r != N+1 && node->val > r)) {
                tree *tmp = node->left;
                node->left = node->right;
                node->right = tmp;
                l = r;
            }
        }
        node->min_val = l == N+1 ? node->val : l;
    }
}
void print_tree(tree *t) {
    stack<tree*> st;
    tree *curr = t;
    bool first = true;

    while (!st.empty() || curr != nullptr) {
        while (curr != nullptr) {
            st.push(curr);
            curr = curr->left; 
        }
        curr = st.top();
        st.pop();
        printf(first ? "%lld" : " %lld", curr->val);
        first = false;
        curr = curr->right; 
    }
}

int main(int argc, char **argv) {
    if (argc != 2) {
        printf("Usage: %s <input_file>\n", argv[0]);
        return 1;
    }
    FILE *f = fopen(argv[1], "r");
    if (f == NULL) {
        printf("Error opening file\n");
        return 1;
    }
    ll N;
    fscanf(f, "%lld", &N);
    tree *t = mk_tree(f);
    fclose(f);
    arrange(t, N);
    print_tree(t);
    printf("\n");
    return 0;
}