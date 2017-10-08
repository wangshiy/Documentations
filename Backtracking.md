#### 1. [Leetcode#46](https://leetcode.com/problems/permutations/description/) Permutations ?
- for loop, push and pop, and `.slice` to shallow copy
```javascript
/**
 * @param {number[]} nums
 * @return {number[][]}
 */
var permute = function(nums) {
    var result = [],
        resultItem = [];
    permuteHelper(result, resultItem, nums);
    return result;
};

function permuteHelper(aryList, ary, numsAry) {
    if (ary.length === numsAry.length) {
        aryList.push(ary.slice());
        return;
    }
    for (var i = 0; i < numsAry.length; i++) {
        if (ary.includes(numsAry[i])) {
            continue;
        }
        ary.push(numsAry[i]);
        permuteHelper(aryList, ary, numsAry);
        ary.pop();
    }
    return;
}
```

#### 2. [Leetcode#47](https://leetcode.com/problems/permutations-ii/discuss/) Permutations II ?
- Sort first, then maintain a visited array, if previous not visited then the next one should be skipped
```javascript
/**
 * @param {number[]} nums
 * @return {number[][]}
 */
var permuteUnique = function(nums) {
    var result = [],
        resultItem = [],
        visited = [];
    nums.sort();
    permuteHelper(result, resultItem, visited, nums);
    return result;
};

function permuteHelper(aryList, ary, visited, numsAry) {
    if (ary.length === numsAry.length) {
        aryList.push(ary.slice());
        return;
    }
    for (var i = 0; i < numsAry.length; i++) {
        if (visited[i] === 1 || (i !== 0 && numsAry[i] === numsAry[i-1] && visited[i-1] === 0) ) {
            continue;
        }
        visited[i] = 1;
        ary.push(numsAry[i]);
        permuteHelper(aryList, ary, visited, numsAry);
        ary.pop();
        visited[i] = 0;
    }
    return;
}
```
