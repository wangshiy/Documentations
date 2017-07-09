# Tree
#### 1. [Leetcode#94] Binary Tree Inorder Traversal ? 
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
#### 3. [Leetcode#102] Binary Tree Level Order Traversal ? 
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
#### 4. Binary Tree width ? 
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
#### 5. [Leetcode#102](https://leetcode.com/problems/lowest-common-ancestor-of-a-binary-tree/) Binary Tree LCA ? 
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
#### 6. [Leetcode#515](https://leetcode.com/problems/find-largest-value-in-each-tree-row/#/description) Find Largest Value in Each Tree Row ?
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
