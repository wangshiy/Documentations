# Linked List
#### 1. [Leetcode#206](https://leetcode.com/problems/reverse-linked-list/description/) Reverse Linked List ?
- Two pointers: pre and cur
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
#### 2. [Leetcode#234](https://leetcode.com/problems/palindrome-linked-list/description/) Palindrome Linked List ?
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