fun split l =
		let
			val n = length l
			fun splitAt k [] = ([],[])|
					splitAt 0 ls = ([], ls)|
					splitAt k (h::t) = 
						let 
							val (x,y) = splitAt (k-1) t
						in 
							(h::x, y)
						end
		in
			splitAt ((n+1)div 2) l
		end

fun bestsplt l = 
	let 
		fun aux [] l2 = ([], l2)|
				aux [h] (h2::t2) = ([h2], t2)|
				aux (h1::m1::t1) (h2::t2) = 
					let 
						val (left, right) = aux t1 t2
					in
						(h2::left, right)
					end
	in
		aux l l
	end


fun assert s cond = if cond then () else print("wrong" ^ s ^ "\n")

val test  = ( 
	assert "0" (bestsplt [] = ([], []));
	assert "1" (bestsplt [42] = ([42], []));
	assert "2" (bestsplt [17,42] = ([17], [42]));
	assert "3" (bestsplt [17,42,65] = ([17,42],[65]))
)
