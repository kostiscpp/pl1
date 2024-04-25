/*
** The representation of configurations is
**   config(Man, Wolf, Goat, Cabbage)
** where each is either w (west) or e (east).
*/

initial(config(w,w,w,w)).

final(config(e,e,e,e)).

/* solve(+Config, -Moves) */
solve(Config, []) :- final(Config).
solve(Config, [Move|Moves]) :-
    move(Config, Move, NextConfig),
    safe(NextConfig),
    solve(NextConfig, Moves).

move(config(A,X,A,Y), goat, config(B,X,B,Y)) :- opposite(A,B).
move(config(A,A,X,Y), wolf, config(B,B,X,Y)) :- opposite(A,B).
move(config(A,X,Y,A), cabbage, config(B,X,Y,B)) :- opposite(A,B).
move(config(A,X,Y,Z), nothing, config(B,X,Y,Z)) :- opposite(A,B).

opposite(w,e).
opposite(e,w).

safe(config(Man,Wolf,Goat,Cabbage)) :- 
    together_or_separated(Man,Wolf,Goat),
    together_or_separated(Man,Goat,Cabbage).

together_or_separated(Coast,Coast,Coast).
together_or_separated(_,Coast1,Coast2) :- opposite(Coast1,Coast2).
