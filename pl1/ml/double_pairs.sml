open Queue;


fun double_pairs [] = []
  | double_pairs (h::t) =
        let 
          val q = mkQueue();
          fun walk [] u X acc = rev (acc)
            | walk [x] u X acc = if x = 2*X then walk [] u X ((X,x)::acc) else
              (if isEmpty q then rev acc else walk [x] u (dequeue q) acc)
            | walk (x::xs) u X acc =
                if x = 2*X then
                  if isEmpty q then
                    walk (tl xs) u (hd xs) ((X,x)::acc)
                  else
                    walk xs u (dequeue q) ((X,x)::acc)
                else 
                  if x > 2*X then 
                    if isEmpty q then
                      walk xs u x acc
                    else
                      walk (x::xs) u (dequeue q) acc
                  else  
                    walk xs (enqueue (q, x)) X acc
        in
          (walk t () h [])
        end
