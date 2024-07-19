fun same_base x n v = 
    if x >= n then (if (x mod n) = v then same_base (x div n) n v else false)
    else x = v
fun find_base n x = if (x+1) = n orelse same_base (x div n) n (x mod n) then n else find_base (n+1) x
fun minbases l = List.map (find_base 2) l 