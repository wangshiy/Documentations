# DFS
#### 1. [Leetcode#200](https://leetcode.com/problems/number-of-islands/description/) Number of Islands ?
- DFS when encounter 1, make total counter++ and make all its neighbours to 0
- Time: O(mn), Space: O(mn)
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
    grid[y][x] = '0'; // prune
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

#### 3. [Leetcode#116](https://leetcode.com/problems/populating-next-right-pointers-in-each-node/description/) Populating Next Right Pointers in Each Node ?
- dfs with pre-order traversal
- Time: O(n), Space: O(n)
```javascript
/**
 * Definition for binary tree with next pointer.
 * function TreeLinkNode(val) {
 *     this.val = val;
 *     this.left = this.right = this.next = null;
 * }
 */

/**
 * @param {TreeLinkNode} root
 * @return {void} Do not return anything, modify tree in-place instead.
 */
var connect = function(root) {
    if (!root) {
        return;
    }
    
    if (root.left) {
        root.left.next = root.right;
    }
    if (root.next && root.next.left) {
        root.right.next = root.next.left;
    }
    
    connect(root.left);
    connect(root.right);
    
    return;
};
```

#### 4. [Leetcode#105](https://leetcode.com/problems/construct-binary-tree-from-preorder-and-inorder-traversal/description/) Construct Binary Tree from Preorder and Inorder Traversal ?
- use preorder root node to find its idx to help divide the array into left and right to provide resources for preorder to construct
- three key idx: pre_start, in_start, in_end can construct root and its children
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
 * @param {number[]} preorder
 * @param {number[]} inorder
 * @return {TreeNode}
 */
var buildTree = function(preorder, inorder) {
    if (!preorder || !inorder || preorder.length === 0 || inorder.length === 0) {
        return null;
    }
    
    return buildHelper(preorder, inorder, 0, 0, inorder.length - 1);
};

function buildHelper(preorder, inorder, pre_start, in_start, in_end) {
    if (pre_start >= preorder.length || in_start > in_end) {
        return null;
    }
    
    let i = in_start;
    while (i <= in_end) {
        if (preorder[pre_start] === inorder[i]) {
            break;
        }
        i++;
    }
    
    const curNode = new TreeNode(preorder[pre_start]);
    curNode.left = buildHelper(preorder, inorder, pre_start + 1, in_start, i - 1);
    curNode.right = buildHelper(preorder, inorder, pre_start + (i - in_start + 1), i + 1, in_end);
    
    return curNode;
}
```

#### 5. [Leetcode#301](https://leetcode.com/problems/remove-invalid-parentheses/description/) Remove Invalid Parentheses ?
- remove the first invalid one and recursively call the function with the rest of the string
- reverse the string and do the same to help ')' is more that '('
- Time: O(n^2), Space: O(n^2)
```javascript
/**
 * @param {string} s
 * @return {string[]}
 */
var removeInvalidParentheses = function(s) {
  const  result = [];
  removeHelper(s, result, 0, 0, ['(', ')']);
  return result;
};

function removeHelper(s, result, last_i, last_j, para) {
  let stack = 0;
  for (let i = last_i; i < s.length; i++) {
    if (s[i] === para[0]) {
      stack++;
    }
    if (s[i] === para[1]) {
      stack--;
    }
    if (stack >= 0) {
      continue;
    }

    for (let j = last_j; j <= i; j++) {
      if (s[j] === para[1] && (j === last_j || s[j-1] !== para[1])) {
        // console.log(`s:${s.substring(0, j) + s.substring(j+1, s.length)},result:${result},i:${i},j:${j},para:${para}`);
        removeHelper(s.substring(0, j) + s.substring(j+1, s.length), result, i, j, para);
      }
    }

    return;
  }

  const reversed = s.split('').reverse().join('');
  if (para[0] === '(') {
    removeHelper(reversed, result, 0, 0, [')','(']);
  } else {
    result.push(reversed);
  }
}
```