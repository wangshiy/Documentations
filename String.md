# String
#### 1. Longest Common Prefix ?
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