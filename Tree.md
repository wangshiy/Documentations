# Tree
#### 1. [Leetcode#94](https://leetcode.com/problems/binary-tree-inorder-traversal/description/) Binary Tree Inorder Traversal ? 
Morris Inorder Traversal:
- Go to left child's most right child and 
- `if (predecessor.right === null)` => build the predecessor `predecessor.right = current` and `current = current.left`
- `else if (predecessor.right === current)` i.e. loop back => means the left subTree has been visited, then destruct predecessor`predecessor.right = null` and `current = current.right`
- Time: O(n), Space: O(1)
``` JavaScript
/**
 * Definition for a binary tree node.
 * function TreeNode(val) {
 *     this.val = val;
 *     this.left = this.right = null;
 * }
 */
/**
 * @param {TreeNode} root
 * @return {number[]}
 */
var inorderTraversal = function(root) {
    if (root === null) {
        return [];
    }
    
    let result = [];
    let predecessor = null;
    while (root !== null) {
        if (root.left !== null) {
            predecessor = root.left;
            while (predecessor.right !== null && predecessor.right !== root) { // go to the right most child
                predecessor = predecessor.right;
            }
            if (predecessor.right === null) { // build predecessor
                predecessor.right = root;
                root = root.left;
            } else { // means already visited leftSub tree, destruct predecessor and move to rightSub tree
                predecessor.right = null;
                result.push(root.val);
                root = root.right;
            }
        } else {
            result.push(root.val);
            root = root.right;
        }
    }
    
    return result;
};
```
Recursive: needs a closure helper function to recursively modify the outer result array
``` JavaScript
/**
 * Definition for a binary tree node.
 * function TreeNode(val) {
 *     this.val = val;
 *     this.left = this.right = null;
 * }
 */
/**
 * @param {TreeNode} root
 * @return {number[]}
 */
var inorderTraversal = function(root) {
    var result = [];
    
    if(root === null){
        return result;
    }
    
    traversalHelper(root);
    
    function traversalHelper(root){
        if(root.left !== null){
            traversalHelper(root.left);
        }
        result.push(root.val);
        if(root.right !== null){
            traversalHelper(root.right);
        }
    }
    
    return result;
};
```
Iterative: two while loops and one stack storing tree node to simulate the recursive call
```javascript
/**
 * Definition for a binary tree node.
 * function TreeNode(val) {
 *     this.val = val;
 *     this.left = this.right = null;
 * }
 */
/**
 * @param {TreeNode} root
 * @return {number[]}
 */
var inorderTraversal = function(root) {
    var result = [];
    if(root === null){
        return result;
    }
    
    var stack = [];
    var cur = root;
    while(stack.length > 0 || cur !== null){
        while(cur !== null){
            stack.push(cur);
            cur = cur.left
        }
        
        cur = stack.pop();
        result.push(cur.val);
        cur = cur.right;
    }
    
    return result;
};
```

#### 2. Binary Tree Inorder Traversal Iterator? 
Provide `next()` and `hasNext()` and use stack to maintain treenodes
``` JavaScript
function TreeNode(val) {
    this.val = val;
    this.left = this.right = null;
}

var inorderTraversalIterator = function() { 
    var stack = [];
                
    function pushLeftChild(node){
        while(node !== null){
            stack.push(node);
            node = node.left;
        }
    }
                
    function hasNext(){
        return stack.length > 0 ? true : false;
    }
                
    function next(){
        if(hasNext() === false){
            throw "all nodes visited"
        }else{
            var temp = stack.pop();
            pushLeftChild(temp.right);
            return temp.val;
        }
    }
    
    return {
        init: pushLeftChild,
        hasNext: hasNext,
        next: next
    };
};

var nodeRoot = new TreeNode(1);
var node1 = new TreeNode(4);
var node2 = new TreeNode(6);
var node3 = new TreeNode(7);
var node4 = new TreeNode(2);
var node5 = new TreeNode(3);
nodeRoot.left = node1;
node1.left = node2;
node1.right = node3;
nodeRoot.right = node4;
node4.left = node5;

var iterator = inorderTraversalIterator();

iterator.init(nodeRoot);
console.log(iterator.hasNext() + " : " + iterator.next());
console.log(iterator.hasNext() + " : " + iterator.next());
console.log(iterator.hasNext() + " : " + iterator.next());
console.log(iterator.hasNext() + " : " + iterator.next());
console.log(iterator.hasNext() + " : " + iterator.next());
console.log(iterator.hasNext() + " : " + iterator.next());
console.log(iterator.hasNext() + " : " + iterator.next());
```

