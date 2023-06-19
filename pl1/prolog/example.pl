p(X) :- member(X, [0,1,0,3]).

pcut(X) :- p(X), !.

qa(Y) :- p(X), p(Y), Y > X.

qb(Y) :- p(X),!, p(Y), Y > X.

qc(Y) :- pcut(X), pcut(Y), Y > X.

