words = []
while True:
    try:
        words += input().split()
    except EOFError:
        break
words = set(words)
signatures = {}
for word in words:
    sig = frozenset(word)
    if sig in signatures:
        signatures[sig] += 1
    else:
        signatures[sig] = 1
Smax = max(signatures.values())
wordsigs = {x for x in words if (signatures[frozenset(x)] == Smax)}
print(len(signatures), Smax)
for x in sorted(wordsigs): print(x)