#### 3. [Leetcode#144](https://leetcode.com/problems/binary-tree-preorder-traversal/description/) Binary Tree Preorder Traversal ? 
Morris Inorder Traversal:
- One line different from Inorder Traversal: when `predecessor.right === null` => print `root.val`
- Time: O(n), Space: O(1)
``` JavaScript
/**
 * Definition for a binary tree node.
 * function TreeNode(val) {
 *     this.val = val;
 *     this.left = this.right = null;
 * }
 */
/**
 * @param {TreeNode} root
 * @return {number[]}
 */
var preorderTraversal = function(root) {
    if (root === null) {
        return [];
    }
    
    let result = [];
    let predecessor = null;
    while (root !== null) {
        if (root.left !== null) {
            predecessor = root.left;
            while (predecessor.right !== null && predecessor.right !== root) { // go to the right most child
                predecessor = predecessor.right;
            }
            if (predecessor.right === null) { // build predecessor
                predecessor.right = root;
                result.push(root.val);
                root = root.left;
            } else { // means already visited leftSub tree, destruct predecessor and move to rightSub tree
                predecessor.right = null;
                root = root.right;
            }
        } else {
            result.push(root.val);
            root = root.right;
        }
    }
    
    return result;
};
```

#### 4. [Leetcode#99](https://leetcode.com/problems/recover-binary-search-tree/description/) Recover Binary Search Tree ? 
Apply Morris Inorder Traversal:
- When visit root then add conditions to find firstNode or secondNode wrong nodes
- Time: O(n), Space: O(1)
``` JavaScript
/**
 * Definition for a binary tree node.
 * function TreeNode(val) {
 *     this.val = val;
 *     this.left = this.right = null;
 * }
 */
/**
 * @param {TreeNode} root
 * @return {void} Do not return anything, modify root in-place instead.
 */

// [4,2,6,7,3,5,1]
var recoverTree = function(root) {
    if (root === null) {
        return;
    }
    let predecessor = null;
    let firstNode = null;
    let secondNode = null;
    let firstTime = true;
    let prev = new TreeNode(Number.MIN_SAFE_INTEGER);
    
    while (root !== null) {
        if (root.left !== null) {
            predecessor = root.left;
            while (predecessor.right !== null && predecessor.right !== root) {
                predecessor = predecessor.right;
            }
            if (predecessor.right === null) {
                predecessor.right = root;
                root = root.left;
            } else {
                predecessor.right = null;
                // visit root
                if (prev.val > root.val && firstTime) {
                    firstNode = prev;
                    firstTime = false;
                } // here can not use else if because to handle input is only 2 elements like [0,1], then default second is the next one
                if (prev.val > root.val && !firstTime) {
                    secondNode = root;
                }
                prev = root;
                root = root.right;
            }
        } else {
            // visit root
            if (prev.val > root.val && firstTime) {
                firstNode = prev;
                firstTime = false;
            }
            if (prev.val > root.val && !firstTime) {
                secondNode = root;
            }
            prev = root;
            root = root.right;
        }
    }
    
    // swap
    if (firstNode !== null && secondNode !== null) {
        const temp = firstNode.val;
        firstNode.val = secondNode.val;
        secondNode.val = temp;
    }
    
    return;
};
```

#### 5. [Leetcode#102](https://leetcode.com/problems/binary-tree-level-order-traversal/description/) Binary Tree Level Order Traversal ? 
BFS, and needs two counters for curLvNodes and nextLvNodes
```javascript
/**
 * Definition for a binary tree node.
 * function TreeNode(val) {
 *     this.val = val;
 *     this.left = this.right = null;
 * }
 */
/**
 * @param {TreeNode} root
 * @return {number[][]}
 */
var levelOrder = function(root) {
    var result = [];
    if(root === null){
        return result;
    }
    
    var queue = [];
    queue.push(root);
    var temp = [];
    var curLvCount = 1;
    var nextLvCount = 0;
    
    while(queue.length > 0){
        var node = queue.shift();
        temp.push(node.val);
        curLvCount--;
        if(node.left !== null){
            nextLvCount++;
            queue.push(node.left);
        }
        if(node.right !== null){
            nextLvCount++;
            queue.push(node.right);
        }
        if(curLvCount === 0){
            result.push(temp);
            temp = [];
            curLvCount = nextLvCount;
            nextLvCount = 0;
        }
    }
    
    return result;
};
```

