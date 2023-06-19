atlevel(empty, _, []).
atlevel(node(X, _, _), 1, [X]).
atlevel(node(_, Left, Right), Level, List) :-
	Level > 1,
	Lm1 is Level - 1,
	atlevel(Left, Lm1, ListL),
	atlevel(Right, Lm1, ListR),
	append(ListL, ListR, List).
tree_height(empty, 0).
tree_height(node(_, Left, Right), Height) :-
	tree_height(Left, H1),
	tree_height(Right, H2),
	Height is 1 + max(H1, H2).
bfs_level(Tr, L) :-
	tree_height(Tr, MaxHeight),
	between(0, MaxHeight, Level),
	atlevel(Tr, Level, L).
