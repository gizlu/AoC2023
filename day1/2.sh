awk 'BEGIN{for(i=1; i<=9; ++i) MAP[i] = i
MAP["one"]=1;MAP["two"]=2;MAP["three"]=3;MAP["four"]=4;MAP["five"]=5;
MAP["six"]=6;MAP["seven"]=7;MAP["eight"]=8;MAP["nine"]=9 
digit_re = "(one|two|three|four|five|six|seven|eight|nine|[0-9])"}
{match($0, digit_re, l); match($0, ".*"digit_re, r); s += MAP[l[1]]*10+MAP[r[1]] }
END {print s}'<input-1