#### 6. Binary Tree width ? 
Height should be init as an array to call by reference

Recursion should have ablility to update its parent height so that height and width recursions are in the same function to optimize => O(n)
``` JavaScript
W(T) = max(W(T.left), W(T.right), LongestPath(T));
LongestPath(T) = 1 + Height(T.left) + Height(T.right);
Height(T) = 1 + max(Height(T.left), Height(T.right));
```
``` JavaScript
function TreeNode(val) {
    this.val = val;
    this.left = this.right = null;
}

var treeWidth = function(root) { 
    var height = [0];

    function diameter(rootNode,heightVal){
        if(rootNode === null){
            heightVal[0] = 0;
            return 0;
        }

        var leftHeight = [0];
        var rightHeight = [0];
        var leftDiam = diameter(rootNode.left, leftHeight);
        var rightDiam = diameter(rootNode.right, rightHeight);
        heightVal[0] = 1 + Math.max(leftHeight[0], rightHeight[0]);

        return Math.max(leftDiam,rightDiam,1+leftHeight[0]+rightHeight[0]);
    }

    return diameter(root,height);
};

var nodeRoot = new TreeNode(1);
var node1 = new TreeNode(4);
var node2 = new TreeNode(6);
var node3 = new TreeNode(7);
var node4 = new TreeNode(2);
var node5 = new TreeNode(3);
nodeRoot.left = node1;
node1.left = node2;
node1.right = node3;
nodeRoot.right = node4;
node4.left = node5;

console.log(treeWidth(nodeRoot));
```

#### 7. [Leetcode#236](https://leetcode.com/problems/lowest-common-ancestor-of-a-binary-tree/) Binary Tree LCA ? 
If found node is the target, then node return itself to its parent, finally parent return left or right or itself.
Time O(n), Space O(1)
``` JavaScript
/**
 * Definition for a binary tree node.
 * function TreeNode(val) {
 *     this.val = val;
 *     this.left = this.right = null;
 * }
 */
/**
 * @param {TreeNode} root
 * @param {TreeNode} p
 * @param {TreeNode} q
 * @return {TreeNode}
 */
var lowestCommonAncestor = function(root, p, q) {
    if(root === null){
        return null;
    }
    
    if(root === p || root === q){
        return root;
    }
    
    var l = lowestCommonAncestor(root.left,p,q);
    var r = lowestCommonAncestor(root.right,p,q);
    
    if(l === null && r === null){
        return null;
    }
    
    if(l !== null && r !== null){
        return root;
    }
    
    return l !== null ? l : r;
};
```

#### 8. [Leetcode#515](https://leetcode.com/problems/find-largest-value-in-each-tree-row/#/description) Find Largest Value in Each Tree Row ?
- BFS
- Need to maintain `curRowElemCount` and `nextRowElemCount` in order to know when is the end of traversing currrent row
```javascript
/**
 * Definition for a binary tree node.
 * function TreeNode(val) {
 *     this.val = val;
 *     this.left = this.right = null;
 * }
 */
/**
 * @param {TreeNode} root
 * @return {number[]}
 */

// queue: TreeNode[];
// curRowElemCount: number;
// nextRowElemCount: number;
// rowMaxElem: number;
// result : number[];
var largestValues = function(root) {
    let result = [],
        queue = [],
        curRowElemCount = 0,
        nextRowElemCount = 0,
        rowMaxElem = Number.MIN_SAFE_INTEGER;
    
    if (root === null) {
        return result;
    }
    
    queue.push(root);
    curRowElemCount = 1;
    while (queue.length > 0) {
        let curNode = queue.shift();
        curRowElemCount--;
        rowMaxElem = Math.max(rowMaxElem, curNode.val);
        if (curNode.left !== null) {
            queue.push(curNode.left);
            nextRowElemCount++;
        }
        if (curNode.right !== null) {
            queue.push(curNode.right);
            nextRowElemCount++;
        }   
        if (curRowElemCount === 0) {
            result.push(rowMaxElem);
            rowMaxElem = Number.MIN_SAFE_INTEGER;
            curRowElemCount = nextRowElemCount;
            nextRowElemCount = 0;
        }
    }
    
    return result;
};
```

