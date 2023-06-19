fun powerset [] = [[]] |
	powerset (h::t) = 
		List.foldl (fn (a,acc) => a::(h::a):: acc) [] (powerset t)
