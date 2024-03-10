incsubseq(L,K,S) :- incsubseq(L,K,S,0).

incsubseq(L,K,S,Min) :- 
( K =:= 0 -> S = []
; K > 0, L = [H|T] -> 
 ( H >= Min, Km1 is K-1, S=[H|Sm1], 
	 	incsubseq(T,Km1,Sm1,H)
 ; incsubseq(T,K,S,Min)
 )
).
