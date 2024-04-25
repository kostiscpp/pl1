(* Hanoi towers algorithm *)

(* 1. Move n - 1 disks from source peg to aux peg
*  2. Move the biggest disk (from the bottom of start peg) to the destination
*  peg
*  3. Move the n - 1 disks from aux peg to destination peg *)

fun move_disk (s, d) = print ("Moving disk from " ^ s ^ " to " ^ d ^ "\n");

fun solve_hanoi (diskCount, source, destination, auxiliary) =
    if diskCount = 1 then
        move_disk (source, destination)
    else (
        solve_hanoi (diskCount - 1, source, auxiliary, destination);
        move_disk (source, destination);
        solve_hanoi (diskCount - 1, auxiliary, destination, source)
    );
