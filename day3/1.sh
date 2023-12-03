#!/bin/sh
sed 's/./\0 /g' <in | awk '
{for(i=1;i<=NF;++i) if($i~/[^.0-9]/) { # save coords for later inspection
  X[NR, (i-1)]; X[NR, (i+1)]; X[(NR+1), i]; X[(NR-1), i]; 
  X[(NR+1), (i-1)]; X[(NR-1), (i+1)]; X[(NR+1), (i+1)]; X[(NR-1), (i-1)] 
}} {for(i=1;i<=NF;++i) MAP[NR,i]=$i}
function slurp(x, y,    i) { # read and remove num from map
  out=0;mult=1
  if(!(MAP[x,y]~/[0-9]/)) return 0; # not a num
  for(i=y;i<=NF&&MAP[x,i]~/[0-9]/;++i) {} # goto LSD
  for(i=i-1;i>0&&MAP[x,i]~/[0-9]/;--i) {out+=MAP[x,i]*mult; mult*=10; MAP[x,i]="."}
  return out;
}
END { for(i in X) {split(i,coords,SUBSEP); s+=slurp(coords[1],coords[2])} print s}'
