permutation([], []).
permutation(List, [X|Perm]) :-
  permutation(Rest, Perm), myselect(X, List,Rest).

myselect(X, [X|T], T).
myselect(X, [H|T1], [H|T2]) :- myselect(X,T1,T2).

valid([V1,V2,V3,V4,V5,V6,V7,V8,V9]) :- V1+V2+V3 is V4+V5+V6, V4+V5+V6 is V7+V8+V9, V7+V8+V9 is V1+V5+V9, V1+V5+V9 is V3+V5+V7.
magic(L) :- permutation([1,2,3,4,5,6,7,8,9], L), valid(L).
