fun allpicks [] = []
  | allpicks L =
        let
          val index = rev(foldl (fn (x,acc) => (if acc = [] then [1] 
                                                else ((hd acc+1)::acc) )) [] L)
          fun f _ [] (v,acc) = (v,rev acc)
            | f 1 (h::t) (v,acc) = f 0 t (h,acc)
            | f i (h::t) (v,acc) = f (i-1) t (v,h::acc) 
        in 
          map (fn x => (f x L (0,[]))) index
        end
