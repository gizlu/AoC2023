#!/bin/sh
sed 's/./\0 /g'<in| awk '
function propagate(x, y) {
  X[x,y,x, (y-1)]; X[x,y,x, (y+1)]; X[x,y,(x+1), y]; X[x,y,(x-1), y]; X[x,y,(x+1), (y-1)]; X[x,y,(x-1), (y+1)]; X[x,y,(x+1), (y+1)]; X[x,y,(x-1), (y-1)] 
}
{for(i=1;i<=NF;++i) {MAP[NR,i]=$i; if($i=="*"){ GEAR_RATIO[NR,i]=1; propagate(NR, i)}}}
{MAX=NF}
function propag_num(x0,y0,x, y) {
  # print x,y
  out =0; mult=1
  if(!(MAP[x,y]~/[0-9]/) || (x,y) in DONE) return 0
  for(i=y;i<=MAX&&MAP[x,i]~/[0-9]/;++i) {}
  for(i=i-1;i>0&&MAP[x,i]~/[0-9]/;i--) {DONE[x,i]; out+=MAP[x,i]*mult; mult*=10}
  PARTS[x0,y0]+=1;
  GEAR_RATIO[x0,y0]*=out;
  # print("chuj"x0,y0,out,GEAR_RATIO[x0,y0])
}
END { for(i in X) {split(i,sep,SUBSEP); propag_num(sep[1],sep[2],sep[3],sep[4])}}
END { for(i in GEAR_RATIO) {if(PARTS[i]==2) s+=GEAR_RATIO[i]}}
END {print s}'
# END { for(i in X) {split(i,sep,SUBSEP); s+=propag_num(sep[1],sep[2])} print s}'
# END { for(i in MAP) if(i in X){print i, "tak"}else{print i,"nie"}}'
