tr -d 'a-z' <input-1 | awk -F '' '{s+=$1*10+$NF} END{print s}'
