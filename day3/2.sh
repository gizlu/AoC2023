#!/bin/sh
sed 's/./\0 /g' <short | awk '
{for(i=1;i<=NF;++i) if($i=="*") { # save cords for later inspection
  GEAR_RATIO[NR,i]=1;
  X[NR,i,NR,i-1]; X[NR,i,NR,i+1]; X[NR,i,NR+1,i]; X[NR,i,NR-1,i]; 
  X[NR,i,NR+1,i-1]; X[NR,i,NR-1,i+1]; X[NR,i,NR+1,i+1]; X[NR,i,NR-1,i-1] 
}} {for(i=1;i<=NF;++i) MAP[NR,i]=$i}
function slurp(gear_x, gear_y, x, y,   i) { # read num, remove from map and update gear ratio
  out=0;mult=1
  if(!(MAP[x,y]~/[0-9]/)) return 0; # not a num
  for(i=y;i<=NF&&MAP[x,i]~/[0-9]/;++i) {} # goto LSD
  for(i=i-1;i>0&&MAP[x,i]~/[0-9]/;--i) {out+=MAP[x,i]*mult; mult*=10; MAP[x,i]="."}
  PARTS[gear_x, gear_y]+=1;
  GEAR_RATIO[gear_x, gear_y]*=out;
}
END { for(i in X) {split(i,cords,SUBSEP); slurp(cords[1],cords[2],cords[3],cords[4])}}
END { for(i in GEAR_RATIO)if(PARTS[i]==2) s+=GEAR_RATIO[i]} END {print s}'
