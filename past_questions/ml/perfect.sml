fun perfect n =
	let 
		fun perf k m = 
			if (k >= n) then
				m
			else
				
					if ((n mod k) = 0) then perf (k+1) (m+k)  else perf (k+1) m
				
	in
		perf 1 0 = n
	end


fun test n = 
	let 
		fun loop i  = 
			if i <= n then  
				if perfect i 
				then (
					let 
						val v = print ((Int.toString i) ^ "\n")
					in
						loop(i+1) 
					end
				)
				else 
					loop(i+1) 
			else ()
		in
			loop 0 
		end
