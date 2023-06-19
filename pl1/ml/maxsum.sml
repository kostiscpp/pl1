fun maxSum [] = 0
  | maxSum L =
      let
        fun aux s maxsum [] = maxsum
          | aux s maxsum (h::t) = aux (Int.max(h, (s+h))) (Int.max(maxsum,
          Int.max(h, (s + h)))) t
      in
        aux 0 0 L
      end

