# Binary Search
#### 1. [Leetcode#300](https://leetcode.com/problems/longest-increasing-subsequence/#/description) Longest Increasing Subsequence ?
- Maintain a sorted result array []
- for each element in the array, if it > last element in the result array then push it to result array, else replace the first greater than it element with it
- So the result array may not use the continous element in input array, but the length of it is correct LIS's length
```javascript
/**
 * @param {number[]} nums
 * @return {number}
 */
var lengthOfLIS = function(nums) {
    let result = [];
    for (let i = 0; i < nums.length; i++) {
        let num = nums[i];
        let idxToPlace = untilBinarySearch(result, num);
        if (idxToPlace === result.length) {
            result.push(num);
        } else {
            result[idxToPlace] = num;
        }
    }
    return result.length;
    
    /**
     * @return {number}: the index where current target to place in the input array
     */
    function untilBinarySearch(ary, target) {
        if (ary.length === 0) {
            return 0;
        }
        let start = 0;
        let end = ary.length;
        let mid;
        while (start + 1 < end) {
            mid = parseInt(start + (end - start) / 2);
            if (ary[mid] <= target) {
                start = mid;
            }else{
                end = mid;
            }
        }
        
        if (ary[start] < target) {
            return end;
        } else {
            return start;
        }
    }
    
};
```
#### 2. [Leetcode#34](https://leetcode.com/problems/search-for-a-range/description/) Search for a Range ?
- Two Binary Search to find left and right boundaries
- Move left and right boundaries as far as possible
- `while(start + 1 < end)` to prevent dead loop
```javascript
/**
 * @param {number[]} nums
 * @param {number} target
 * @return {number[]}
 */
var searchRange = function(nums, target) {
    var start = 0;
    var end = nums.length - 1;
    var result = [-1, -1];
    
    while (start + 1 < end) {
        var mid = Math.floor((start + end) / 2);
        if (target > nums[mid]) { // try to make start go to left as far as possible
            start = mid;
        } else {
            end = mid;
        }
    }
    if (nums[start] === target) {
        result[0] = start;
    }else if (nums[end] === target) {
        result[0] = end;
    }else {
        return result;
    }
    
    start = 0;
    end = nums.length - 1;
    while (start + 1 < end) {
        var mid = Math.floor((start + end) / 2);
        if (target < nums[mid]) { // try to make end go to right as far as possible
            end = mid;
        } else {
            start = mid;
        }
    }
    if (nums[end] === target) {
        result[1] = end;
    }else if (nums[start] === target) {
        result[1] = start;
    }else {
        return result;
    }
    
    return result;
};
```