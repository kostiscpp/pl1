fun powerset [] = [[]]
  | powerset (h::t) =
      List.foldl (fn (x,acc) => x::(h::x)::acc) [] (powerset t)

(* Solution with calls to "papakia" below... has worse complexity
fun powerset [] = [[]]
  | powerset (h::t) =
      let
        val ps = powerset t
      in
        ps @ (List.map (fn x => h::x) ps)
      end

*)

local
  val testcases = [
   ("empty", [], 0),
   ("zero", [0], 1),
   ("ott", [1, 2, 3], 0),
   ("zot", [0, 1, 3], 2),
   ("zott", [0, 1, 2, 3], 4),
   ("seven", [6, 3, 2, 1, 7, 0, 4, 5], 8),
   ("answer", [42], 0)
  ]

  fun runtests f [] = ()
    | runtests f ((name, input, output) :: testcases) = (
        print ("Testcase " ^ name ^ ": ");
        if f input = output then print "OK\n"
        else                     print "FAILED!!!\n";
        runtests f testcases
      )
in 
  fun test f = runtests f testcases
end

fun smallest l = 
  let
    fun loop num l =
      if List.exists (fn x => x = num) l
      then loop (num+1) l else num
  in
    loop 0 l
  end

fun smallest2 l = 
  let 
    val sl = ListMergeSort.sort (op >) l
    fun first_gap num [] = num
      | first_gap num (h::t) =
          if num = h then first_gap (num+1) t else num
  in 
    first_gap 0 sl
  end
