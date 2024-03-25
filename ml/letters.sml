(* ADD YOUR LETTER VALUES HERE *)
val E = [[1, 1, 1, 1, 1], [1, 0, 0, 0, 0], [1, 1, 1, 1, 1], [1, 0, 0, 0, 0],
[1, 1, 1, 1, 1]];

val L = [[0, 0, 1, 0, 0], [0, 1, 1, 1, 0], [0, 1, 0, 1, 0], [1, 0, 0, 0, 1],
[0, 0, 0, 0, 0]];

(* Functions to print a row and a letter respectively *)
fun printRow [] = ()
  | printRow (0::xs) = (print " "; printRow xs)
  | printRow (1::xs) = (print "*"; printRow xs);

fun printLetter [] = ()
  | printLetter (x::xs) = (printRow x; print "\n"; printLetter xs);



