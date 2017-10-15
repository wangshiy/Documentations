- Get the last matching from the file: `grep "####" Tree.md | tail -1`

#### 1. [#1](null) Convert column data to json ?
- `read -r line`
```javascript
#!/bin/bash
# awk '$0="{longitude:"$0",count:1}"' data.js > data2.js
####
# Input: (need an additional space and one new line from the input data)
#119.17205	36.73057 
#119.173	36.73057 
#119.17305	36.73057 
#119.1731	36.73057 
#119.173	36.73067 
#119.17305	36.73067 
#
####
while IFS=$' \t\n\r' read -r line
do
    counter=0
    for word in $line
    do
    	if [ $counter = 0 ];then
    		part1="longitude:"$word
    	elif [ $counter = 1 ];then
    		part2="latitude:"$word
    	fi
    	counter=$(($counter+1))
    done
	echo "{"$part1","$part2",count:1}" >> data2.js
done < "$1"
```
