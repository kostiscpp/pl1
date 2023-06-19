fun lenfreqsort [] = []
  | lenfreqsort L = foldl (fn (d,n) => (foldl (fn (p,k) => #1 p :: k) [] ((#1
  d))::n) ) [] (ListMergeSort.sort (fn (a,b) => #2 a > #2 b) (foldl (fn (r,acc)=> if acc = [] then (r,1) else if (#1
                        #2 hd acc) = (#1 hd r) then ((r :: #1 hd acc), (#2 hd
                        acc + 1))::(tl acc) else ((r,1)::(tl acc)) (ListMergeSort.sort (fn w y => #2 w > #2
                        y )(map (fn x => (x, length x)) L)) []))



