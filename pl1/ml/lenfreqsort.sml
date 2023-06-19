fun lenfreqsort lst =
    let
        fun countLen(lst , []) = [(length lst, 1)]
              | countLen(lst,(len, count)::rest) = if len = length lst then (len, count + 1)::rest else (len, count)::countLen(lst, rest)
        fun compareFreq((len1, freq1), (len2, freq2)) = if freq1 = freq2 then len1 < len2 else freq1 < freq2
    in
        List.concat (map (fn (len, _) => List.filter (fn lst => length lst = len) lst) (ListMergeSort.sort compareFreq (foldl (fn (lst, counts) => countLen(lst, counts)) [] lst)))
    end

