norm_product(Expr, Result) :-
	listexp(Expr, L), explist(L, Result).

listexp(Exp, L) :-
	me
