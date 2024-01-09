#!/bin/sh
awk '{print; while(!/^[0 ]*$/) {for(i=1;i<NF;++i) {$i=$(i+1)-$i} NF--; print;}}' | awk 'BEGIN{sign=1} {sum+=sign*$1; sign=-sign} /^[0 ]*$/ {print sum; sign=1}'
# awk '{print; while(!/^[0 ]*$/) {for(i=1;i<NF;++i) {$i=$(i+1)-$i} NF--; print;}}'
