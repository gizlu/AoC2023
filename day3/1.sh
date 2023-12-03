#!/bin/sh
sed 's/./\0 /g' <in | awk '
function propagate(x, y) {
  X[x, (y-1)]; X[x, (y+1)]; X[(x+1), y]; X[(x-1), y]; X[(x+1), (y-1)]; X[(x-1), (y+1)]; X[(x+1), (y+1)]; X[(x-1), (y-1)] 
}
{for(i=1;i<=NF;++i) {MAP[NR,i]=$i; if($i~/[^.0-9]/) propagate(NR, i)}}
{MAX=NF}
function propag_num(x, y) {
  out =0; mult=1
  if(!(MAP[x,y]~/[0-9]/) || (x,y) in DONE) return 0
  for(i=y;i<=MAX&&MAP[x,i]~/[0-9]/;++i) {}
  for(i=i-1;i>0&&MAP[x,i]~/[0-9]/;i--) {DONE[x,i]; out+=MAP[x,i]*mult; mult*=10}
  # print x,y, out
  return out;
}
END { for(i in X) {split(i,sep,SUBSEP); s+=propag_num(sep[1],sep[2])} print s}'
# END { for(i in MAP) if(i in X){print i, "tak"}else{print i,"nie"}}'
