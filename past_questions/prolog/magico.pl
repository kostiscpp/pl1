select(X, [X|T], T).
select(X, [H|T1], [H|T2]) :- select(X, T1, T2).
permut([], []).
permut([H|T], P) :- permut(P1, T), select(H, P, P1).
magic([V1, V2, V3, V4, V5, V6, V7, V8, V9]) :-
permut([V1, V2, V3, V4, V5, V6, V7, V8, V9], [1, 2, 3, 4, 5, 6, 7, 8, 9]),
V1 + V2 + V3 =:= 15,
V4 + V5 + V6 =:= 15,
V7 + V8 + V9 =:= 15,
V1 + V4 + V7 =:= 15,
V2 + V5 + V8 =:= 15,
V3 + V6 + V9 =:= 15,
V1 + V5 + V9 =:= 15,
V3 + V5 + V7 =:= 15.
