- Get the last matching from the file: `grep "####" Tree.md | tail -1`
- Copy file from windows to linux(https://community.nxp.com/thread/220596) or vice versa:
``` javascript
1. install Putty
2. open cmd in windows
set PATH=C:\Program Files\PuTTY 
pscp D:\data.js username@10.0.0.4
pscp username_linux_machine@ip_of_linux_machine:/home/ubuntu/myfile.ext C:\Users\Name\Downloads
```

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

#### 2. [#2](https://stackoverflow.com/questions/2514172/listing-each-branch-and-its-last-revisions-date-in-git) List git branch by last modified time ?
```javascript
for k in `git branch | sed s/^..//`; do echo -e `git log -1 --pretty=format:"%Cgreen%ci %Cblue%cr%Creset" $k --`\\t"$k";done | sort -r
```
