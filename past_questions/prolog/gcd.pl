gcd(X,0,G) :- X > 0 , G is X.
gcd(0,X,G) :- X > 0 , G is X.
gcd(X,Y,G) :- X > Y, X1 is X-Y, gcd(X1,Y,G).
gcd(X,Y,G) :- X <:= Y, Y1 is Y-X, gcd(X,Y1,G).
	
