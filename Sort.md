# Sort
#### 1. Bubble Sort(http://www.geeksforgeeks.org/bubble-sort/)?
```javascript
function bubbleSort(input: Array<Number>): Array<Number> {
  let swapped;
  let length = input.length;
  for (let i = 0; i < length-1; i++) {
    swapped = false;
    for (let j = 0; j < length-i-1; j++) {
      if (input[j] > input[j+1]) {
        swap(input,j,j+1);
        swapped = true;
      }
    }
    if (swapped === false) {
      break;
    }
  }
  
  return input;
}

function swap(input: Array<Number>, idx1: Number, idx2: Number): void {
  const temp = input[idx1];
  input[idx1] = input[idx2];
  input[idx2] = temp;
}

let a = [6,5,4,3,2,7];
document.write(bubbleSort(a));
```
#### 2. Priority Queue(https://www.hackerearth.com/practice/notes/heaps-and-priority-queues/)?
```javascript
class MaxPQ {
  
  constructor() {
    this.array = [];
  }
  
  swap(a, b) {
    const temp = this.array[a];
    this.array[a] = this.array[b];
    this.array[b] = temp;
  }
  
  maxHeapify(i, l) {
    const left = 2*i+1;
    const right = 2*i+2;
    let largest = i;
    
    if (left <= l && this.array[left] > this.array[i]) {
      largest = left;
    }
    if (right <= l && this.array[right] > this.array[largest]) {
      largest = right;
    }
    
    if (largest !== i) {
      this.swap(i, largest);
      this.maxHeapify(largest, l);
    }
    
  }

  isEmpty() {
    return this.array.length > 0 ? false : true;
  }
  
  peek() {
    if(this.array.length > 0) {
      return this.array[0];
    } else {
      return null;
    }
  }
  
  deq() {
    if(this.array.length > 0) {
      const max = this.array[0];
      this.array[0] = this.array[this.array.length-1];
      this.array.pop();
      this.maxHeapify(0, this.array.length-1);
      return max;
    } else {
      return null;
    }
  }
  
  increaseTo(i,v) {
    this.array[i] = v;
    while (i > 0 && this.array[Math.floor((i-1)/2)] < this.array[i]) {
      this.swap(Math.floor((i-1)/2), i);
      i = Math.floor((i-1)/2);
    }
  }
  
  enq(v) {
    this.array.push(Number.MIN_SAFE_INTEGER);
    this.increaseTo(this.array.length-1, v);
  }
}

const pq = new MaxPQ();
pq.enq(7);
pq.enq(2);
console.log(pq.peek());
pq.increaseTo(1,9);
console.log(pq.peek());
pq.enq(5);
pq.enq(11);
pq.enq(1);
for (let i = 0; i < 7; i++) {
  console.log(pq.deq());
}
```
#### 3. [Leetcode#23](https://leetcode.com/problems/merge-k-sorted-lists/description/) Merge k Sorted Lists ?
- Priority queue
```javascript
/**
 * Definition for singly-linked list.
 * function ListNode(val) {
 *     this.val = val;
 *     this.next = null;
 * }
 */
/**
 * @param {ListNode[]} lists
 * @return {ListNode}
 */
var mergeKLists = function(lists) {
    if (lists === null || lists.length === 0) {
        return null;
    }
    
    const pq = new MinPQ();
    for (let i = 0; i < lists.length; i++) {
        if (lists[i] !== null) {
            pq.insert(lists[i]);
        }
    }
    
    const dummy = new ListNode(-1);
    let cur = dummy;
    while (!pq.isEmpty()) {
        const temp = pq.pop();
        cur.next = temp;
        cur = temp;
        if (temp.next !== null) {
            pq.insert(temp.next);
        }
    }
    
    return dummy.next;
};

class MinPQ {
  
  constructor() {
    this.array = [];
  }
    
  isEmpty() {
    return this.array.length > 0 ? false : true;
  }
  
  swap(a, b) {
    const temp = this.array[a];
    this.array[a] = this.array[b];
    this.array[b] = temp;
  }
  
  minHeapify(i, l) {
    const left = 2*i+1;
    const right = 2*i+2;
    let largest = i;
    
    if (left <= l && this.array[left].val < this.array[i].val) {
      largest = left;
    }
    if (right <= l && this.array[right].val < this.array[largest].val) {
      largest = right;
    }
    
    if (largest !== i) {
      this.swap(i, largest);
      this.minHeapify(largest, l);
    }
    
  }
  
  peek() {
    if(this.array.length > 0) {
      return this.array[0];
    } else {
      return null;
    }
  }
  
  pop() {
    if(this.array.length > 0) {
      const min = this.array[0];
      this.array[0] = this.array[this.array.length-1];
      this.array.pop();
      this.minHeapify(0, this.array.length-1);
      return min;
    } else {
      return null;
    }
  }
  
  increaseTo(i,v) {
    this.array[i] = v;
    while (i > 0 && this.array[Math.floor((i-1)/2)].val > this.array[i].val) {
      this.swap(Math.floor((i-1)/2), i);
      i = Math.floor((i-1)/2);
    }
  }
  
  insert(v) {
    this.array.push(null);
    this.increaseTo(this.array.length-1, v);
  }
}
```

#### 4. [Sorting](http://khan4019.github.io/front-end-Interview-Questions/sort.html#quickSort) Quick sort ?
- Divide and Conquer, three functions `quickSort(array, left, right)`, `partition(array, pivotIdx, left, right)`, `swap(array, left, right)`
```javascript
    const test1 = [0]; // 0
    const test2 = [2,1]; // 1,2
    const test3 = [4,3,2,1,100]; // 1,2,3,4,100
    const test4 = [3,7,8,4,2,1,5]; // 1,2,3,4,5,7,8

    function quickSort(array, left, right) {
      let pivot = right; // take last element as the pivot
      let partitionIdx = 0;
      if (left < right) {
        partitionIdx = partition(array, pivot, left, right);
        quickSort(array, left, partitionIdx - 1);
        quickSort(array, partitionIdx + 1, right);
      }
      return array;
    }

    function partition(array, pivotIdx, left, right) {
      let pivotValue = array[pivotIdx];
      let partitionIdx = left;
      for (let i = left; i < right; i++) {
        if (array[i] < pivotValue) {
          swap(array, i, partitionIdx);
          partitionIdx++;
        }
      }
      swap(array, partitionIdx, right); // swap with last element as the pivot
      return partitionIdx;
    }

    function swap(array, left, right) {
      const temp = array[left];
      array[left] = array[right];
      array[right] = temp;
    }

    console.log(quickSort(test1, 0, test1.length - 1)); // 0
    console.log(quickSort(test2, 0, test2.length - 1)); // 1,2
    console.log(quickSort(test3, 0, test3.length - 1)); // 1,2,3,4,100
    console.log(quickSort(test4, 0, test4.length - 1)); // 1,2,3,4,5,7,8
```