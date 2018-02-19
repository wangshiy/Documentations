# Sliding Window
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