#### 9. [Leetcode#98](https://leetcode.com/problems/validate-binary-search-tree/description/) Validate Binary Search Tree ?
- Recursive: maintain min and max boundary
```javascript
/**
 * Definition for a binary tree node.
 * function TreeNode(val) {
 *     this.val = val;
 *     this.left = this.right = null;
 * }
 */
/**
 * @param {TreeNode} root
 * @return {boolean}
 */
var isValidBST = function(root) {
    return isValidBSTHelper(root, Number.MIN_SAFE_INTEGER, Number.MAX_SAFE_INTEGER);
};

function isValidBSTHelper(root, min, max) {
    if (root === null) {
        return true;
    }
    
    if (root.val <= min || root.val >= max) {
        return false;
    }
    
    return isValidBSTHelper(root.left, min, root.val) && isValidBSTHelper(root.right, root.val, max);
}
```
- Iterative: have another data structure to maintain the boundaries with node
```javascript
/**
 * Definition for a binary tree node.
 * function TreeNode(val) {
 *     this.val = val;
 *     this.left = this.right = null;
 * }
 */
/**
 * @param {TreeNode} root
 * @return {boolean}
 */
function BNode(n, left, right) {
    this.n = n;
    this.left = left;
    this.right = right;
}

var isValidBST = function(root) {
    if (root === null) {
        return true;
    }
    
    var queue = [];
    queue.push(new BNode(root, Number.MIN_SAFE_INTEGER, Number.MAX_SAFE_INTEGER));
    
    while (queue.length > 0) {
        var node = queue.shift();
        
        if (node.n.val <= node.left || node.n.val >= node.right) {
            return false;
        }
        
        if (node.n.left !== null) {
            queue.push(new BNode(node.n.left, node.left, node.n.val));
        }
        
        if (node.n.right !== null) {
            queue.push(new BNode(node.n.right, node.n.val, node.right));
        }
    }
    
    return true;
};
```

#### 10. [Leetcode#101](https://leetcode.com/problems/symmetric-tree/description/) Symmetric Tree ?
- Recursive: left.left === right.right && left.right && right.left
```javascript
/**
 * Definition for a binary tree node.
 * function TreeNode(val) {
 *     this.val = val;
 *     this.left = this.right = null;
 * }
 */
/**
 * @param {TreeNode} root
 * @return {boolean}
 */
var isSymmetric = function(root) {
    if (root === null) {
        return true;
    }
    return isSymmetricHelper(root.left, root.right);
};

function isSymmetricHelper(left, right) {
    if (left === null || right === null) {
        return left === right;
    }
    
    if (left.val !== right.val) {
        return false;
    }
    
    return isSymmetricHelper(left.left, right.right) && isSymmetricHelper(left.right, right.left);
}
```
- Iterative: 2 queues BFS from different order
```javascript
/**
 * Definition for a binary tree node.
 * function TreeNode(val) {
 *     this.val = val;
 *     this.left = this.right = null;
 * }
 */
/**
 * @param {TreeNode} root
 * @return {boolean}
 */
var isSymmetric = function(root) {
    if (root === null) {
        return true;
    }
    
    var q1 = [];
    var q2 = [];
    q1.push(root);
    q2.push(root);
    
    while (q1.length > 0 && q2.length > 0){
        var n1 = q1.shift();
        var n2 = q2.shift();
        
        if (n1 === null && n2 === null) {
            continue;
        } else if (n1 !== null && n2 !== null) {
            if (n1.val !== n2.val) {
                return false;
            }
        } else {
            return false;
        }
        
        q1.push(n1.left);
        q1.push(n1.right);
        q2.push(n2.right);
        q2.push(n2.left);
    }
    
    if(q1.length > 0 || q2.length > 0) {
        return false;
    }else{
        return true;
    }
};
```

#### 11. [Leetcode#235](https://leetcode.com/problems/lowest-common-ancestor-of-a-binary-search-tree/description/) Lowest Common Ancestor of a Binary Search Tree ?
- Utilize BST property, if root.val between p and q, then it is root, if root.val smaller than both p and q then dive to root.right, else dive to root.left
```javascript
/**
 * Definition for a binary tree node.
 * function TreeNode(val) {
 *     this.val = val;
 *     this.left = this.right = null;
 * }
 */
/**
 * @param {TreeNode} root
 * @param {TreeNode} p
 * @param {TreeNode} q
 * @return {TreeNode}
 */
var lowestCommonAncestor = function(root, p, q) {
    if (root === null) {
        return null;
    }
    
    if ((root.val >= p.val && root.val <= q.val) || (root.val >= q.val && root.val <= p.val)) {
        return root;
    }
    
    if (root.val > p.val && root.val > q.val) {
        return lowestCommonAncestor(root.left, p, q);
    } else {
        return lowestCommonAncestor(root.right, p, q);
    }
};
```

