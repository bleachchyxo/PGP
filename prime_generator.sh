#!/bin/bash

hexadecimalGenerator() {
        xxd -p -u /dev/urandom | head -c 260 | tr -d '[:space:]\\'
}

p="$(hexadecimalGenerator)"
q="$(hexadecimalGenerator)"

primalityTest() {

        #base generation
        local n=$1
        baseMaximumLimit="$(echo "obase=16;ibase=16; ${n} - 2" | bc | tr -d '[:space:]\\')"
        baseRange="$((1+RANDOM%260))"
        randomValue="$(xxd -p -u /dev/urandom | head -c $baseRange | tr -d '[:space:]\\')"
        baseMinimumLimit="$(echo "obase=16;ibase=16; ${randomValue} + 2" | bc | tr -d '[:space:]\\')"
        base="$(echo "obase=16;ibase=16; ${baseMinimumLimit} % ${baseMaximumLimit}" | bc | tr -d '[:space:]\\')"

        #quotient
        subtraction="$(echo "obase=16;ibase=16; ${n} - 1" | bc | tr -d '[:space:]\\')"
        dividend="$subtraction"

        while [[ "${remainder}" -eq "0" ]]
        do
                division="$(echo "obase=16;ibase=16; ${dividend} / 2" | bc | tr -d '[:space:]\\')"
                remainder="$(echo "obase=16;ibase=16; ${dividend} % 2" | bc | tr -d '[:space:]\\')"
                quotient="$dividend"
                dividend="$division"
        done

        x="$(echo "obase=16;ibase=16; ${base} % ${n}" | bc | tr -d '[:space:]\\')"
        b="$(echo "obase=2;$quotient" | bc | tr -d '[:space:]\\')"
        for ((i=0; i<${#b}; i++)) do
                cache=${b:$i:1}
                [[ $cache == 0 ]] && x="$(echo "obase=16;ibase=16; ${x} * ${x} % ${n}" | bc | tr -d '[:space:]\\')" || x="$(echo "obase=16;ibase=16; ${x} * ${base} % ${n}" | bc | tr -d '[:space:]\\')"
        done

        echo $x
}

b=$(primalityTest $q)

echo "$b"
