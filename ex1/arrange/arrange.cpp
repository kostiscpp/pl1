#include <vector>
#include <unordered_map>
#include <cstdio>
#include <cstdlib>
#include <cmath>

#define ll long long

using namespace std;

struct tree {
    ll val;
    tree *left, *right;
    tree (ll v) : val(v), left(nullptr), right(nullptr) {}
};

tree * mk_tree(FILE *f) {
    ll num;
    fscanf(f, "%lld", &num);
    if (num) {
        tree *t = new tree(num);
        t->left = mk_tree(f);
        t->right = mk_tree(f);
        return t;
    }
    else return nullptr;
}

ll arrange(tree *t, ll N) {
    if (t == nullptr) return N+1;
    ll l = arrange(t->left, N);
    ll r = arrange(t->right, N);
    if (l > r && l <= N && r <= N) {
            tree *tmp = t->left;
            t->left = t->right;
            t->right = tmp;
            l = r;
    }  
    else if (l == N+1 || r == N+1) {
        if ((l != N+1 && t->val < l) || (r != N+1 && t->val > r)) {
            tree *tmp = t->left;
            t->left = t->right;
            t->right = tmp;
            l = r;
        }

    }
    return l == N+1 ? t->val : l;
}

void print_tree(tree *t, bool &first) {
    if (t == nullptr) return;
    print_tree(t->left, first);
    printf(first ? "%lld" : " %lld", t->val);
    first = false;
    print_tree(t->right, first);
}

int main (int argc, char **argv) {
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
    bool first = true;
    print_tree(t, first);
    printf("\n");
}        