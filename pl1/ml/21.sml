fun split n L =
        let fun aux 0 acc L = (rev acc, L)
                | aux n acc [] = (acc, [])
                | aux n acc (h :: t) = aux (n-1) (h::acc) t
        in aux n [] L
        end
