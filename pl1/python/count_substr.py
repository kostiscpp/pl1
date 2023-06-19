def count_substr(S, K):
    return len({S[j-K:j] for j in range(K,len(S)+1)})

print(count_substr("", 2))
print(count_substr("ba", 2))
print(count_substr("banana", 2))
print(count_substr("helloworld", 3))
