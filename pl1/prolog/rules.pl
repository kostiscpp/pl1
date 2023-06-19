p(X) :- member(X, [1, 7, 4, 2]).

pcut(X) :- p(X), !.

qa(Z) :- p(X), p(Y), Z is X*Y.

qb(Z) :- pcut(X), pcut(Y), Z is X*Y.
qb(Z) :- p(X), !, p(Y), Z is X*Y.
qb(Z) :- p(Z), !.
