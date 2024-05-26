import sys

with open(sys.argv[1], 'r') as f:
    N = int(f.readline().strip())
    S = list(map(int, f.readline().strip().split()))
    f.close()

total_sum = sum(S)
curr_sum = 0
best_diff = total_sum
j = 0
for i in range(N):
    if curr_sum == 0:
        j = max(i, j)
        curr_sum = 2*S[i]
    while j < N-1 and abs(total_sum - curr_sum) > abs(total_sum - (curr_sum + 2*S[j+1])):
        j += 1
        curr_sum += 2*S[j]
    best_diff = min(best_diff, abs(total_sum - curr_sum))
    if best_diff == 0:
        break
    curr_sum -= 2*S[i]
print(best_diff)
    