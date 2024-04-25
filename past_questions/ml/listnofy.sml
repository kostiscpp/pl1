fun listify [] = []
  | listify (h::t) = 
        let 
          fun aux [] (hacc::tacc) = rev ((rev hacc) :: tacc)
            | aux (x::xs) ((y::ys)::rest) = 
            if x > y then aux xs ((x::y::ys)::rest) 
            else aux xs ([x]::(rev (y::ys))::rest)
        in
          aux t [[h]]
        end

