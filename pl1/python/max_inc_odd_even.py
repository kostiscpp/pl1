def bs(s, x): 
    l, r = 0, len(s) - 1
    if r < 0 or s[r] < x:
        return r+1
    while l <= r:
        m = (l + r) // 2
        if s[m] < x:
            l = m + 1
        else:
            r = m - 1
    return l

def max_inc_odd_even(arr):
    S = []
    for x in arr:
        for s in S:
            idx = bs(s, x)
            if idx < len(s) and (s[idx] + x) % 2 == 0:
                s[idx] = x  
            elif idx == len(s) and len(s) and (s[-1] + x) % 2:
                s.append(x)
        if len(S) < 2:
            S.append([x])
    return max(len(s) for s in S)


    
print(max_inc_odd_even([1,2,3]))
print(max_inc_odd_even([6,8,17,42,34,91]))
print(max_inc_odd_even([23,11,38,39,33,24,25,13,36,17,11,99,6,36]))
print(max_inc_odd_even([23, 11, 38, 39, 33, 24, 25, 13, 36,37, 42,9,6,36]))
print(max_inc_odd_even([1, 3, 5, 2, 8, 10, 12, 7, 9, 11]))
print(max_inc_odd_even([1, 2, 3, 4, 5, 6]))
print(max_inc_odd_even([1, 3, 10, 2, 4, 6, 12, 5, 7, 9, 11]))
print(max_inc_odd_even([1, 5, 2, 6, 3, 7, 4, 8]))
print(max_inc_odd_even([1, 10, 2, 3, 12, 4, 5]))
print(max_inc_odd_even([50, 1, 2, 51, 3, 1, 4, 52, 5]))
