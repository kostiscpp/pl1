running_sum([], []).

running_sum([H], [H]). 

running_sum([H, M | T], [H, SumM | T1]) :-
    var(SumM), SumM is H + M, running_sum([SumM| T], [SumM | T1]).

running_sum([H,M | T], [H | K]) :- var(M), running_sum([M|T],[H|K],1), !.

running_sum([], [_], 1).
running_sum(L,[H,M],1) :- var(L), X is M-H, L = [X].

running_sum([M | T], [H, SumM | T1], 1) :-
    var(M),
    M is SumM - H,
    running_sum( T, [SumM | T1], 1).


