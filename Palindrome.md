#### 1. [Leetcode#9](https://leetcode.com/problems/palindrome-number/description/) Palindrome Number ?
- construct the left and right half and then compare
```javascript
/**
 * @param {number} x
 * @return {boolean}
 */
var isPalindrome = function(x) {
    if (x < 0 || (x !== 0 && x % 10 === 0))
      return false;
    var rem = 0;
    while (x > rem) {
      rem = rem * 10 + x % 10;
      x = Math.floor(x / 10);
    }

    return x === rem || x === Math.floor(rem / 10);
};
```
#### 2. [Leetcode#5](https://leetcode.com/problems/longest-palindromic-substring/description/) Longest Palindromic Substring ?
- for loop traverse whole string and at each point expand to left and right as possible
```javascript
/**
 * @param {string} s
 * @return {string}
 */

var expandFromCenterAndCheckForPalindrome = function(s, left, right){
    while(left >= 0 && right < s.length && s[left] === s[right]){
        left--;
        right++;
    }
    
    return s.substring(left+1, right);
}

var longestPalindrome = function(s) {
    if(s === null || s.length === 0){
        return "";
    }    
    
    var result = "";
    var len = s.length;
    var left, right;
    
    for(var i = 0; i < len; i++){
        left = right = i;

        // handle single center case aba
        var str = expandFromCenterAndCheckForPalindrome(s,left,right);
        if(str.length > result.length){
            result = str;
        }
        // handle double centers case abba
        var str = expandFromCenterAndCheckForPalindrome(s,left,right + 1);
        if(str.length > result.length){
            result = str;
        }
    }
    return result;
};
```

#### 3. [Leetcode#680](https://leetcode.com/problems/valid-palindrome-ii/description/) Valid Palindrome II ?
- the deletion node outside and inside must both be palindrome
```javascript
/**
 * @param {string} s
 * @return {boolean}
 */
var validPalindrome = function(s) {
    var l = 0,
        r = s.length - 1;
    
    while (l < r) {
        if (s[l] !== s[r]) {
            return isPalindrome(s,l+1,r) || isPalindrome(s,l,r-1);
        } else {
            l++;
            r--;
        }
    }
    
    return true;
};

function isPalindrome(s,l,r) {
    while (l < r) {
        if (s[l++] !== s[r--]) {
            return false;
        }
    }
    return true;
}
```
