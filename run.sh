#!/bin/bash

./program <(sed 's/;/;\n/g' input.txt | tac)| tac > output.txt

cat output.txt

