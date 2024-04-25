def valid_path(graph, path):
    if path == []: return True
    P,L = len(path), len(graph)
    for i in range(1, P):
        if path[i-1] > L or path[i] > L or path[i] not in graph[path[i-1]-1]:
            return False
    return True

print(valid_path([{2},{3,5},{6},{3},{4}, {5}], [2,5,4,3,6,5,4]))
print(valid_path([{2},{3,5},{6},{3},{4}, {5}], [1,2,7]))
