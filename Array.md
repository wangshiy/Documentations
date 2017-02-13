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
#### 2. [Leetcode#300](https://leetcode.com/problems/longest-increasing-subsequence/) Longest Increasing Subsequence
If next one is larger then push to the result, else binary search to replace the first larger one. The result may not be correct but the length is, because replacing will lost nothing.
```javascript
/**
 * @param {number[]} nums
 * @return {number}
 */
var lengthOfLIS = function(nums) {
    var result = [];

    for(var i = 0; i < nums.length; i++){
        if(result.length === 0 || nums[i] > result[result.length - 1]){
            result.push(nums[i]);
        }else{
            var start = 0;
            var end = result.length - 1;
            while(start + 1 < end){
                var mid = parseInt(start + (end - start) / 2); //notice
                if(result[mid] > nums[i]){
                    end = mid;   
                }else{
                    start = mid;
                }
            }
            
            if(result[start] < nums[i]){
                result[end] = nums[i];
            }else{
                result[start] = nums[i];
            }
        }
    }
    
    return result.length;
};
```