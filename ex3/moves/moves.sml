(* Helper function to read lines from a file *)
fun readLines filename =
    let
        val ins = TextIO.openIn filename
        fun readLines' ins =
            case TextIO.inputLine ins of
                 NONE => []
               | SOME line => line :: readLines' ins
    in
        readLines' ins before TextIO.closeIn ins
    end

(* Convert a string to a list of integers *)
fun stringToIntList s = map (fn x => valOf (Int.fromString x)) (String.tokens (fn c => c = #" ") s)

(* Parse the grid from the file *)
fun parseGrid filename =
    let
        val lines = readLines filename
        val N = valOf (Int.fromString (hd lines))
        val grid = Array2.fromList (map stringToIntList (tl lines))
    in
        (N, grid)
    end

(* Define possible moves and their directions *)
val directions = [(1, 0, "S"), (~1, 0, "N"), (0, 1, "E"), (0, ~1, "W"),
                  (1, 1, "SE"), (1, ~1, "SW"), (~1, 1, "NE"), (~1, ~1, "NW")]

(* Check if a move is valid *)
fun isValidMove N grid visited (row, col) currentCars =
    row >= 0 andalso row < N andalso col >= 0 andalso col < N andalso
    Array.sub (Array.sub (visited, row), col) = false andalso
    Array2.sub (grid, row, col) < currentCars

(* BFS to find the shortest path *)
fun bfs N grid =
    let
        val visited = Array.tabulate (N, fn _ => Array.array (N, false))
        val queue = Queue.mkQueue ()
        val _ = Queue.enqueue (queue, (0, 0, 0, [] : string list))
        val _ = Array.update (Array.sub (visited, 0), 0, true)

        fun bfs' () =
            case Queue.next queue of
                 NONE => "IMPOSSIBLE"
               | SOME (row, col, dist, path) =>
                   if row = N - 1 andalso col = N - 1 then
                       String.concatWith "," (List.rev path)
                   else
                       let
                           val currentCars = Array2.sub(grid, row, col)
                           val _ = List.app (fn (dr, dc, dir) =>
                               let
                                   val newRow = row + dr
                                   val newCol = col + dc
                               in
                                   if isValidMove N grid visited (newRow, newCol) currentCars then
                                       let
                                           val _ = Queue.enqueue (queue, (newRow, newCol, dist + 1, dir :: path))
                                           val _ = Array.update (Array.sub (visited, newRow), newCol, true)
                                       in
                                           ()
                                       end
                                   else
                                       ()
                               end) directions
                       in
                           bfs' ()
                       end
    in
        bfs' ()
    end

(* Main function *)
fun moves filename =
    let
        val (N, grid) = parseGrid filename
        val result = bfs N grid
    in
        if result = "IMPOSSIBLE" then
            print "IMPOSSIBLE\n"
        else
            print ("[" ^result ^ "]\n")
    end
