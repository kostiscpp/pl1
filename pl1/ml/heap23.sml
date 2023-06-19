datatype heap23 = Empty | Node2 of int * heap23 * heap23 | Node3 of int * int *
heap23 * heap23 * heap23;


fun isHeap23 Empty = true
  | isHeap23 hp3 =
        let  
          val s = (valOf Int.minInt);
         
          fun aux Empty _ = true
            | aux (Node2(x,n1,n2)) Maxsofar = if Maxsofar > x then false else
              (aux n1 x andalso aux n2 x)
            | aux (Node3(x,y,n1,n2,n3)) Maxsofar = if (x >= y orelse Maxsofar > x) then false
                                                   else  (aux n1 y  andalso aux n2 y andalso aux n3 y)
         in
           aux hp3 s
        end
