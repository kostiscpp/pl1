subsetsum(SET, SUM, ANSWER) :-
    % Find a subset
    subset(SET, ANSWER),
    % Check elements of the subset add up to SUM
    sum(ANSWER, SUM).

% sum(LIST, SUM) - sums all numbers in the list
sum([], 0).
sum([X | T], SUM) :-
    sum(T, TAILSUM),
    SUM is TAILSUM + X.

% subset - finds subsets
subset([], []).
subset([E|Tail], [E|NTail]) :-
    subset(Tail, NTail).
subset([_|Tail], NTail) :-
    subset(Tail, NTail).
