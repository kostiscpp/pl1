is_num(0).
is_num(1).

triadiko_01(n(T1, T2, T3), Zeros, Ones) :-
    (is_num(T1) -> triadiko_01(T1, Z1, O1, 1) ; triadiko_01(T1, Z1, O1)),
    (is_num(T2) -> triadiko_01(T2, Z2, O2, 1) ; triadiko_01(T2, Z2, O2)),
    (is_num(T3) -> triadiko_01(T3, Z3, O3, 1) ; triadiko_01(T3, Z3, O3)),
    append([Z1, Z2, Z3], Zeros),
    append([O1, O2, O3], Ones).
    
triadiko_01(0, [0], [], 1).
triadiko_01(1, [], [1], 1).


odd_parity(1, 0).
odd_parity(0, 0).
odd_parity(n(T1, T2, T3), Count) :-
    ((is_num(T1), is_num(T2), is_num(T3)) -> Count is ((T1+T2+T3) mod 2)
    ; odd_parity(T1, Count1),
      odd_parity(T2, Count2),
      odd_parity(T3, Count3), Count is (Count1+Count2+Count3)).
