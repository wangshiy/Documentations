# JavaScript
#### 1. Differences between `null` and `undefined` ? 
`undefined`: a variable has been declared but not assigned a value yet, and it is a data type
``` JavaScript
var a;
console.log(a); // undefined
console.log(typeof a); // "undefined"
```
`null`: an assignment value means variable has no value 
``` JavaScript
var a = null;
console.log(a); // null
console.log(typeof a); // "object"
```
#### 2. Differences between `==` and `===` ?
`==`: check value </br>
`===`: check type and value
#### 3. How to compare equality between two objects ?
Normal comparison is to compare reference, we need a deep object comparison
#### 4. Differences between `Object.keys()` and `Object.getOwnPropertyNames()` ?
`Object.keys()`: return an array of all **enumerable** and **own** properties</br>
`Object.getOwnPropertyNames()`: return an array of all **own** properties
```javascript
var a = {};
Object.defineProperties(a,{
  1:{enumerable:true, value:"one"},
  2:{enumerable:false, value:"two"}
});
console.log(Object.keys(a)); // ["1"]
console.log(Object.getOwnPropertyNames(a)); // ["1", "2"]
```
