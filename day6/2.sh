#!/bin/sh
tr -d ' '  <in.txt | tr ':' ' ' | awk ' # rest is basically copypasted 1.sh
function ceil(x,     y){y=int(x); return(x>y?y+1:y)}
function draw(t,v,d) {return -v*v + t*v == d}
function calc(t,d){min=ceil((-t+sqrt(t**2-4*d))/(-2)); max=int((-t-sqrt(t**2-4*d))/(-2)); return max-min+1-draw(t,min,d)-draw(t,max,d)}
NR==1 {for(i=2;i<=NF;++i) TIMES[i]=$i}
NR==2 { mult=1; for(i=2;i<=NF;++i) {mult*=calc(TIMES[i], $i)} print mult}'

