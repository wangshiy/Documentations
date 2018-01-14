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

#### 5. [Leetcode#139](https://leetcode.com/problems/word-break/description/) Word Break ?
- dp[i] means s[0:i-1] is breakable
- dp[i] = true if and only if `dp[k] === true` && dict.contains(s[k:i-1])
```javascript
/**
 * @param {string} s
 * @param {string[]} wordDict
 * @return {boolean}
 */
var wordBreak = function(s, wordDict) {
    var dp = new Array(s.length + 1).fill(false);
    dp[0] = true;
    for (var i = 0; i < s.length; i++) {
        for (var j = 0; j <= i; j++) {
            if (dp[j] && wordDict.includes(s.substr(j, i - j + 1))) {
                dp[i + 1] = true;
                break;
            }
        }
    }
    return dp[s.length];
};
```
- recursive version
```javascript
/**
 * @param {string} s
 * @param {string[]} wordDict
 * @return {boolean}
 */
var wordBreak = function(s, wordDict) {
    var mem = new Map();
    return breakHelper(s, wordDict);
    
    function breakHelper(s, dict) {
        if (mem.has(s)) {
            return mem.get(s);
        }
        if (dict.includes(s)) {
            mem.set(s, true);
            return true;
        }
        for (let i = 1; i < s.length; i++) {
            const left = s.substr(0, i);
            const right = s.substr(i);
            if (dict.includes(right) && breakHelper(left, dict)) {
                mem.set(s, true);
                return true;
            }
        }
        
        mem.set(s, false);
        return false;
    }
};
```

#### 6. [Leetcode#140](https://leetcode.com/problems/word-break-ii/description/) Word Break II ?
- dp(s, result) means all result array for string s
- outer for loop break the string into two parts, when right part is in dict then recursive call left part to find all results, then append right part to result
```javascript
/**
 * @param {string} s
 * @param {string[]} wordDict
 * @return {string[]}
 */
var wordBreak = function(s, wordDict) {
    const dp = new Map();
    return breakHelper(s, wordDict);
    
    function breakHelper(s, wordDict) {
        if (dp.has(s)) {
            return dp.get(s);
        }

        let result = [];
        if (wordDict.includes(s)) {
            result.push(s);
        }
        for (let i = 1; i < s.length; i++) {
            const right = s.substr(i);
            if (!wordDict.includes(right)) {
                continue;
            }
            const left = s.substr(0, i);
            const leftResult = appendHelper(breakHelper(left, wordDict), right);
            leftResult.forEach((e) => {
                result.push(e);
            })
        }
        
        dp.set(s, result);
        return dp.get(s);
    }

    function appendHelper(words, word) {
        const result = [];
        words.forEach((e) => {
            result.push(`${e} ${word}`);
        });
        return result;
    }
};
```

#### 7. [Leetcode#198](https://leetcode.com/problems/house-robber/description/) House Robber ?
- rob[i] = notRob[i-1] + num[i]
- notRob[i] = Math.max(rob[i-1], notRob[i-1]);
```javascript
class Solution {
    public int rob(int[] nums) {
        int rob = 0;
        int notRob = 0;
        for (int num: nums) {
            int preValue = Math.max(rob, notRob);
            rob = notRob + num;
            notRob = preValue;
        }
        return Math.max(rob, notRob);
    }
}
```

#### 8. [Leetcode#213](https://leetcode.com/problems/house-robber-ii/description/) House Robber II ?
- robRowHelper() 
- return Math.max(robRowHelper(0...n-2), robRowHelper(1...n-1));
```javascript
class Solution {
    public int rob(int[] nums) {
        int length = nums.length;
        if (length < 2) {
            return length == 1 ? nums[0] : 0;
        }
        return Math.max(this.robRowHelper(nums, 0, length - 2), this.robRowHelper(nums, 1, length - 1));
    }

    private int robRowHelper(int[] nums, int start, int end) {
        int rob = 0;
        int notRob = 0;
        int prevValue = 0;
        for (int i = start; i <= end; i++) {
            prevValue = Math.max(rob, notRob);
            rob = notRob + nums[i];
            notRob = prevValue;
        }
        return Math.max(rob, notRob);
    }
}
```