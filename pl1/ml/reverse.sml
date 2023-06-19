fun rev l = 
	let 
		fun revh [] x = x|
				revh (h::t) x = revh t (h::x)
	in
		revh l []
	end
