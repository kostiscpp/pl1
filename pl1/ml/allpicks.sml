fun allpicks [] = []
  | allpicks L = 
        let 
          fun f x [] acc = rev acc
            | f x (h::t) acc = (if x = h then f x t acc else f x t (h::acc))
        in
        map (fn x => (x,f x L [])) L
        end
