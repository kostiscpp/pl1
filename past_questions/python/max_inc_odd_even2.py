def max_inc_odd_even(array):
    dp = list()
    n = len(array)
    maxLen = 0

    for i in range(n):
        dp.append(1)

    for i in range(1, n):
        for j in range(n):
            if array[j] % 2 != array[i] % 2 and array[i] >= array[j] and dp[i] < dp[j] + 1:
                dp[i] = dp[j] + 1

    for i in range(n):
        if maxLen < dp[i]:
            maxLen = dp[i]

    return maxLen

print(max_inc_odd_even([1, 2, 3, 4]))
print(max_inc_odd_even([6, 8, 17, 42, 1, 87, 3, 94, 5]))
