#!/bin/bash

for i in {3..9}
do
    echo "Test $i"
    if diff <(./a.out tree$i.txt) out$i.txt > /dev/null
    then
        echo "Test $i passed"
    else
        echo "Test $i failed"
    fi
done