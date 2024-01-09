#!/bin/sh
awk '{s+=$NF; while(!/^[0 ]*$/) {for(i=1;i<NF;++i) {$i=$(i+1)-$i} NF--; s+=$NF}} END{print s}' <in.txt
