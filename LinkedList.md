# Linked List
#### 1. [Leetcode#206](https://leetcode.com/problems/reverse-linked-list/description/) Reverse Linked List ?
- Three pointers: pre, cur and post
- Reverse links until cur reach the null pointer and then return pre
```javascript
/**
 * Definition for singly-linked list.
 * function ListNode(val) {
 *     this.val = val;
 *     this.next = null;
 * }
 */
/**
 * @param {ListNode} head
 * @return {ListNode}
 */
var reverseList = function(head) {
    var pre = null;
    var cur = head;
    
    while (cur) {
        var post = cur.next;
        cur.next = pre;
        pre = cur;
        cur = post;
    }
    
    return pre;
};
```
#### 2. [Leetcode#92](https://leetcode.com/problems/reverse-linked-list-ii/description/) Reverse Linked List II ?
- Three pointers: pre, cur and post
- Move the head to locate the starting node for the reverse interval
```javascript
/**
 * Definition for singly-linked list.
 * function ListNode(val) {
 *     this.val = val;
 *     this.next = null;
 * }
 */
/**
 * @param {ListNode} head
 * @param {number} m
 * @param {number} n
 * @return {ListNode}
 */
var reverseBetween = function(head, m, n) {
    let dummy = new ListNode(-1);
    dummy.next = head;
    head = dummy;
    
    for (let i = 0; i < m - 1; i++) {
        head = head.next;
    }
    let prev = head.next;
    let cur = prev.next;
    
    for (let i = 0; i < n - m; i++) {
        let post = cur.next;
        cur.next = prev;
        prev = cur;
        cur = post;
    }
    
    head.next.next = cur;
    head.next = prev;
    
    return dummy.next;
};
```
#### 3. [Leetcode#234](https://leetcode.com/problems/palindrome-linked-list/description/) Palindrome Linked List ?
General think is O(n) time and O(1) space need to reverse the second half links
- Use slow and fast pointers to find the mid node
- New a dummy head and reverse the second half of the linked list
- Traverse the first and second half and compare each node value
```javascript
/**
 * Definition for singly-linked list.
 * function ListNode(val) {
 *     this.val = val;
 *     this.next = null;
 * }
 */
/**
 * @param {ListNode} head
 * @return {boolean}
 */
var isPalindrome = function(head) {
    if (head === null || head.next === null) {
        return true;
    }
    
    // find mid node
    var slow = head;
    var fast = head;
    var list1 = head;
    while (fast && fast.next) {
        slow = slow.next;
        fast = fast.next.next;
    }
   
    // reverse second half links
    var cur;
    var head2 = new ListNode(-1);
    while (slow) {
        cur = slow;
        slow = slow.next;
        cur.next = head2.next;
        head2.next = cur;
    }
    
    // traverse two lists and compare
    var list2 = head2.next;
    while (list2) {
        if(list1.val !== list2.val){
            return false;
        }
        list1 = list1.next;
        list2 = list2.next;
    }
    
    return true;
};
```
#### 4. [Leetcode#21](https://leetcode.com/problems/merge-two-sorted-lists/description/) Merge Two Sorted Lists ?
- Key point is to create a dummy head, otherwise as you move the cur pointer you will lose the head
- Compare and append to the dummy head
```javascript
/**
 * Definition for singly-linked list.
 * function ListNode(val) {
 *     this.val = val;
 *     this.next = null;
 * }
 */
/**
 * @param {ListNode} l1
 * @param {ListNode} l2
 * @return {ListNode}
 */
var mergeTwoLists = function(l1, l2) {
    let dummy = new ListNode(-1);
    let cur = dummy;
    
    while (l1 !== null && l2 !== null) {
        if (l1.val <= l2.val) {
            cur.next = l1;
            l1 = l1.next;
        } else {
            cur.next = l2;
            l2 = l2.next;
        }
        cur = cur.next;
    }
    
    if (l1 !== null) {
        cur.next = l1;
    } else {
        cur.next = l2;
    }
    
    return dummy.next;
};
```
#### 5. [Leetcode#141](https://leetcode.com/problems/linked-list-cycle/description/) Linked List Cycle ?
- Two pointers, slow move 1 node, fast move 2 nodes
- Key point is when next node is not null then move the pointers, and both pointers stand at 1 interval initially
```javascript
/**
 * Definition for singly-linked list.
 * function ListNode(val) {
 *     this.val = val;
 *     this.next = null;
 * }
 */

/**
 * @param {ListNode} head
 * @return {boolean}
 */
var hasCycle = function(head) {
    let slow = head;
    let fast = head;
    
    while (slow !== null && fast !== null) {
        slow = slow.next;
        fast = fast.next;
        if (fast !== null) {
            fast = fast.next;
        } else {
            return false;
        }
        
        if (slow === fast) {
            return true;
        }
    }
    
    return false;
};
```
#### 6. [Leetcode#142](https://leetcode.com/problems/linked-list-cycle-ii/description/) Linked List Cycle II ?
- When meet, reset slow to head then move together until they meet again
- http://fisherlei.blogspot.com/2013/11/leetcode-linked-list-cycle-ii-solution.html
```javascript
/**
 * Definition for singly-linked list.
 * function ListNode(val) {
 *     this.val = val;
 *     this.next = null;
 * }
 */

/**
 * @param {ListNode} head
 * @return {ListNode}
 */
var detectCycle = function(head) {
    let slow = head;
    let fast = head;
    
    while (slow !== null && fast !== null) {
        slow = slow.next;
        fast = fast.next;
        if (fast !== null) {
            fast = fast.next;
        }
        if (slow === fast) {
            break;
        }
    }
    
    if (fast === null) {
        return null;
    }
    
    slow = head;
    while (slow !== fast) {
        slow = slow.next;
        fast = fast.next;
    }
    
    return slow;
};
```
#### 7. [Leetcode#328](https://leetcode.com/problems/odd-even-linked-list/description/) Odd Even Linked List ?
- Three pointers 
```javascript
/**
 * Definition for singly-linked list.
 * function ListNode(val) {
 *     this.val = val;
 *     this.next = null;
 * }
 */
/**
 * @param {ListNode} head
 * @return {ListNode}
 */
var oddEvenList = function(head) {
    if (head === null || head.next === null || head.next.next === null) {
        return head;
    }
    
    let prev = head;
    let cur = prev.next;
    let post = cur.next;
    let firstEvenHead = head.next;
    let step = 0;
    
    while (post !== null) {
        prev.next = post;
        prev = cur;
        cur = post;
        post = post.next;
        step++;
    }
    
    prev.next = post;
    
    if (step % 2 === 0) {
        prev.next = firstEvenHead;
    } else {
        cur.next = firstEvenHead;
    }
    
    return head;
};
```
- Make odd and even dummy heads and then merge them
```javascript
/**
 * Definition for singly-linked list.
 * function ListNode(val) {
 *     this.val = val;
 *     this.next = null;
 * }
 */
/**
 * @param {ListNode} head
 * @return {ListNode}
 */
var oddEvenList = function(head) {
    while(head === null || head.next === null){
        return head;
    }
    
    var oddHead = new ListNode(-1);
    var evenHead = new ListNode(-1);
    var o = oddHead;
    var e = evenHead;
    var isOdd = true;
    
    while(head){
        if(isOdd){
            o.next = head;
            o = head;
            isOdd = !isOdd;
        }else{
            e.next = head;
            e = head;
            isOdd = !isOdd;
        }
        head = head.next;
    }
    
    e.next = null;
    o.next = evenHead.next;
    
    return oddHead.next;
    
};
```
#### 8. [Leetcode#19](https://leetcode.com/problems/remove-nth-node-from-end-of-list/description/) Remove Nth Node From End of List ?
- keypoint is to create a dummy node in case of deleting head
```javascript
/**
 * Definition for singly-linked list.
 * function ListNode(val) {
 *     this.val = val;
 *     this.next = null;
 * }
 */
/**
 * @param {ListNode} head
 * @param {number} n
 * @return {ListNode}
 */
var removeNthFromEnd = function(head, n) {
    let dummy = new ListNode(-1);
    dummy.next = head;
    let slow = dummy;
    let fast = dummy;
    
    for (let i = 0; i < n; i++) {
        fast = fast.next;
    }
    
    while (fast.next !== null) {
        slow = slow.next;
        fast = fast.next;
    }
    
    slow.next = slow.next.next;
    
    return dummy.next;
};
```
#### 9. [Leetcode#203](https://leetcode.com/problems/remove-linked-list-elements/description/) Remove Linked List Elements ?
- keypoint is to create a dummy node in case of deleting head
```javascript
/**
 * Definition for singly-linked list.
 * function ListNode(val) {
 *     this.val = val;
 *     this.next = null;
 * }
 */
/**
 * @param {ListNode} head
 * @param {number} val
 * @return {ListNode}
 */
var removeElements = function(head, val) {
    let dummy = new ListNode(-1);
    dummy.next = head;
    let prev = dummy;
    let cur = prev.next;
    
    while (cur !== null) {
        if (cur.val === val) {
            prev.next = cur.next;
            cur = cur.next;
        } else {
            prev = cur;
            cur = cur.next;
        }
    }
    
    return dummy.next;
};
```
#### 10. [Leetcode#160](https://leetcode.com/problems/intersection-of-two-linked-lists/description/) Intersection of Two Linked Lists ?
- keypoint is to move the longer length list head forward to make its length equal to the short list length
```javascript
/**
 * Definition for singly-linked list.
 * function ListNode(val) {
 *     this.val = val;
 *     this.next = null;
 * }
 */

/**
 * @param {ListNode} headA
 * @param {ListNode} headB
 * @return {ListNode}
 */
var getIntersectionNode = function(headA, headB) {
    let lengthA = getLength(headA);
    let lengthB = getLength(headB);
    
    while (lengthA > lengthB) {
        lengthA--;
        headA = headA.next;
    }
    
    while (lengthB > lengthA){
        lengthB--;
        headB = headB.next;
    }
    
    while (headA !== null) {
        if (headA === headB) {
            return headA;
        }
        headA = headA.next;
        headB = headB.next;
    }
    
    return null;
};

var getLength = function(head) {
    let length = 0;
    while (head !== null) {
        head = head.next;
        length++;
    }
    return length;
}
```
#### 11. [Leetcode#2](https://leetcode.com/problems/add-two-numbers/description/) Add Two Numbers ?
- Two pointers, one holder and one new dummy head
```javascript
/**
 * Definition for singly-linked list.
 * function ListNode(val) {
 *     this.val = val;
 *     this.next = null;
 * }
 */
/**
 * @param {ListNode} l1
 * @param {ListNode} l2
 * @return {ListNode}
 */
var addTwoNumbers = function(l1, l2) {
    let l3 = new ListNode(-1);
    let dummy = l3;
    let holder = 0;
    
    while (l1 !== null || l2 !== null) {
        if (l1 !== null) {
            holder += l1.val;
            l1 = l1.next;
        }
        
        if (l2 !== null) {
            holder += l2.val;
            l2 = l2.next;
        }
        
        l3.next = new ListNode(holder % 10);
        holder = Math.floor(holder / 10);
        l3 = l3.next;
    }
    
    if (holder !== 0) {
        l3.next = new ListNode(holder % 10);
    }
    
    return dummy.next;
};
```
#### 12. [Leetcode#445](https://leetcode.com/problems/add-two-numbers-ii/description/) Add Two Numbers II ?
- Two stacks to help reverse lists
- New dummy head needs to move backwards
```javascript
/**
 * Definition for singly-linked list.
 * function ListNode(val) {
 *     this.val = val;
 *     this.next = null;
 * }
 */
/**
 * @param {ListNode} l1
 * @param {ListNode} l2
 * @return {ListNode}
 */
var addTwoNumbers = function(l1, l2) {
    let stack1 = [];
    let stack2 = [];
    let l3 = new ListNode(-1);
    let holder = 0;
    
    while (l1 !== null) {
        stack1.push(l1.val);
        l1 = l1.next;
    }
    while (l2 !== null) {
        stack2.push(l2.val);
        l2 = l2.next;
    }
    
    while (stack1.length > 0 || stack2.length > 0) {
        if (stack1.length > 0) {
            holder += stack1.pop();
        }
        if (stack2.length > 0) {
            holder += stack2.pop();
        }
        
        l3.val = holder % 10;
        holder = Math.floor(holder / 10);
        let newNode = new ListNode(holder);
        newNode.next = l3;
        l3 = newNode;
    }
    
    return l3.val === 0 ? l3.next : l3;
};
```