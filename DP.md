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

#### 2. [Leetcode#53](https://leetcode.com/problems/maximum-subarray/description/) Maximum Subarray ?
- Consider whether subarray from 0 index has positive contribution or not
```javascript
/**
 * @param {number[]} nums
 * @return {number}
 */
var maxSubArray = function(nums) {
    var dp = new Array(nums.length);
    dp[0] = nums[0];
    var max = dp[0];
    
    for (var i = 1; i < nums.length; i++) {
        dp[i] = nums[i] + (dp[i-1] > 0 ? dp[i-1] : 0);
        max = Math.max(max, dp[i]);
    }
    
    return max;
};
```

#### 3. [Leetcode#96](https://leetcode.com/problems/unique-binary-search-trees/description/) Unique Binary Search Trees ?
- G(n) = G(0) * G(n-1) + G(1) * G(n-2) + … + G(n-1) * G(0) 
```javascript
/**
 * @param {number} n
 * @return {number}
 */
var numTrees = function(n) {
    const G = new Array(n+1);
    G.fill(0);
    G[0] = G[1] = 1;
    
    for (let i = 2; i <=n ; i++) {
        for (let j = 1; j <= i; j++) {
            G[i] += G[j - 1] * G[i - j];
        }
    }
    
    return G[n];
};
```

#### 4. [Leetcode#95](https://leetcode.com/problems/unique-binary-search-trees-ii/description/) Unique Binary Search Trees II ?
- Divide and conquer
```javascript
/**
 * Definition for a binary tree node.
 * function TreeNode(val) {
 *     this.val = val;
 *     this.left = this.right = null;
 * }
 */
/**
 * @param {number} n
 * @return {TreeNode[]}
 */
var generateTrees = function(n) {
    if (n === 0) {
        return [];
    }
    return generateSubtrees(1, n);
};

function generateSubtrees(s, e) {
    var result = [];
    if (s > e) {
        result.push(null);
        return result;
    }
    
    for (var i = s; i <=e; i++) {
        var leftSubtree = generateSubtrees(s, i - 1);
        var rightSubtree = generateSubtrees(i + 1, e);
        leftSubtree.forEach((l) => {
            rightSubtree.forEach((r) => {
                root = new TreeNode(i);
                root.left = l;
                root.right = r;
                result.push(root);
            });
        })
    }
    
    return result;
}
```