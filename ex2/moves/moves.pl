read_line(Stream, Line) :-
    read_line_to_string(Stream, Line).

read_grid(File, Grid) :-
    open(File, read, Stream),
    read_line(Stream, Line),
    atom_number(Line, N),
    read_grid_lines(Stream, N, Grid),
    close(Stream).

read_grid_lines(_, 0, []) :- !.
read_grid_lines(Stream, N, [Row|Grid]) :-
    read_line(Stream, Line),
    split_string(Line, " ", "", Atoms),
    maplist(atom_number, Atoms, Row),
    N1 is N - 1,
    read_grid_lines(Stream, N1, Grid).

% Define possible moves and constraints
move(N, Grid, (Row, Col), (NewRow, NewCol), Direction) :-
    member((DR, DC, Direction), [(1, 0, s), (-1, 0, n), (0, 1, e), (0, -1, w), (1, 1, se), (1, -1, sw), (-1, 1, ne), (-1, -1, nw)]),
    NewRow is Row + DR,
    NewCol is Col + DC,
    within_bounds(N, NewRow, NewCol),
    cars(Grid, Row, Col, Cars),
    cars(Grid, NewRow, NewCol, NewCars),
    NewCars < Cars.

within_bounds(N, Row, Col) :-
    Row >= 0, Row < N, Col >= 0, Col < N.

cars(Grid, Row, Col, Cars) :-
    nth0(Row, Grid, GridRow),
    nth0(Col, GridRow, Cars).

% Find the shortest path using BFS
shortest_path(N, Grid, Path) :-
    bfs([(0, 0, 0, [])], N, Grid, [], Path),
    !.
shortest_path(_, _, 'IMPOSSIBLE').

bfs([(Row, Col, _, Path)|_], N, _, _, Path) :-
    Row =:= N - 1, Col =:= N - 1, !.
bfs([(Row, Col, Distance, Path)|Queue], N, Grid, Visited, FinalPath) :-
    findall((NewRow, NewCol, NewDistance, NewPath),
            (move(N, Grid, (Row, Col), (NewRow, NewCol), Direction),
             \+ member((NewRow, NewCol), Visited),
             NewDistance is Distance + 1,
             append(Path, [Direction], NewPath)),
            Neighbors),
    append(Queue, Neighbors, NewQueue),
    bfs(NewQueue, N, Grid, [(Row, Col)|Visited], FinalPath).


moves(File, Path) :-
    read_grid(File, Grid),
    length(Grid, N),
    shortest_path(N, Grid, Path).
