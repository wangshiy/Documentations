# Dynamic Programming
#### 1. [Leetcode#300](https://leetcode.com/problems/longest-increasing-subsequence/#/description) Longest Increasing Subsequence ?
- A[i]: Input array index = i element
- L[i]: Using A[i] as the last element, then the LIS length
- State transition function:
1. Init L[i] = 1
2. Next element A[i] should be greater than all previous A[j](j from 0 to i), then L[i] = max(L[j]) + 1
- Result: maximum of L
- Time: O(n^2)
```javascript
/**
 * @param {number[]} nums
 * @return {number}
 */

var lengthOfLIS = function(nums) {
    let L = [];
    let result = 0;
    for (let i = 0; i < nums.length; i++) {
        L[i] = 1;
    }
    
    for (let i = 1; i < nums.length; i++) {
        for (let j = 0; j < i; j++) {
            if (nums[i] > nums[j] && L[i] < L[j] + 1) {
                L[i] = L[j] + 1;
            }
        }
    }
    
    for (let i = 0; i < L.length; i++) {
        if (result < L[i]) {
            result = L[i];
        }
    }
    
    return result;
};
```
