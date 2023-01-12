#!/bin/bash

hexadecimalGenerator() {

        head -c 256 /dev/urandom | xxd -p -u -c 256 | tr -d '[:space:]\\'

}

witnessGenerator() {

        witnessLimit=$(echo "obase=16;ibase=16; ${n} - 2" | bc | tr -d '[:space:]\\')
        randomHexNumber="$(cat /dev/urandom | tr -dc '0-9' | head -c $((${#n} + 1)))"
        randomModulus="$(echo "obase=16;ibase=16; ${randomHexNumber} % ${witnessLimit}" | bc | tr -d '[:space:]\\')"

        echo "obase=16;ibase=16; ${randomModulus} + 2" | bc | tr -d '[:space:]\\'

}

p="$(hexadecimalGenerator)"
q="$(hexadecimalGenerator)"
n=$(echo "obase=16;ibase=16; ${p} * ${q}" | bc | tr -d '[:space:]\\')
witness="$(witnessGenerator)"
predecessor="$(echo "obase=16;ibase=16; ${n} - 1" | bc | tr -d '[:space:]\\')"
squareWitness="$(echo "obase=16;ibase=16; ${witness} * ${witness}" | bc | tr -d '[:space:]\\')"
witnessRemainder="$(echo "obase=16;ibase=16; ${squareWitness} % ${n}" | bc | tr -d '[:space:]\\')"

squareRemainder="$(echo "obase=16;ibase=16; ${witnessRemainder} * ${witnessRemainder}" | bc | tr -d '[:space:]\\')"
witnessRemainder="$(echo "obase=16;ibase=16; ${squareWitness} % ${n}" | bc | tr -d '[:space:]\\')"
