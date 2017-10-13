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