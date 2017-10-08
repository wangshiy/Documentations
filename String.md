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

#### 3. [Leetcode#151](https://leetcode.com/problems/reverse-words-in-a-string/description/) Reverse Words in a String ?
- Trim leading, traling and between spaces
```javascript
/**
 * @param {string} str
 * @returns {string}
 */
var reverseWords = function(str) {
    var strArray = str.split(" ").filter(function(e) {
        return e !== "" && e !== " ";
    });
    return strArray.reverse().join(" ");
};
```

#### 4. [Leetcode#557](https://leetcode.com/problems/reverse-words-in-a-string-iii/description/) Reverse Words in a String III ?
- Based on single space condition, reverse each word between i,j index
```javascript
/**
 * @param {string} s
 * @return {string}
 */
var reverseWords = function(s) {
    var i = 0,
        result = s.split("");
    for (var j = 0; j < s.length; j++) {
        if (s[j] === " ") {
            reverse(result, i, j-1);
            i = j + 1;
        }
    }

    reverse(result, i, j);

    return result.join("");
};

function reverse(str, i, j) {
    var temp;
    while (i < j) {
        temp = str[i];
        str[i] = str[j];
        str[j] = temp;
        i++;
        j--;
    }
}
```
