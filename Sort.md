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
