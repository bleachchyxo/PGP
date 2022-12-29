#!/bin/bash

generate_random() {
           tr -d '[:space:]\\' < /dev/urandom | head -c 256 /dev/urandom | xxd -p -u -c 256 | bc
}

p="$(generate_random)"
q="$(generate_random)"

n=$(echo "${p} * ${q}" | bc | sed -z 's=\\\n==g')

echo "$n"
