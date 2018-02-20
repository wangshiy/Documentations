# Sliding Window
- Basic template is two while loops with two inner if conditions to move start/end pointer
```javascript
int findSubstring(string s){
        vector<int> map(128,0);
        int counter; // check whether the substring is valid
        int begin=0, end=0; //two pointers, one point to tail and one  head
        int d; //the length of substring

        for() { /* initialize the hash map here */ }

        while(end<s.size()){

            if(map[s[end++]]-- ?){  /* modify counter here */ }

            while(/* counter condition */){ 
                 
                 /* update d here if finding minimum*/

                //increase begin to make it invalid/valid again
                
                if(map[s[begin++]]++ ?){ /*modify counter here*/ }
            }  

            /* update d here if finding maximum*/
        }
        return d;
  }
```
#### 1. [Leetcode#76](https://leetcode.com/problems/minimum-window-substring/description/) Minimum Window Substring ?
- Build Hashmap for target
- Move end pointer to find matching window
- Move start pointer to minimize window size
``` JavaScript
/**
 * @param {string} s
 * @param {string} t
 * @return {string}
 */
var minWindow = function(s, t) {
  let start = 0;
  let end = 0;
  let total = 0;
  let substrStart = 0;
  let substrLength = Number.MAX_SAFE_INTEGER;
  const charHashmap = new Array(128).fill(0);
  // build hash map
  for (const i of t) {
    const charCode = i.charCodeAt(0);
    charHashmap[charCode]++;
    total++;
  }
  while (end < s.length) {
    // move end pointer
    const charCode = s[end].charCodeAt(0);
    if (charHashmap[charCode] > 0) {
      total--;
    }
    charHashmap[charCode]--;
    end++;
    // find a match
    while (total === 0) {
      // record potential candidate's length
      if (end - start < substrLength) {
        substrLength = end - start;
        substrStart = start;
      }
      // move start pointer
      const charCode = s[start].charCodeAt(0);
      if (charHashmap[charCode] === 0) {
        total++;
      }
      charHashmap[charCode]++;
      start++;
    }
  }
  
  return substrLength === Number.MAX_SAFE_INTEGER ? "" : s.substr(substrStart, substrLength);
};
```
#### 2. [Leetcode#159](https://leetcode.com/problems/longest-substring-with-at-most-two-distinct-characters/description/) Longest Substring with At Most Two Distinct Characters ?
- Build Hashmap for target
- Move end pointer to find matching window
- Move start pointer to minimize window size
``` JavaScript
/**
 * @param {string} s
 * @return {number}
 */
var charCodeUtil = function (c) {
    return c.charCodeAt(0);
}

var lengthOfLongestSubstringTwoDistinct = function(s) {
    let start = 0;
    let end = 0;
    let total = 0;
    let substrLength = 0;
    let map = new Array(128).fill(0);
    while (end < s.length) {
        if (map[charCodeUtil(s[end++])]++ === 0) {
            total++;
        }
        while (total > 2) {
            if (map[charCodeUtil(s[start++])]-- === 1) {
                total--;
            }
        }
        substrLength = Math.max(substrLength, end - start);
    }

    return substrLength;
};
```