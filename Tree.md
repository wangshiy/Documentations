# JavaScript
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
            //console.log(stack);
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