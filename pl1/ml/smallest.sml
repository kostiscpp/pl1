(* SML programming, lab No2.
 * Task: Define a function 'smallest' that takes a list L of natural
 * numbers and returns the minimum natural number not in L.
 * You may assume that L contains no duplicates (but try to see
 * how far you can go without this assumption).
 *
 * Note: Natural numbers: 0, 1, 2, 3, 4 ...
 *
 * Examples:
 *      smallest [] = 0
 *      smallest [0] = 1
 *      smallest [1, 2, 3] = 0
 *      smallest [0, 1, 3] = 2
 *      smallest [0, 1, 2, 3] = 4
 *      smallest [6, 3, 2, 1, 7, 0, 4, 5] = 8
 *      smallest [42] = 0
 *
 * Note: This file is written in the 'literate programming' style.
 * It is meant to be read, but you are encouraged to load it
 * on the interpreter and have some functional fun. :)
 *)

(* ==== *)

(* A simple approach: Begin with num = 0. On each iteration, check
 * if 'num' is in L. If not, 'num' is the answer. Otherwise, increase 'num'
 * by 1 and try again.
 *
 * Complexity: O(n * |L|), where n is the answer, |L| is the list's length.
 *
 * Needed:
 * (1) A function 'elem' to check if num is in L
 * (2) A function 'loop' to loop over num = 0, 1, 2, 3, 4 ...
 *     until 'elem' returns true for some num.
 *)

(* Let's build 'elem'.
 *  elem: ''a -> ''a list -> bool
 *)
fun elem num []        = false
  | elem num (x :: xs) = if num = x then true else elem num xs

(* Note: The last clause can also be written as
 *  elem num (x :: xs) = num = x orelse elem num xs
 * Do you see why?
 *
 * Quiz: Why 'elem' produces a warning?
 *
 * Hint: Take a close look at the type of elem. Turns out it is
 * not easy to reconcile equality and polymorphism.
 *
 * Exercise: Taking into account that 'elem' will be used only
 * with int lists, add a type annotation that silences the warning.
 *)

(* Let's build 'loop'.
 *  loop: int -> int list -> int
 *)
fun loop num l = if elem num l then loop (num + 1) l else num

(* Given the above functions, the first implementation of smallest
 * is as follows:
 *)
fun smallest1 l = loop 0 l

(* Good style suggestion:
 * Since the problem only asks for function "smallest", we can hide the
 * rest of definitions inside a local ... in ... end construct.
 *
 * All functions and values defined in the local ... in part are visible
 * to each other and to the in ... end part, but not anywhere else.
 *
 * All functions and values defined in the in ... end part are visible
 * outside the construct but not inside the local ... in part.
 *
 * Note: This is not equivalent to a let ... in ... end construct,
 * because the in ... end part doesn't return a value, but only
 * exports definitions.
 *
 * So, more compactly:
 *
 *  local
 *      fun elem num [] = false
 *        | elem num (x :: xs) = if num = x then true else elem num xs
 *
 *      fun loop num l = if elem num l then loop (num + 1) l else num
 *  in
 *      fun smallest1 l = loop 0 l
 *  end
 *)

(* === *)

(* The above solution is wasteful. Perhaps we could do better if we
 * preprocessed the list so as to avoid traversing it repeatedly.
 * ...
 * Let's sort! If the list is sorted in ascending order, the
 * number we seek will appear as a "gap" between two non-consecutive numbers.
 *   smallest [0, 1, 2, ..., 7, 10, 11, 12, ...] = 8
 * We can detect this number with a single traversal of the list.
 *
 * Edge cases: If no such gap exists, then:
 * i)  if 0 doesn't appear in the list, then the answer is just 0.
 * ii) if 0 does appear, then since L contains no duplicates,
 *     L must contain *exactly* all natural numbers in the range [0, |L|).
 *     In that case, the answer is |L|.
 *
 *      smallest [] = 0
 *      smallest [0] = 1
 *      smallest [0, 1] = 2
 *      smallest [0, 1, 2] = 3
 *      ...
 *
 *     If the examples didn't convince you, prove it.
 *     Hint: Pidgeonhole principle might come handy.
 *
 *
 * Complexity: O(|L| * log |L|), assuming a *good* sorting is used.
 *
 * Note: In the worst case, the answer n will be as large as |L|.
 * Therefore, this version has a much better worst case complexity
 * than the previous one (|L|^2 >> |L| * log|L|).
 *
 * Needed:
 * (1) A function 'sort' that sorts a list in ascending order
 * (2) A function 'get_first_gap' that finds the first "gap"
 *       in a sorted list, and also checks for the edge cases.
 *)

