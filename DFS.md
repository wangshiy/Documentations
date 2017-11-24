# DFS
#### 1. [Leetcode#200](https://leetcode.com/problems/number-of-islands/description/) Number of Islands ?
- DFS when encounter 1, make total counter++ and make all its neighbours to 0
- Time: O(mn)
```javascript
/**
 * @param {character[][]} grid
 * @return {number}
 */
var numIslands = function(grid) {
    if (!grid || grid.length === 0) {
        return 0;
    }
    let result = 0;
    
    const n = grid.length;
    const m = grid[0].length;
    for (let y = 0; y < n; y++) {
        for (let x = 0; x < m; x++) {
            if (grid[y][x] === '1') {
                result++;
                dfs(x, y, m, n, grid);
            }
        }
    }
    
    return result;
};

function dfs(x, y, m, n, grid) {
    if (x < 0 || x >= m || y < 0 || y >= n || grid[y][x] === '0') {
        return;
    }
    grid[y][x] = '0';
    dfs(x + 1, y, m, n, grid);
    dfs(x - 1, y, m, n, grid);
    dfs(x, y + 1, m, n, grid);
    dfs(x, y - 1, m, n, grid);
    return;
}
```

#### 2. [Leetcode#108](https://leetcode.com/problems/convert-sorted-array-to-binary-search-tree/description/) Convert Sorted Array to Binary Search Tree ?
- always use mid item in array to construct root node then dfs
- Time: O(n), Space: O(n)
```javascript
/**
 * Definition for a binary tree node.
 * function TreeNode(val) {
 *     this.val = val;
 *     this.left = this.right = null;
 * }
 */
/**
 * @param {number[]} nums
 * @return {TreeNode}
 */
var sortedArrayToBST = function(nums) {
    if (!nums || nums.length === 0) {
        return null;
    }
    const low = 0;
    const high = nums.length - 1;
    return buildHelper(nums, low, high);
};

function buildHelper(nums, low, high) {
    if (low > high) {
        return null;
    }
    
    const mid = parseInt((low + high) / 2 );
    const node = new TreeNode(nums[mid]);
    node.left = buildHelper(nums, low, mid - 1);
    node.right = buildHelper(nums, mid + 1, high);
    
    return node;
}
```