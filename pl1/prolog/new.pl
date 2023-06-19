
splitt(P, X, Y) :- (P = X*Y, atomic(Y); P = X*Y, splitt(Y, Y1, Y2), Y = Y1*Y2, atomic(Y2)) .
