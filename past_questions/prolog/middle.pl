middle(L, M) :-
	( L = [] -> M = []
	; L = [H] -> M = [H]
	; L = [H1, H2] -> M = [H1, H2]
	; append([H|Inside],[T], L), middle(Inside, Middle), M = [H,Middle,T]
	).
