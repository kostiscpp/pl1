#include <vector>
#include <unordered_map>
#include <cstdio>
#include <cstdlib>
#include <cmath>

#define ll long long

using namespace std;

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
    vector<ll> S(N);
    ll total_sum = 0;
    for (ll i = 0; i < N; i++) { fscanf(f, "%lld", &S[i]); total_sum += S[i]; }
    fclose(f);
    ll sum = 0, best_diff = abs(total_sum - sum);
    for(int i = 0, j = 0; i < N; i++) {
		if(sum == 0) sum = 2*S[i], j = max(i, j);
		while (j < N-1 && abs(total_sum - sum) > abs(total_sum - (sum + 2*S[j+1]))) sum += 2*S[++j];
		best_diff = min(best_diff, abs(total_sum - sum));
        if (best_diff == 0) break;
        sum -= 2*S[i];
    }
    printf("%lld\n", best_diff);
}  
