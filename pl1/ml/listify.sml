fun listify [] x = []
  | listify l x =
        let 
          fun walk [] _ (h::rest) = rev (rev h :: rest)
            | walk (h::t) _ [] = if h < x then walk t 1 [[h]] else walk t 0
            [[h],[]]
            | walk (h::t) 1 ((y::ys)::rest) = 
                if h < x then 
                  walk t 1 ((h::y::ys)::rest) 
                else 
                  if y < x then
                   walk t 0 ([h]::(rev(y::ys))::rest)
                  else
                    walk t 0 ([h]::[]::(rev(y::ys))::rest)
            | walk (h::t) 0 ((y::ys)::rest) =     
               if h >= x then 
                 walk t 0 ((h::y::ys)::rest) 
               else 
                 if y >= x then
                   walk t 1 ([h]::(rev(y::ys))::rest)
                 else
                   walk t 1 ([h]::[]::(rev(y::ys))::rest)
        in
          walk l 1 []
        end
