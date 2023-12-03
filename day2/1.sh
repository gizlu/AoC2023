#!/bin/sh
awk -F '[:;]' '{for(i=2;i<=NF;++i) print substr($1,6),$i}' <in | tr -d ',' | awk '
BEGIN{LIM["red"]=12;LIM["green"]=13;LIM["blue"]=14}
{GAMES[$1]; for(i=2;i<NF;i+=2) if($i > LIM[$(i+1)]) FAIL[$1]}
END {for(i in GAMES) {if(!(i in FAIL)) s+=i} print s}'