(* Let's build 'sort'.
 * sort: 'a list -> 'a list
 *
 * We can use a standard merge sort like the one in the slides:
 * http://courses.softlab.ntua.gr/pl1/2013a/Slides/lecture-04.pdf
 *
 * fun halve nil = (nil, nil)
 *   | halve [a] = ([a], nil)
 *   | halve (a::b::cs) =
 *      let
 *          val (x, y) = halve cs
 *      in
 *          (a::x, b::y)
 *     end
 *
 * fun mergeSort nil = nil
 *   | mergeSort [a] = [a]
 *   | mergeSort theList =
 *      let
 *          val (x, y) = halve theList
 *      in
 *          merge (mergeSort x, mergeSort y)
 *      end
 *
 * ... or we can use the SML/NJ Library:
 * http://www.smlnj.org/doc/smlnj-lib/Manual/listsort.html
 *
 * fun sort l = ListMergeSort.sort (op >) l
 *
 * Quiz: What should we do to sort the list in descending order?
 *)

(* Let's build 'get_first_gap'.
 *
 * We need to keep track of the smallest number N we haven't seen yet
 * as well as the part of the list we haven't traversed yet.
 * On each iteration, we check if the head of the remaining list equals N.
 * If it doesn't or if the list is empty, N is the answer.
 * Otherwise, we increase N by 1 and recurse on the tail of the list.
 *
 * If we start with N = 0, all edge cases are handled nicely.
 *
 * get_first_gap: int -> int list -> int
 *)

(* All this, together. *)
local
  fun sort l = ListMergeSort.sort (op >) l

  fun get_first_gap n [] = n
    | get_first_gap n (x :: xs) = if n = x then get_first_gap (n + 1) xs else n
in
  fun smallest2 l = get_first_gap 0 (sort l)
(* or, using function composition:
 *      val smallest2 = (get_first_gap 0) o sort
 *)
end

(* WARNING:
*
*  ListMergeSort might not work out of the box on a Debian machine.
*  The reason is that is usually not installed when executing
*       apt-get install smlnj
*
*  Solution:
*       apt-get install libsmlnj-smlnj
*)

(* === *)

(* Time for some testing.
* First, define some testcases. A testcase is a triple:
*   (name_of_testcase, input, expected_output)
* Many testcases can be packed in a single list, the testsuite.
*
* Second, define a function 'runtests' that tests a candidate
* function f against the testsuite by invoking f on each testcase
* and checking if the output of f conforms to the one expected.
* After each test, it prints a diagnostic mesage to the user and
* continues with the next test. Once it has run out of tests, it stops...
*
* ...but a 'functional' function doesn't just stop; it has to return
* a value! Since 'runtests' will be just printing out messages,
* there is no value to return. Instead, we will return the *unit constant*,
* that is, the 'trivial' value represented by (). This combines nicely
* with the type of 'print', which also returns unit, and the sequencing
* operator, that is, the semicolon ';'.
*
* For ease of use, we wrap 'runtests' inside a 'test_smallest' function
* that accepts a candidate implementation and bombards it with the
* predefined testsuite.
*
* By the way, 'runtests' produces the same warning as elem.
* You know what to do to fix it...
*)

local
    val testsuite = [
      ("empty", [], 0),
      ("zero", [0], 1),
      ("one", [1], 0),
      ("upto3", [0, 1, 2, 3], 4),
      ("reverse3", [3, 2, 1, 0], 4),
      ("gap1", [0, 2, 3], 1),
      ("gap8-9", [0, 1, 2, 3, 4, 5, 6, 7, 10, 11, 12], 8),
      ("shuffle7", [4, 2, 5, 0, 3, 6, 1, 8], 7),
      ("fortytwo", [42], 0)
  ]

    fun runtests f [] = ()
      | runtests f ((name, input, output) :: testcases) = (
          print ("Testcase " ^ name ^ ": ");
          if f input = output then print "OK\n"
          else                     print "FAILED!!!\n";
          runtests f testcases
        )
in
  fun test_smallest f_smallest = runtests f_smallest testsuite
end

(* Coming up next: Advanced implementations... *)

(* === *)

