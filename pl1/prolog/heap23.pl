isHeap23(node(X,empty, empty)).
isHeap23(node(X,Y,empty,empty, empty)).

isHeap23(node(X, L, R)) :-
	(L = node(X2,L2,R2) ; ), (R = node(X3,Y3,L3,R3) ; )


isHeap23(node(X,Y, L, M, R)) :-

