winner(L) :- 
	diagonal(L) ; vertical(L); horizontal(L) ; move(L,L1), (diagonal(L1) ; vertical(L1); horizontal(L1)).

move([[b,_,_],[_,_,_],[_,_,_]], [[x,_,_],[_,_,_],[_,_,_]]).
move([[_,b,_],[_,_,_],[_,_,_]], [[_,x,_],[_,_,_],[_,_,_]]).
move([[_,_,b],[_,_,_],[_,_,_]], [[_,_,x],[_,_,_],[_,_,_]]).
move([[_,_,_],[b,_,_],[_,_,_]], [[_,_,_],[x,_,_],[_,_,_]]).
move([[_,_,_],[_,b,_],[_,_,_]], [[_,_,_],[_,x,_],[_,_,_]]).
move([[_,_,_],[_,_,b],[_,_,_]], [[_,_,_],[_,_,x],[_,_,_]]).
move([[_,_,_],[_,_,_],[b,_,_]], [[_,_,_],[_,_,_],[x,_,_]]).
move([[_,_,_],[_,_,_],[_,b,_]], [[_,_,_],[_,_,_],[_,x,_]]).
move([[_,_,_],[_,_,_],[_,_,b]], [[_,_,_],[_,_,_],[_,_,x]]).
diagonal([[x,_,_],[_,x,_],[_,_,x]]).
diagonal([[_,_,x],[_,x,_],[x,_,_]]).
vertical([[_,x,_],[_,x,_],[_,x,_]]).
vertical([[x,_,_],[x,_,_],[x,_,_]]).
vertical([[_,_,x],[_,_,x],[_,_,x]]).
horizontal([[x,x,x],[_,_,_],[_,_,_]]).
horizontal([[_,_,_],[x,x,x],[_,_,_]]).
horizontal([[_,_,_],[_,_,_],[x,x,x]]).