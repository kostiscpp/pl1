def countsum(A, K):
    seen = {0:1}
    result = sum = 0
    for x in A:
        sum += x
        if sum - K in seen:
            result += seen[sum-K]
        if sum in seen:
            seen[sum] += 1
        else:
            seen[sum] = 1


