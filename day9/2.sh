#!/bin/sh
awk '{sign=1; while(!/^[0 ]*$/) { s+=sign*$1; for(i=1;i<NF;++i) {$i=$(i+1)-$i} NF--; sign=-sign}} END{print s}' <in.txt
