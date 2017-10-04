# String
#### 1. [Leetcode#14](https://leetcode.com/problems/longest-common-prefix/description/) Longest Common Prefix ?
Vertical scan every char of each string in the array
``` JavaScript
/**
 * @param {string[]} strs
 * @return {string}
 */
var longestCommonPrefix = function(strs) {
    if (strs === null || strs.length === 0) {
        return "";
    }
    
    var prefix = strs[0];
    for (var i = 0; i < prefix.length; i++) {
        var c = prefix[i];
        for (var j = 0; j < strs.length; j++) {
            var c1 = strs[j][i];
            if (i === strs[j].length || c !== c1) {
                return prefix.substring(0, i);
            }
        }
    }
    
    return prefix;
};
```
#### 2. [Leetcode#28](https://leetcode.com/problems/implement-strstr/description/) Implement strStr() ?
- Two nested for loops
```javascript
/**
 * @param {string} haystack
 * @param {string} needle
 * @return {number}
 */
var strStr = function(haystack, needle) {
    for(var i = 0; i <= haystack.length - needle.length; i++){
        for(var j = 0; j < needle.length; j++){
            if(haystack[i+j] !== needle[j]){
                break;
            }
        }
        if(j === needle.length){
            return i;
        }
    }
    return -1;
};
```
