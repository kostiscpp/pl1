text(_, _, [], Acc, Acc).
text([X,Y,Z], NC, [X,Y,Z|Rest], Acc, Answer) :-
append(Acc,[NC], NAcc),
text([X,Y,Z], NC, Rest, NAcc, Answer).
text([X,Y,Z], NC, [W|Rest], Acc, Answer) :-
append(Acc, [W], NAcc),
text([X,Y,Z], NC, Rest, NAcc, Answer).
textify3(LtR, NC, Input, Output) :-
text(LtR, NC, Input, [], Output), !.