(*
* Version 3: Assume m is the length of the list. Use an array to
* detect all numbers less than m appearing on the list. Walk the
* array and find the first "gap".
* Complexity: O(|L|).
*)
local
  (* Attention: fillArray MUST return the modified array,
  * otherwise the version won't work properly. *)
  fun fillArray arr _ [] = arr
    | fillArray arr len (x :: xs) =
        (if x < len then Array.update(arr, x, true) else ();
        fillArray arr len xs)

  fun get_first_gap arr len idx =
        if idx >= len then idx
        else if Array.sub(arr, idx) then get_first_gap arr len (idx + 1)
        else idx
in
  fun smallest3 l =
    let
      val len = length l
      val presentArr = Array.array (len, false)
      val filledArr = fillArray presentArr len l
    in
      get_first_gap filledArr len 0
    end
end

(* Some additional theory:
 *     Think: By pidgeonhole principle, if L contains a number larger
 *     than |L| - 1, it misses some number smaller than |L|. That
 *     number is a gap, though perhaps not the smallest one.
 *
 *     Lemma: Suppose L' is the list formed by filtering out
 *     all numbers N in L for which N >= |L|. Then, the previous
 *     paragraph implies that
 *          smallest L == smallest L'
 *
 *     This lemma can be applied recursively to find the solution:
 *          smallest [0, 2, 3, 5, 100, 200]  (* filter out numbers >= 6 *)
 *          = smallest [0, 2, 3, 5]          (* filter out numbers >= 4 *)
 *          = smallest [0, 2, 3]             (* filter out numbers >= 3 *)
 *          = smallest [0, 2]                (* filter out numbers >= 2 *)
 *          = smallest [0]                   (* filter out numbers >= 1 *)
 *          = smallest [0]                   (* list didn't change, so... *)
 *          = 1                              (* ... length of list is the answer *)
 *
 *)

(* === *)

(*
 * Version 4: Similar to version 3 but using a purely functional data
 * structure, instead of an Array, for storing the seen elements.
 * The BinarySetFn functor implements balanced binary trees, where
 * searching for an element cost O(NlogN).  It is described here:
 * http://www.smlnj.org/doc/smlnj-lib/Manual/binary-set-fn.html
 * Notice how similar this version is to version 1!
 * This teaches us that keeping the same algorithm but changing the
 * data structure can give us a huge difference in performance.
 * By comparing to version 3, which uses an Array for storing the
 * presence of elements that can be searched in O(1) time, this also
 * teaches us that imperative data structures can easily be simulated
 * by purely functional ones at an additional logarithmic cost.
 * Complexity: O(|L| * log |L|).
 *)

local
  structure S = BinarySetFn(struct
    type ord_key = int
    val compare = Int.compare
  end)

  fun loop num s =
    if S.member (s, num) then loop (num + 1) s else num
in
  fun smallest4 l = loop 0 (S.addList (S.empty, l))
end

(* === *)

(*
* Version 5: Use a Decrease and Conquer strategy:
*
* Let's generalize the problem a bit; instead of asking the
* smallest natural number that doesn't appear in the list,
* let's ask of the smallest missing natural number NO LESS
* than some other natural number M, where M is given by the user.
* Suppose "smallest_limit" is the name of the function we seek to
* build:
*
* smallest_limit: int -> int list -> int
*
*  Examples:
*       smallest_limit 0 [] = 0   (* no surprises here *)
*       smallest_limit 42 [] = 42 (* empty list => M is the minimum missing number *)
*       smallest_limit 0 [0] = 1  (* no surprises here *)
*       smallest_limit 1 [0] = 1  (* no surprises here, either *)
*       smallest_limit 2 [0] = 2  (* 1 is not in the list, but 1 < 2 *)
*       smallest_limit 0 [1, 2, 3] = 0
*       smallest_limit 4 [6, 7, 8] = 4
*       smallest_limit 4 [2, 4, 5] = 6
*
* Exercise: Verify that smallest l == smallest_limit 0 l
* It is indeed a generalisation.
*
* Why is smallest_limit useful? Because it allows us to tackle the problem
* of finding the minimum missing natural number like this:
* 1) Pick a natural number M such that all naturals less than M are in list L.
* 2) Partition L into L1 and L2, where all numbers in L1 are less than M.
* 3) Since L doesn't have duplicates and L1 contains ALL naturals less than M,
*    the answer must be at least M. All elements at least as large as M are
*    in L2.
* 4) The answer to the original problem is the smallest missing natural in L2
*    that is no less than M.
*
* So, if we can find an appropriate number M and partition L accordingly:
*   smallest L == smallest_limit M L2
*
* Since smallest L == smallest_limit 0 L, then, by replacement:
*   smallest_limit 0 L = smallest_limit M L2
*
* This is an improvement, for 2 reasons:
* 1) We are closing in on the answer: it must be at least as great as M.
* 2) We are reducing the amount of elements we have to process, because the
*    recursive call ignores all the elements in L1. In the recursive call,
*    we shall find some M' > M and partition L2 into L2_1 and L2_2
*    such that L2_1 contains ALL natural numbers in the range [M, M').
*    Then, the answer must be at least M' and thus:
*
*       smallest_limit M L2 == smallest_limit M' L2_2
*
*    ... and so on. At some point, the list should run out of elements,
*    at which point the answer is the current M.
*
* If we can find these magic numbers, M, M' etc, then we are done.
*
* Q: How do we find these numbers?
* A: We don't.
* Q: So all that theory is useless?
* A: No, because we can make educated guesses.
* Q: What happens if we are wrong?
* A: We adapt.
* Q: Can you explain?
* A: Of course!
*
* Assume a list L of natural numbers (without duplicates) no less than M.
* Pick P = M + 1 + |L| div 2 as pivot and partition L to L1 and L2. Two cases:
* 1) If L contains ALL elements no less than M and less than P, then the
*    smallest missing element of L is in the range [P, |L|) or is |L|. Thus,
*    we need only consider the list L2, which contains less than half of the
*    original elements, because |L1| = P - M = |L| div 2 + 1.
*    Picking P as the new M:
*       smallest_limit M L = smallest_limit P L2
*
* 2) Otherwise, there is a missing natural number in [M, P) and we need only
*    consider list L1, which has length at most P - M - 1, because there is
*    a hole in the range. Thus |L1| <= |L| div 2 and:
*       smallest_limit M L = smallest_limit M L1
*
* Either way, we reduce the number of elements in the list by half on
* each recursive call. Each call has complexity linear in the size of the
* resulting list. Thus, the recurrence relation for the complexity
* of smallest_limit is:
*   T(|L|) = T(|L| / 2) + O(|L|)
*
*  This has solution T(|L|) = O(|L|).
*
*  The implementation below is a direct translation of the ideas
*  above.
*)
local
  fun smallest_limit m [] = m
    | smallest_limit m l =
    let
      val cur_len = length l
      val pivot = m + 1 + (cur_len div 2)
      val (low, high) = List.partition (fn x => x < pivot) l
      val low_len = length low
    in
      if low_len = pivot - m then
          smallest_limit pivot high
      else
          smallest_limit m low
    end
