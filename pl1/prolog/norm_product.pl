norm_product(Prod, Prod) :- atomic(Prod).
norm_product(Prod,A*Last) :- lastAtom(Prod, Last, Rest), norm_product(Rest, A). 
lastAtom(Rest*Last, Last, Rest) :- atomic(Last).
lastAtom(H*Tp, Last, H*Tr) :- lastAtom(Tp, Last,Tr).
