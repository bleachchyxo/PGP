#!/bin/bash

generate_random() {

        head -c 256 /dev/urandom | xxd -p -u -c 256 | bc | tr -d '[:space:]\\'
}

p="$(generate_random)"
q="$(generate_random)"

n=$(echo "${p} * ${q}" | bc | tr -d '[:space:]\\')

echo "$n"
