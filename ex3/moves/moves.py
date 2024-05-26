import sys
from collections import deque


with open(sys.argv[1], 'r') as file:
    lines = file.readlines()
    N = int(lines[0].strip())
    grid = [list(map(int, line.strip().split())) for line in lines[1:N+1]]

DIRECTIONS = [
    (-1, 0, 'N'), (1, 0, 'S'), (0, 1, 'E'), (0, -1, 'W'),
    (-1, 1, 'NE'), (-1, -1, 'NW'), (1, 1, 'SE'), (1, -1, 'SW')
]

def is_valid_move(N, grid, visited, row, col, current_cars):
    return 0 <= row < N and 0 <= col < N and not visited[row][col] and grid[row][col] < current_cars

visited = [[False] * N for _ in range(N)]
queue = deque([(0, 0, 0, [])])  # (row, col, distance, path)
visited[0][0] = True
while queue:
    row, col, dist, path = queue.popleft()
    if row == N - 1 and col == N - 1:
        print('[' + ','.join(path) + ']')
        exit()
    current_cars = grid[row][col]
    for dr, dc, direction in DIRECTIONS:
        new_row, new_col = row + dr, col + dc
        if is_valid_move(N, grid, visited, new_row, new_col, current_cars):
            visited[new_row][new_col] = True
            queue.append((new_row, new_col, dist + 1, path + [direction]))
print("IMPOSSIBLE")
