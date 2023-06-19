fun splitAt k [] = ([], [])
	| splitAt 0 l = ([], l)
	| splitAt k (h :: t) =
		let
			val (left, right) = splitAt (k-1) t
		in
			(h :: left, right)
		end


fun split l = 
			let 
				val len = length l
			in 
				splitAt ((len+1) div 2) l
			end
