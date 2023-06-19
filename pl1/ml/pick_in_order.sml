fun pick_in_order [] = []
  | pick_in_order lists = 
        let
          fun pickfirst [] [] acc = rev acc
            | pickfirst [] help acc = pickfirst (rev help) [] acc
            | pickfirst ([]::rest) help acc = pickfirst rest help acc
            | pickfirst ((x::xs)::rest) help acc = pickfirst rest (xs::help) (x::acc) 
         in
          pickfirst lists [] []
         end