in
  fun smallest5 l = smallest_limit 0 l
end

(* === *)

(*
* Version 6: Some final optimizations
*
* Though we cannot improve the asymptotic complexity of the solution
* any further, there is still one performance optimisation we can implement:
*
* Avoid redundant calculations of list lengths. There are at least 2 ways to
* achieve that:
* 1) Track list lengths and pass them along in recursive calls using more
*    arguments. For example, in the following code,
*
*     if lowlen = pivot - m then smallest_limit pivot high
*     else smallest_limit m low
*
*   we know that in the case of the recursive call
*       smallest_limit pivot high
*   the length of the list "high" is cur_len - low_len. We can pass
*   that information along, so that the recursive call won't need to
*   call length in order to find out the new cur_len. Similarly, in
*       smallest_limit m low
*   the length of "low" is low_len
*
* 2) Calculate the length of the list as a side-result of another
*    operation done on the same list. In our case, we can calculate
*    the length of the "low" list while partitioning it; but we will
*    have to code List.partition ourselves. Re-inventing the wheel
*    and re-implementing the library is almost never a good idea,
*    but, with moderation, it can be fun and educating.
*
*  All these ideas are combined in the code below. Notice
*  the profuse usage of pattern matching.
*
*  It's OK if you don't understand this code completely or cannot
*  reproduce it easily. Study it until you get bored or enlightened.
*)
local
  fun partition_len _ [] acc = acc
    | partition_len p (x :: xs) ((len1, l1), (len2, l2)) =
        if p x then
            partition_len p xs ((len1 + 1, x :: l1), (len2, l2))
        else
            partition_len p xs ((len1, l1), (len2 + 1, x :: l2))

  fun smallest_limit m cur_len [] = m
    | smallest_limit m cur_len l =
    let
      val pivot = m + 1 + (cur_len div 2)
      val ((low_len, low), (high_len, high)) =
        partition_len (fn x => x < pivot) l ((0, []), (0, []))
    in
      if low_len = pivot - m then
          smallest_limit pivot high_len high
      else
          smallest_limit m low_len low
    end
in
  fun smallest6 l = smallest_limit 0 (length l) l
end

(* NOTE:
* For the OCaml lovers:
* http://typeocaml.com/2015/02/02/functional-pearl-no-1-the-min-free-nature/
*)
