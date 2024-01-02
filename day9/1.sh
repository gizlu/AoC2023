#!/bin/sh
awk '{print; while(!/^[0 ]*$/) {for(i=1;i<NF;++i) {$i=$(i+1)-$i} NF--; print;}}' <in.txt| awk '/^[0 ]*$/ {print sum; next} {sum+=$NF}' | tail -n1
