#!/bin/sh
awk -F '[:;]' '{for(i=2;i<=NF;++i) print substr($1,6),$i}'<in | tr -d ',' | awk '
{GAMES[$1]; for(i=2;i<NF;i+=2) if($i > ARR[$1, $(i+1)]) ARR[$1, $(i+1)] = $i}
END {for(i in GAMES) {s += ARR[i, "red"]*ARR[i,"blue"]*ARR[i,"green"]} print s} '
