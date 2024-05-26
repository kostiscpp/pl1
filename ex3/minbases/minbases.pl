same_base(X, N, V) :-
    X >= N,
    !,
    X1 is X // N,
    Xmod is X mod N,
    (Xmod =:= V -> same_base(X1, N, V) ; fail).
same_base(X, _, V) :-
    X =:= V.

find_base(N, X, Result) :-
    (X =:= N ; 
    (X1 is X // N, Xmod is X mod N, same_base(X1, N, Xmod))),
    !,
    Result = N.
find_base(N, X, Result) :-
    N1 is N + 1,
    find_base(N1, X, Result).

minbases(L, Result) :-
    maplist(find_base(2), L, Result).