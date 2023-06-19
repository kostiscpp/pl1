fun allsubseq S =
        let 
          fun nonempty [] = []
          | nonempty (x::xs) =
                let 
                  fun walk [] acc = acc
                    | walk (y::ys) acc =
                        walk ys ((x::y)::y::acc)
                in
                  walk (nonempty xs) [[x]]
                end
        in
          nonempty S
        end


                 
