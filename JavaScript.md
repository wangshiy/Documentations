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
#### 6. How to use an arbitrary object as the value of this ?
`bind`: borrow the method, set the this and passed in arguments and then return it as a new function
```javascript
var a = {
  balance: 100,
  deduct: function(fee){
    this.balance -= fee;
  }
};
var b = {balance: 1000};

a.deduct(10);
console.log(a.balance); // 90
var bDeductFuc = a.deduct.bind(b,100);
bDeductFuc();
bDeductFuc();
console.log(b.balance); // 800
```
#### 7. Write a simple function to tell whether 2 is passed as parameter or not ?
`arguments` is an array like object, so it needs to be converted into array
```javascript
function isTwoPassed(){
  var args = Array.from(arguments);
  return args.indexOf(2) !== -1;
}

console.log(isTwoPassed(1,2,3,4)); // true
console.log(isTwoPassed(1,3,4)); // false
```
