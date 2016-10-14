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
```javascript
function isEqual(a,b){
  var aProperties = Object.getOwnPropertyNames(a);
  var bProperties = Object.getOwnPropertyNames(b);
  if(aProperties.length !== bProperties.length){
    return false;
  }
  for(var i = 0; i < aProperties.length; i++){
    var propName = aProperties[i];
    if(a[propName] !== b[propName]){
      return false;
    }
  }
  return true;
}

var obj1 = {name:"jim",age:16};
var obj2 = {name:"jim",age:16};

console.log(isEqual(obj1,obj2)); // true
```
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
#### 5. Extend the date instance to have a nextDate method ?
```javascript
Date.prototype.nextDate = function(){
  var currentDate = this.getDate();
  return new Date(this.setDate(currentDate + 1));
}

var date = new Date();
console.log(date.getDate()); // 13
console.log(date.nextDate().getDate()); // 14
```
