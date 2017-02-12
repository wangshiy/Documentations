#### 1. Longest continuous sub-array with sum s ?
```javascript
preSum[i] = a[0] + a[1] + ... + a[i];
hashMap(preSum[i] + s, i);
if(hashMap.contains(preSum[i])){
  maxLength = max(maxLength, hashMap.get(preSum[i]) - i);
}
```
Time O(n) Space O(n)
``` JavaScript
function longestContinuousSubarray(a, target){
  var preSum = [];
  var hashMap = {};
  var maxLength = 0;
  for(var i = 0; i < a.length; i++){
    if(i === 0){
      preSum[i] = a[i];
    }else{
      preSum[i] = preSum[i-1] + a[i];
    }

    if(hashMap[preSum[i]] !== undefined){
      maxLength = Math.max(maxLength, i - hashMap[preSum[i]]);
    }else{
      hashMap[a[i] + target] = i;
    }
  }
  return maxLength;
}

var test = [6,3,5,-5,3,2,14];
console.log(longestContinuousSubarray(test,8)); // 5
```