#### 12. [Leetcode#112](https://leetcode.com/problems/path-sum/description/) Path Sum ?
- Recursive: continuously update target sum to dive down
```javascript
/**
 * Definition for a binary tree node.
 * function TreeNode(val) {
 *     this.val = val;
 *     this.left = this.right = null;
 * }
 */
/**
 * @param {TreeNode} root
 * @param {number} sum
 * @return {boolean}
 */
var hasPathSum = function(root, sum) {
    if (root === null) {
        return false;
    }
    
    if (root.left === null && root.right === null) {
        return root.val === sum;
    }
    
    return hasPathSum(root.left, sum-root.val) || hasPathSum(root.right, sum-root.val);
};
```
- Iterative: dfs with a pathSum stack to help backtracking
```javascript
/**
 * Definition for a binary tree node.
 * function TreeNode(val) {
 *     this.val = val;
 *     this.left = this.right = null;
 * }
 */
/**
 * @param {TreeNode} root
 * @param {number} sum
 * @return {boolean}
 */
var hasPathSum = function(root, sum) {
    if (root === null) {
      return false;
    }

    var stack = [];
    var sumStack = [];
    stack.push(root);
    sumStack.push(root.val);

    while (stack.length > 0) {
      var node = stack.pop();
      var pathSum = sumStack.pop();
      if (node.right === null && node.left === null && pathSum === sum) {
        return true;
      }
      if (node.right !== null) {
        stack.push(node.right);
        sumStack.push(pathSum + node.right.val);
      }
      if (node.left !== null) {
        stack.push(node.left);
        sumStack.push(pathSum + node.left.val);
      }
    }
    return false;
};
```

#### 13. [Leetcode#173](https://leetcode.com/problems/binary-search-tree-iterator/description/) Binary Search Tree Iterator ?
- pushAll left children to stack, and process the poped node's right child
```javascript
/**
 * Definition for binary tree
 * function TreeNode(val) {
 *     this.val = val;
 *     this.left = this.right = null;
 * }
 */

/**
 * @constructor
 * @param {TreeNode} root - root of the binary search tree
 */
var BSTIterator = function(root) {
    this.stack = [];
    this.pushAll = function(node) {
        while (node) {
            this.stack.push(node);
            node = node.left;
        }
    }
    this.pushAll(root);
};


/**
 * @this BSTIterator
 * @returns {boolean} - whether we have a next smallest number
 */
BSTIterator.prototype.hasNext = function() {
    return this.stack.length !== 0;
};

/**
 * @this BSTIterator
 * @returns {number} - the next smallest number
 */
BSTIterator.prototype.next = function() {
    var node = this.stack.pop();
    this.pushAll(node.right);
    return node.val;
};

/**
 * Your BSTIterator will be called like this:
 * var i = new BSTIterator(root), a = [];
 * while (i.hasNext()) a.push(i.next());
*/
```

#### 14. [Leetcode#687](https://leetcode.com/problems/longest-univalue-path/description/) Longest Univalue Path ?
- Recursion ask children's left and right path length and update the global maxLength in the meanwhile
```javascript
/**
 * Definition for a binary tree node.
 * function TreeNode(val) {
 *     this.val = val;
 *     this.left = this.right = null;
 * }
 */
/**
 * @param {TreeNode} root
 * @return {number}
 */
var longestUnivaluePath = function(root) {
    var maxLength = 0;
    arrowLength(root);
    return maxLength;
    
    function arrowLength(root) {
        if (root === null) {
            return 0;
        }
        var left = arrowLength(root.left);
        var right = arrowLength(root.right);

        var arrowLeft = 0;
        var arrowRight = 0;
        if (root.left !== null && root.left.val === root.val) {
            arrowLeft = left + 1;
        }
        if (root.right !== null && root.right.val === root.val) {
            arrowRight = right + 1;
        }

        maxLength = Math.max(maxLength, arrowLeft + arrowRight);

        return Math.max(arrowLeft, arrowRight);
    }
};
```
