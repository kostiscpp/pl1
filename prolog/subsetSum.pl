subset_sum(Set, Sum, Subset) :-
	subset(Set, Subset),
	sum(Sum, Subset).


sum(0, []).
sum(Sum, [H|T]) :- sum(X, T), Sum is X + H.

subset([], []).
subset([H|T1],[H|T2]) :-
	subset(T1,T2).
subset([_|T1], T2) :- subset(T1, T2).

