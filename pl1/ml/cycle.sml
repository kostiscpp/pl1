
fun reverse [] = []
  | reverse L =
        let 
          fun aux [] acc = acc
            | aux (h::t) acc = aux t (h::acc)
        in
          aux L []
        end

fun cycle([], i) = []
  | cycle(lst,i) =
        let
          fun walk l acc 0 = l @ (reverse acc)
            | walk (h::t) acc k = walk t (h::acc) (k-1)
        in
          walk lst [] i
        end

