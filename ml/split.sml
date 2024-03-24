(* These two functions split a list into two halves *)

(*First implementation*)

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

(*Second Implementation*)

fun split2 (lst : int list) =
  let
    fun splitClever lst [] = ([], lst)
      | splitClever (h::t) (_::[]) = ([h], t)
      | splitClever (h::t) (_::_::t2) =
          let
            val (left, right) = splitClever t t2
          in
            (h::left, right)
          end
  in
    splitClever lst lst
  end

fun assert msg cond = if cond then () else print ("wrong test: " ^ msg ^ "\n")

val test = (
  assert "zero"  (split [] = ([],[]));
  assert "one"   (split [17] = ([17],[]));
  assert "two"   (split [17,42] = ([17],[42]));
  assert "three" (split [17,42,54] = ([17,42],[54]));
  assert "four"  (split [17,42,54,77] = ([17,42],[54,77]));
  assert "five"  (split [17,42,54,77,81] = ([17,42,54],[77,81]))
)
