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
#### 3. How to compare equality between two objects(contains only object or array) ?
Normal comparison is to compare reference, we need a deep object comparison
```javascript
var obj1 = {
  name:"jim",
  a:{name:"tom",age:18},
  b:[1,{salary:100,age:[18]}]
};

var obj2 = {
  name:"jim",
  b:[1,{salary:100,age:[18]}],
  a:{name:"tom",age:18}
};

var obj3 = {name:"jim",age:16};
var obj4 = {name:"jim",age:16};

console.log(compareObjects(obj1,obj2));//true
console.log(compareObjects(obj3,obj4));//true

function compareObjects(o, p){
    var keysO = Object.keys(o).sort();
    var keysP = Object.keys(p).sort();
    if(keysO.length !== keysP.length)
        return false;//not the same nr of keys
    if(keysO.join('') !== keysP.join(''))
        return false;//different keys
    for(var i=0;i<keysO.length;++i){
        if(o[keysO[i]] instanceof Array){
            if (!(p[keysO[i]] instanceof Array))
                return false;
            if (compareObjects(o[keysO[i]], p[keysO[i]]) === false)
                return false;
        }else if(o[keysO[i]] instanceof Object){
            if (!(p[keysO[i]] instanceof Object))
                return false;
            if (compareObjects(o[keysO[i]], p[keysO[i]]) === false)
                return false;
        }else{
            if (o[keysO[i]] !== p[keysO[i]])//change !== to != for loose comparison
                return false;//not the same value
        }
    }
    return true;
}
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
#### 8. JavaScript pass by value or reference ?
Passed by value, but inner properties of objects are passed by reference.
```html
<!doctype html>
<html>
  <head>
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.5.6/angular.min.js"></script>
  </head>
  <body ng-app="refApp" ng-controller="refCtrl">
    <input ng-model="testObj.name"/>
    <input ng-model="testStr"/>
    <input ng-model="testObjRef.name"/>
    <button ng-click="submit()">submit</button>
    <script>
      var app = angular.module("refApp",[]);
      app.controller("refCtrl",["$scope",function($scope){
        $scope.testObj = {name:"str"};
        $scope.testStr = $scope.testObj.name;
        $scope.testObjRef = $scope.testObj;
        $scope.submit = function(){
            console.log($scope.testObj); // testObj and testObjRef are synchronized because they share the same reference
            console.log($scope.testStr); // String is primative, so it is passed by value
            console.log($scope.testObjRef);
        };
      }]);
    </script>
  </body>
</html>
```
```javascript
let a = [1,2];
let b = [null];
let c = [4]
b = a;
a = c;
b[0] = 2
a[0] = 3
console.log(b);
console.log(a);
console.log(c);
/*
[2, 2]
[3]
[3]
*/
```
#### 9. How could you use Math.max to find the max value in an array ?
Use `apply()`
```javascript
var a = [1,-1,10,5];
function getMax(arr){
    return Math.max.apply(null,arr);
}
console.log(getMax(a)); // 10
```
#### 10. How could you set a prefix before everything you log? for example, if you log('my','message') it will log: "(app) my message"
Convert array-like arguments to array: `var args = [].slice.call(arguments);`
```javascript
function log(){
    var args = Array.prototype.slice.call(arguments);
	args.unshift("(app)");
	console.log.call(console,args.join(" "));
}
log("a","b","c"); // "(app) a b c"
```
#### 11. How to log the loop counter inside setTimeout ? 
Use IIFE or `bind()` to create its own scope and pass i to it respectively
```javascript
for(var i = 0; i < 10; i++) {
	setTimeout((function(i) {
	    console.log(i);
	})(i), 10)
}
//*-----------------------------------*//
for(var i = 0; i < 10; i++) { 
	setTimeout(console.log.bind(console, i), 10);
}
```
#### 12. How to implement JQuery style chaining function
Every function returns its own object
```javascript
var obj = {
    first: function() { console.log('first'); return obj; },
    second: function() { console.log('second'); return obj; },
    third: function() { console.log('third'); return obj; }
}

obj.first().second().third();
```
#### 13. How to implement moveRight animation ?
`setInterval` and then when distance matching `clearInterval`
```html
<!doctype html>
<html>
  <head>
  </head>
  <body>
    <div id="testAnimation" style="height:50px;width:50px;background-color:red;position:absolute;">
    </div>
    <script>
      var elem1 = document.getElementById("testAnimation");

      function moveRight(elem, distance){
        var left = 0;

        function frame() {
          left++;
    		  elem.style.left = left + 'px';
    		  if(left === distance){
      		  clearInterval(timeId)
  		    }
        }

        var timeId = setInterval(frame, 10); // draw every 10ms
      }

      moveRight(elem1,100);
    </script>
  </body>
</html>
```
#### 14. How to loop through array and remove item while array is reindexing?
Loop backwards.
This way the re-indexing doesn't affect the next item in the iteration, since the indexing affects only the items from the current point to the end of the Array, and the next item in the iteration is lower than the current point.
```javascript
    var a = [2,2,2,4,6,8];
    for(var i = 0; i < a.length; i++){
      if(a[i] % 2 === 0){
        a.splice(i,1);
      }
    } 
    console.log(a);//[2,4,8]

    var b = [2,2,2,4,6,8];
    for(var i = b.length - 1; i >= 0; i--){
      if(b[i] % 2 === 0){
        b.splice(i,1);
      }
    }
    console.log(b);//[]
```
#### 15. Run function when user finished typing?
```javascript
<!doctype html>
<html>
  <head>
  </head>
  <body>
  	<input id="input1" />

  	<script type="text/javascript">
      var input = document.getElementById("input1");
      var timer;
      input.addEventListener("keyup",function(evt){
          console.log("keyup");
          clearTimeout(timer);
          timer = setTimeout(doneTyping,3000);
      },false);
      input.addEventListener("keydown",function(evt){
      	  console.log("keydown");
      	  clearTimeout(timer);
      },false);

      function doneTyping(){
      	alert("typing done!");
      }
  	</script>
  </body>
</html>
```
#### 16. How do you make a function that only calls input function f every 1000 milliseconds?
```javascript
function exec(f){
  setInterval(f, 1000);
}
function innerFunc(){
  console.log("inner");
}
exec(innerFunc);
```
#### 17. Given two identical DOM trees (not the same one), and a node from one of them find the node in the other one ?
Thought is to get the path from the domTree1 and use this path to relocate node in domTree2
```javascript
<html>
  <head>
    <title></title>
    <style></style>
  </head>
  <body>
    <div>haha</div>
    <div>
      <span>a</span>
      <div>
        b
        c
        <div id="target">target</div>
      </div>
    </div>
    
    <script>
var target = document.getElementById("target");
var dom1 = document.documentElement;//return the root element i.e. <html>
var dom2 = document.documentElement;

// childNodes is an arrayLike object
// it can not use array method then we needs to extend it
function indexOf(arrLike, target) {
    return Array.prototype.indexOf.call(arrLike, target);
}

// Given a node and a tree, extract the nodes path 
function getPath(root, target) {
    var current = target;
    var path = [];
    while(current !== root) {
        path.unshift(indexOf(current.parentNode.childNodes, current));
        current = current.parentNode;
    }
    console.log("path: " + path);
    return path;
}

// Given a tree and a path, let's locate a node
function locateNodeFromPath(root, path) {
    var current = root;
    for(var i = 0, len = path.length; i < len; i++) {
        current = current.childNodes[path[i]];
    }
    return current;
}

function getDom(rootA, rootB, target) {
    return locateNodeFromPath(rootB, getPath(rootA, target));
}

console.log(getDom(dom1,dom2,target).innerHTML);
    </script>
  </body>
</html>
```
#### 18. How many childNodes are there in the div ?
5 childNodes. Because text node between elements also counts
```javascript
<!DOCTYPE html>
<html>
<head>
<style>
div {
    border: 1px solid black;
    margin: 5px;
}
</style>
</head>
<body>

<p>Click the button to find out how many child nodes the div element below has.</p>

<button onclick="myFunction()">Try it</button>

<div id="myDIV">a
  b<p>First p element (index 1)</p>c
  d<p>Second p element (index 3)</p>e
</div>

<p><strong>Note:</strong> Whitespace inside elements is considered as text, and text 
is considered as nodes. In this example, index 0, 2 and 4 in DIV are text nodes.</p>

<p id="demo"></p>

<script>
function myFunction() {
    var c = document.getElementById("myDIV").childNodes[2].nodeValue;
    document.getElementById("demo").innerHTML = c;
}
</script>

</body>
</html>
```
#### 19. Given an array, return it's flattened structure(skip objects), write both recursive and iterative version ?
Recursive
```javascript
Array.prototype.flatten = function(mutable) {
    var ret = [];
    for(var i = 0; i < this.length; i++) {
        if(Array.isArray(this[i])) {
            ret = ret.concat(this[i].flatten(mutable));
        } else {
            ret.push(this[i]);
        }
    }
    
    return mutable ? ret : JSON.parse(JSON.stringify(ret));
};

var array = [
  [0,[undefined,null], 1],
  undefined, 
  [2,null, 3], 
  [4, 5, [6, 7, [8, [9, 10]]]],
  [[{name:["jimmy","tom"]},8],'bbbb']
];
var test1 = array.flatten(false);
test1[15].name = "xyz";
console.log(test1, array); // does not mutate array
var test2 = array.flatten(true);
test2[15].name = "xyz";
console.log(test2, array); // mutate array
var test3 = [[[[[0]], [1]], [[[2], [3]]], [[4], [5]]]].flatten();
console.log(test3);// [0, 1, 2, 3, 4, 5]
```
Iterative
```javascript
// This is done in a linear time O(n) without recursion
// memory complexity is O(1) or O(n) if mutable param is set to false
function flatten(array, mutable) {
    var toString = Object.prototype.toString;
    var arrayTypeStr = '[object Array]';
    
    var result = [];
    var nodes = array.slice(); //slice is just shallow copy
    var node;
    
    if (!array.length) {
        return result;
    }
    
    while (nodes.length) {
      node = nodes.shift();
        if (toString.call(node) === arrayTypeStr) {
            nodes.unshift.apply(nodes, node);
        } else {
            result.push(node);
        }
    }

    return mutable ? result : JSON.parse(JSON.stringify(result));
}

var array = [
  [0,[undefined,null], 1],
  undefined, 
  [2,null, 3], 
  [4, 5, [6, 7, [8, [9, 10]]]],
  [[{name:["jimmy","tom"]},8],'bbbb']
];
var test1 = flatten(array,false);
test1[15].name = "xyz";
console.log(test1, array); // does not mutate array
var test2 = flatten(array, true);
test2[15].name = "xyz";
console.log(test2, array); // mutate array
```
#### 20. How to reverse a string ?
```javascript
String.prototype.reverse = function(){
  return this.split('').reverse().join('');
}

var str = "hello world!";
console.log(str.reverse());
```
#### 21. How could you make this work [1,2,3,4,5].duplicator(); // [1,2,3,4,5,1,2,3,4,5] ?
```javascript
Array.prototype.duplicate = function(){
  return this.concat(this);
}

var a = [1,2,7,3,4,5];
console.log(a.duplicate());
```
#### 22. How to implement javascript inheritance ?
`Child.prototype = Object.create(Parent.prototype)` and `Child.prototype.constructor = Child`
```javascript
// Shape - superclass
function Shape() {
  this.x = 0;
  this.y = 0;
}

// superclass method
Shape.prototype.move = function(x, y) {
  this.x += x;
  this.y += y;
  console.info('Shape moved.');
};

// Rectangle - subclass
function Rectangle() {
  Shape.call(this); // call super constructor.
  this.z = 0;
}

// subclass extends superclass
Rectangle.prototype = Object.create(Shape.prototype);
Rectangle.prototype.constructor = Rectangle;

var rect = new Rectangle();

console.log(rect);
console.log('Is rect an instance of Rectangle?', rect instanceof Rectangle);// true
console.log('Is rect an instance of Shape?', rect instanceof Shape);// true
rect.move(1, 1); // Outputs, 'Shape moved.'
```
#### 23. How could you implement cache to save calculation time for a recursive fibonacci function ?
`var memo = {}` and `if(n in memo)` and need the closure function to access outside memo object
```javascript
function fab1(n){
  if(n < 2){
    return 1;
  }
  return fab1(n-2) + fab1(n-1);
}

function fab2(n){
  var memo = {};
  function f(n){
    var value;
    if(n in memo){
      value = memo[n];
    }else{
      if(n < 2){
        value = 1;
      }else{
        value = f(n-2) + f(n-1);
      }
      memo[n] = value;
    }
    return value;
  }
  return f(n);
}
var a1 = performance.now();
console.log(fab1(20));
var b1 = performance.now();
console.log("fab1 take " + (b1 - a1) + " ms");

var a2 = performance.now();
console.log(fab2(20));
var b2 = performance.now();
console.log("fab2 take " + (b2 - a2) + " ms");

/**Log
10946
"fab1 take 1.4499999999999993 ms"
10946
"fab2 take 0.5650000000000013 ms"
**/
```
#### 24. How to check if object is empty ?
```javascript
Object.keys(a).length === 0
```
#### 25. How to implement debounce function ?
Keypoint is debounce will return a closure, inner function access outside `timeout` and do `clearTimeout(timeout);timeout = setTimeout(later,wait);`
```javascript
<!DOCTYPE html>
<html>
  <head>
  </head>
  <body>
    <input id="myInput" />

    <script type="text/javascript">
      // Returns a function, that, as long as it continues to be invoked, will not
      // be triggered. The function will be called after it stops being called for
      // N milliseconds. If `immediate` is passed, trigger the function on the
      // leading edge, instead of the trailing.
      function debounce(func, wait, immediate) {
        var timeout;
        return function() {
          var context = this, args = arguments;
          var later = function() {
            timeout = null;
            func.apply(context, args);
          };
          var callNow = immediate && !timeout; // optional due to immediate
          clearTimeout(timeout);
          timeout = setTimeout(later, wait);
          if (callNow) func.apply(context, args); // optional due to immediate
        };
      };

      var myEfficientFn = debounce(function() {
        console.log(1);
      }, 250,false);

      var myInput = document.getElementById("myInput");
      myInput.addEventListener('keyup', myEfficientFn);
    </script>
  </body>
</html>
```
We can also use decorator design pattern as below
```javascript
<!DOCTYPE html>
<html>
<head>
</head>
<body>
  <input id="myInput">
  <script>
    var myInput = document.getElementById("myInput");

    function debounce(func,wait){
      var timeoutId;

      function wrapper(){
        if(timeoutId){
          clearTimeout(timeoutId);
          timeoutId = setTimeout(func,wait);
        }else{
          timeoutId = setTimeout(func,wait);
        }
      }

      return wrapper;
    }

    function execute(){
      console.log("type");
    }

    myInput.addEventListener("keyup",debounce(execute,250),false);
  </script>
</body>
</html>
```
#### 25.1 How to implement throttle function ?
Keypoint is throttle will return a closure, inner function access outside `canExe`, when `canExe` is false then do nothing, otherwises `setTimeout` to execute
```javascript
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width">
  <title>JS Bin</title>
</head>
<body onresize="throttledResize()">

<script type="text/javascript">
  function throttle(func, wait){
    let canExe = true;
    function wrapper(){
      if(!canExe){
        return;
      }
      canExe = false;
      setTimeout(() => {
        canExe = true;
        func.apply(this,arguments);
      }, wait);
    }

    return wrapper;
  }

  function resize() {
    console.log('resize');
  }

  var throttledResize = throttle(resize, 500);
</script>
</body>
</html>
```
#### 26. How to implement privacy in javascript ?
Use module design pattern i.e. invoke IIFE to create closure and return object that project variables and methods.
```javascript
var Exposer = (function(){
  var privateCount = 0;
  
  var privateFunc = function(){
    privateCount++;
  }
  
  var incre = function(){
    privateFunc();
  }
  
  var display = function(){
    console.log(privateCount);
  }
  
  return {
    incre: incre,
    display: display
  };
})();

Exposer.display();
Exposer.incre();
Exposer.display();
```
#### 27. How to implement observer design pattern in javascript ?
Two class: `Subject` and `Observer`. Subject maintain a queue of Observers, subscribe/unsubscribe and notify/broadcast function. Observer provide notify function.
```javascript
var Subject = function() {
  return {
    observers: [],
    subscribeObserver: function(observer) {
      this.observers.push(observer);
    },
    unsubscribeObserver: function(observer) {
      var index = this.observers.indexOf(observer);
      if(index > -1) {
        this.observers.splice(index, 1);
      }
    },
    notifyObserver: function(observer) {
      var index = this.observers.indexOf(observer);
      if(index > -1) {
        this.observers[index].notify(index);
      }
    },
    notifyAllObservers: function() {
      for(var i = 0; i < this.observers.length; i++){
        this.observers[i].notify(i);
      };
    }
  };
};

var Observer = function() {
  return {
    notify: function(index) {
      console.log("Observer " + index + " is notified!");
    }
  }
}

var subject = new Subject();

var observer1 = new Observer();
var observer2 = new Observer();
var observer3 = new Observer();
var observer4 = new Observer();

subject.subscribeObserver(observer1);
subject.subscribeObserver(observer2);
subject.subscribeObserver(observer3);
subject.subscribeObserver(observer4);

subject.notifyObserver(observer2); // Observer 2 is notified!

subject.notifyAllObservers();
// Observer 1 is notified!
// Observer 2 is notified!
// Observer 3 is notified!
// Observer 4 is notified!
```
#### 28. How to implement singleton design pattern in javascript ?
```javascript
var Singleton = (function () {
    var instance;
 
    function createInstance() {
        var object = new Object("I am the singleton instance");
        return object;
    }
 
    return {
        getInstance: function () {
            if (!instance) {
                instance = createInstance();
            }
            return instance;
        }
    };
})();
 
var instance1 = Singleton.getInstance();
var instance2 = Singleton.getInstance();
 
console.log("Same instance? " + (instance1 === instance2));
```
#### 29. How to remove last two characters from a string ?
```javascript
var str = "hello world!!!"
console.log(str.slice(0,-2));
```
#### 30. What is the difference between `.map()` and `.forEach()` ?
`.map()` returns a new array so it will not pollute input array, while `.forEach()` doesn't return, it just execute function based on each element, so it may pollute input array
```javascript
var a = [1,2,3,4,5];
var b = [1,2,3,4,5];
var map = a.map(function(elem){
  return elem*2;
});
var forEach = b.forEach(function(elem,index,ary){
  ary[index] = elem*2;
});

console.log(map);// [2, 4, 6, 8, 10]
console.log(a); // [1, 2, 3, 4, 5]
console.log(forEach); // undefined
console.log(b); // [2, 4, 6, 8, 10]
```
#### 31. How to implement decorator design pattern in javascript ?
A function decorator accepts a function, wraps (or decorates) it’s call and returns the wrapper, which modifies/extends its behavior.
The core code is to return a closure function `wrapper` and do `return f.apply(this,arguments)` in the wrapper
```javascript
function decorator(f){
  function wrapper(){
    return f.apply(this, arguments);
  }

  return wrapper;
}
```
#### 31.1. Create a function makeLogging(f) which takes an arbitrary function f, and makes a wrapper over it which logs calls. The wrapper should have a static outputLog() method to output the log.
Should work like this:
```javascript
    function work(a,b) { /* arbitrary function */ }

    function makeLogging(f) { /* your code */ }

    work = makeLogging(work)

    // now work should log it's calls somewhere (but not in global)
    work(1,2)
    work(5,6)
    work.outputLog() // <-- should alert('1,2'), alert('5,6')
```
No modifications of work are allowed. Your code should reside only in makeLogging.
```javascript
function work(a,b){
  console.log("work");
}
 
function makeLogging(f) { 
  var log = [];
 
  function wrapper() {
    log.push(arguments);
    return f.apply(this, arguments);
  }
 
  wrapper.outputLog = function() {  
    for(var i = 0; i < log.length; i++){
      console.log(Array.prototype.join.call(log[i], ','));
    }
  }
 
  return wrapper
}
 
work = makeLogging(work);
 
work(1, 10);
work(2, 20);
work.outputLog();
```
#### 31.2. Create a function makeCaching(f) which takes a one-argument function f(arg), and makes a wrapper over it which caches calls. The wrapper should have a static flush() method to flush the cache.

Function f is allowed to have only one argument.

Should work like this:
```javascript
    function work(arg) { return Math.random()*arg }

    function makeCaching(f) { /* your code */ }

    work = makeCaching(work);

    var a = work(1);
    var b = work(1);
    alert( a == b ) // true (cached)

    work.flush()    // clears the cache

    b = work(1)
    alert( a == b ) // false
```
No modifications of work are allowed. Your code should reside only in makeCaching.
```javascript
function work(arg){ 
  return Math.random()*arg;
}
 
function makeCaching(f) { 
  var cache = {};  
 
  function wrapper(arg) {
    if (!(arg in cache)) {
      cache[arg] = f.call(this, arg);
    }
    return cache[arg];
  }
 
  wrapper.flush = function() {  
    cache = {};
  }
 
  return wrapper;
}
 
work = makeCaching(work);
 
alert( work(1) );
alert( work(1) );
work.flush();      
alert( work(1) );
```
#### 31.3. How to cache more than one argument function execution ?
```javascript
function work(a,b,c){
  return Math.random()*a*b*c;
}

function makeCache(f){
  var cache = {};
  
  function wrapper(){
    var key = Array.prototype.join.call(arguments,",");
    if(!(key in cache)){
      cache[key] = f.apply(this,arguments);
    }
    return cache[key];
  }
  
  function showCache(){
    return cache;
  }
  
  return {
    wrapper:wrapper,
    showCache:showCache
  };
}

var newWork = makeCache(work);
console.log(newWork.wrapper(1,2,3));
console.log(newWork.wrapper(1,2,4));
console.log(newWork.wrapper(1,2,3));
console.log(newWork.showCache());
```
```javascript
function work(a,b,c){
  return Math.random() * a * b * c;
}
 
function makingCache(f){
  var cache = {};
   
  function wrapper(){
    var args = Array.from(arguments);//typeof arguments is object, so this is to convert array like object
    console.log(args);
    var key = args.join(",");
    if(!(key in cache)){
      cache[key] = f.apply(this,args);
    }
    return cache[key];
  }
   
  wrapper.showCache = function(){
    return cache;
  }
   
  return wrapper;
}
 
work = makingCache(work);
 
console.log(work(1,2,3));
console.log(work(1,2,3));
 
console.log(work.showCache());
```
#### 32. Difference between class inheritance and prototype inheritance ?
Class Inheritance: class is the blueprint to instantiate instance, classed inherit from classes and create hierachical class taxonomies. 

Problems:
- Tight coupling
- Inflexible hierarchy
- Gorilla/banana problem

Prototype Inheritance: prototype is a working object, and object directly inherits from object.
#### 33. What is XSRF attck and how to prevent ?
XSRF is Cross Site Request Forgery is an attack that forces an end user to execute unwanted actions on a web application in which they're currently authenticated

Protection:
- Verify the origin headers matching each other

#### 34. What is XSS attck and how to prevent ?
XSS is Cross Site Scripting, it is an attack that injects malicious scripts into trusted websites.

Protection:
- Escape HTML/Attributes/Javascript before insert untrusted data
- Use `application/json` instead of `text/html` as the Content-Type and read response data from `JSON.parse()`
- Use HttpOnly cookie flag

#### 35. What is MITM attck and how to prevent ?
MITM is Man In The Middle, it is an attack that relays or alters the communications between two parties that each believes communicate with each other directly.

Protection:
- Use HTTPS

Because browser 

1. Checks received certificate info matches the server info
2. Certificate must be valid and signed by the browser trusts Certification Authority (CA)

#### 36. How to make an accordion ?
`this.classList.toggle()` and `this.nextElementSibling.style`
```javascript
<!DOCTYPE html>
<html>
<head>
  <style>
    .accordion:hover,.active{
      background-color: #ddd;
    }
    .panel{
      display:none;
    }
  </style>
</head>
<body>
  <h2 class="accordion">section1</h2>
  <div class="panel">
    <p>content1</p>
    <span>content1</span>
  </div>
  
  <h2 class="accordion">section2</h2>
  <div class="panel">
    <p>content2</p>
    <span>content2</span>
  </div>
  
  <script>
    var accordions = document.getElementsByClassName("accordion");
    function toggleDisplay(){
      this.classList.toggle("active");

      var styleProp = this.nextElementSibling.style;
      if(styleProp.display === "none" || styleProp.display === ""){
        styleProp.display = "block";
      }else{
        styleProp.display = "none";
      }
    }
    for(var i = 0; i < accordions.length; i++){
      accordions[i].addEventListener("click",toggleDisplay,false);
    }
  </script>
</body>
</html>
```
#### 37. What is the difference between `.childNodes` and `.children` ?
`.children`: return the children whose types are element
`.childNodes`: return the children whose types are node, i.e. including textNode
```javascript
var el = document.createElement("div");
el.textContent = "foo"
el.childNodes.length === 1; // TextNode is a node child
el.children.length === 0; // no Element children
```
#### 38. How to optimize String repeat method ?
```javascript
      function repeatStr(str,n){
        var result = "";
        for(var i = 0; i < n; i++){
          result += str;
        }
        return result;
      }

      function repeatStrOpt(str,n){
        var result = str;
        var times = n;
        var modulusStr = str;
        var modulusTimes = 0;
        var modulusStrResult = "";

        while(parseInt(times / 2) !== 1){
          modulusTimes = times % 2;
          if(modulusTimes === 1){ // modulusStr will be the previous result str
            modulusStr = result;
            modulusStrResult += modulusStr;
          }
          times = parseInt(times / 2);
          result += result;
        }

        //handle the last case i.e. end up with 2 or 3
        if(times % 2 === 0){
          result += result + modulusStrResult;
        }else{
          result += result + result + modulusStrResult;
        }

        return result;
      }

      var p1 = performance.now();
      console.log(repeatStr("a",13));
      var p2 = performance.now();
      console.log(p2 - p1);

      var p3 = performance.now();
      console.log(repeatStrOpt("a",13));
      var p4 = performance.now();
      console.log(p4 - p3);
```
#### 39. How to flatten nested object ?
```javascript
var flattenObject = function(ob) {
  var toReturn = {};
  
  for (var i in ob) {
    // if (!ob.hasOwnProperty(i)) continue; // [optional code] check if object has its own property i.e. not inherited
    
    if (ob[i] && (typeof ob[i]) == 'object') {
      var flatObject = flattenObject(ob[i]);
      for (var x in flatObject) {
        // if (!flatObject.hasOwnProperty(x)) continue; // [optional code] check if object has its own property i.e. not inherited
        
        toReturn[i + '.' + x] = flatObject[x];
      }
    } else {
      toReturn[i] = ob[i];
    }
  }
  return toReturn;
};

console.log(flattenObject(myObject));
```
#### 40. How to init 2D array ?
```javascript
var myarray = [...Array(6).keys()].map(i => Array(6));
```
#### 41. Blacklist and whitelist ?
```javascript
let test2 = ['a','b','c'];
console.log(test2.indexOf('a') !== -1); // blacklist
console.log(test2.indexOf('d') !== -1); // whitelist
```
#### 42. Remove duplicate by inner property ?
```javascript
let test1 = [{
  name: 'a'
}, {
  name: 'a'
}, {
  name: 'b'
}];


function rmDupByInnerProp(array, prop) {
  return array.filter((elem,idx,ary) => {
    return ary.map(mapObj => mapObj[prop]).indexOf(elem[prop]) === idx;
  })
}
```
#### 43. How to make an horizontal scroll bar ?
```javascript
<!DOCTYPE html>
<html>
<head>
  <style>
    .visible-window {
      display: flex;
      width: 100px;
      overflow: hidden;
    }

    .item-container {
      display: flex;
      list-style: none;
    }

    .item-main {
      border-right: 1px solid black;
    }

    .item {
      min-width: 50px;
      max-width: 50px;
      overflow: hidden;
      text-overflow: ellipsis;
      text-align: center;
    }

    .item-shift-left {
      margin-left: 0px;
    }
  </style>
</head>
<body>
  <ul class="item-container">
    <li class="item item-main" title="all">all</li>
    <button onclick="moveLeft()"><</button>
    <div class="visible-window">
      <li class="item item-shift-left" title="aag">aaabffffffff</li>
      <li class="item" title="aag">aaabffffffff</li>
      <li class="item" title="aag">aaabffffffff</li>
      <li class="item" title="aag">aaabffffffff</li>
      <li class="item" title="aag">aaabffffffff</li>
    </div>
    <button onclick="moveRight()">></button> 
  </ul>
  
  <script>
    var itemShiftLeft = document.getElementsByClassName('item-shift-left')[0];
    var marginLeft = 0;
    function moveLeft() {
      marginLeft -= 20;
      itemShiftLeft.style.marginLeft = marginLeft + 'px';
      console.log(itemShiftLeft.style.marginLeft);
    }
    function moveRight() {
      marginLeft += 20;
      itemShiftLeft.style.marginLeft = marginLeft + 'px';
      console.log(itemShiftLeft.style.marginLeft);
    }
  </script>
</body>
</html>
```
#### 44. Array vertical sum ?
```javascript
const a1 = [1,2,3,4];
const a2 = [null, -1, 12, 0];
let totalSumArray = [a1, a2];
totalSumArray = totalSumArray.reduce((array1, array2) => {
  return array1.map((value, index) => (
    isNaN(value) ? 0 : value) + (isNaN(array2[index]) ? 0 : array2[index]));
});

console.log(totalSumArray);
// [1, 1, 15, 4]
```
#### 45. Difference between function and arrow function ?
There is no `this` binding in arrow function, but function has `this` 
```javascript
const obj = {
  name: 'jim',
  a: () => { console.log(this.name, this)},
  b: function () {
    console.log(this.name, this);
  }
}

obj.a();
obj.b();
// undefined, Window
// jim, obj
```
#### 46. Difference between lexical scope and dynamic scope ?
- Lexical scope (static scope) that is the function's scope is defined within the function or look up
- Dynamic scope that is the function's scope is defined with the code execution phase
- Javascript is using lexical scope, bash shell script is using dynamic scope
```javascript
var a = 2;

function foo() {
  console.log(a); // 会输出2还是3？
}

function bar() {
  var a = 3;
  foo();
}

bar();
// output 2
```

#### 47. Difference between lexical scope and dynamic scope ?
- 事件循环每次只会入栈一个 macrotask ，主线程执行完该任务后又会先检查 microtasks 队列并完成里面的所有任务后再执行 macrotask
- macrotasks: setTimeout, setInterval, setImmediate, I/O, UI rendering
- microtasks: process.nextTick, Promises, Object.observe(废弃), MutationObserver
```javascript
console.log('start');
let intervalId;
Promise.resolve()
  .then(() => {
  console.log('p1');
}).then(() => {
  console.log('p2');
});

setTimeout(() => {
  Promise.resolve()
    .then(() => {
    console.log('p3');
  }).then(() => {
    console.log('p4');
  });
  intervalId = setInterval(() => {
    console.log('interval');
  },3000);
  console.log('timeout1');
},0);

setTimeout(() => {
  console.log('timeout2');
  Promise.resolve().then(
    () => {
    console.log('p5');
    clearInterval(intervalId);
    });
},0)

// start, p1, p2, timeout1, p3, p4, timeout2, p5
```

#### 48. How to make Object iterable ?
- Overwrite `@@iterator` method with generator function
```javascript
let options = {
  male: 'John',
  female: 'Gina',
  rel: 'Love'
}

options[Symbol.iterator] = function *() {
  let self = this;
  for (const key in self) {
    yield `${key}:${self[key]}`;
  }
}

console.log([...options]);
console.log('==========');
for (const k of options) {
  console.log(k);
}
/*
["male:John", "female:Gina", "rel:Love"]
"=========="
"male:John"
"female:Gina"
"rel:Love"
*/
```

#### 49. Use async/await to simulate pause function ?
- `async` is the syntac sugar for `generator`, i.e. `async` is `function*`, `await` is `yield`
```javascript
// noprotect
function sleep(ms) {
  return new Promise((resolve, reject) => {
    setTimeout(() => {
      resolve(`sleep ${ms} ms`);
    }, ms);
  });
}

async function asyncSleep() {
  console.time('totalTime:');
  let awt = [];
  for (let i = 0; i < 5; i++) {
    awt.push(sleep(i * 1000 * 0.5));
  }
  for (const a of awt) {
    console.log(await a);
  }
  console.timeEnd('totalTime:');
}

asyncSleep();
```

#### 50. The principle and methods of implementing jsonp ?
- JSONP utilize the fact that `<script>` `src` attribute to handle cors, so it only support `get` method
- It sends callback function to server and let server fill the data and then invoke later
- `node server.js`
```javascript
<!DOCTYPE html>
<html>
<head>
  <title></title>
</head>
<body>
  <p id="resContainer"></p>
  <p id="resContainer1"></p>
  <button onclick="jsonpClickHandler()">getData</button>
  <button onclick="jsonpClickHandler1()">getData</button>


  <script type="text/javascript">
    var resContainer = document.getElementById("resContainer");
    var resContainer1 = document.getElementById("resContainer1");

    function jsonp(req){
      var scriptPlaceHolder = document.getElementsByTagName('head')[0].childNodes[2];
      console.log('scriptPlaceHolder', scriptPlaceHolder);
        var script = document.createElement('script');
        var url = req.url + '?callback=' + req.callback.name; // req.callback.name is the function name
        script.src = url;
        scriptPlaceHolder.replaceWith(script);
    }

    function hello(res){
        resContainer.innerHTML = res.data;
    }

    function hello1(res){
        resContainer.innerHTML = res.data;
    }

    function jsonpClickHandler() {
      jsonp({
          url : 'http://localhost:8888',
          callback : hello 
      });
    }

    function jsonpClickHandler1() {
      jsonp({
          url : 'http://localhost:8888',
          callback : hello1 
      });
    }
  </script>
</body>
</html>
```
```javascript
var http = require('http');
var urllib = require('url');

var port = 8888;
var data = {'data':'response from server'};

http.createServer(function(req,res){
    var params = urllib.parse(req.url,true);
    if(params.query.callback){
        console.log(params.query.callback);
        //jsonp
        var str = params.query.callback + '(' + JSON.stringify(data) + ')';
        res.end(str);
    } else {
        res.end();
    }
    
}).listen(port,function(){
    console.log('jsonp server is on');
});
```

#### 51. Implement template string replacement using RegExp ?
- `/\$\{\w+\}/gi`
```javascript
  const test = {
    gaga: 'jim',
    haha: 17
  }
  const reg = /\$\{\w+\}/gi;

  function replacer(match, args) {
    const arg = match.substring(2, match.length-1);
    console.log('match and arg:', match, arg, this[arg]); // match and arg: ${gaga} gaga jim; match and arg: ${haha} haha 17;
    return this[arg];
  }

  console.log('result before: ','{name: ${gaga}, age: ${haha}}'); // result before:  {name: ${gaga}, age: ${haha}}
  console.log('result after: ','{name: ${gaga}, age: ${haha}}'.replace(reg, replacer.bind(test))); // result after:  {name: jim, age: 17}
```

#### 52. Implement middleware design pattern ?
- keypoint is to maintain a function queue
```javascript
const App = {
    fns: [],
    ctx: {
      name: ''
    },
    callback: function () {
      console.log(this.ctx);
    },
    use: function (fn) {
      this.fns.push(fn);
      return this;
    },
    go: function () {
        this.next();
        this.callback();
    },
    next: function() {
      if (this.fns && this.fns.length > 0) {
        const fn = this.fns.shift();
        fn.call(this, this.ctx, this.next.bind(this));
      }
    }
};

App.use(function (ctx, next) {
    ctx.name = 'hello';
    next();
});

App.use(function (ctx, next) {
    ctx.name += ' world';
    next();
});

App.use(function (ctx, next) {
    ctx.name += '!!!';
    next();
});

App.go(); // {name: 'hello world!!!'}
```

#### 53. Remove duplicates with different types ?
- use typeof and original value as key
```javascript
var a = [1,'2','1','ab', 1, 'string']

function removeDup(ary) {
    return [...new Set(ary)];
}

console.log(removeDup(a)); // [1,'2','1','ab','string']
```

#### 54. How to create a lazy loading scroll area ?
- scrollHeight - (scrollTop + clientHeight) <= TRIGGER_SCROLL_SIZE
```javascript
<!DOCTYPE html>
<html>
<head>
  <title></title>
  <style type="text/css">
    #scroll-box {
      height: 400px;
      display: flex;
      align-items: center;
      justify-content: center;
    }

    #content {
      width: 200px;
      height: 200px;
      padding: 20px 0;
      margin: 30px 0;
      overflow: auto;
    }

    #content p{
      height: 20px;
    }
  </style>
</head>
<body>

  <div id="scroll-box">
    <div id="content" onscroll="scrollHandler()">
      <p>sdfsf</p>
      <p>sdfsf</p>
      <p>sdfsf</p>
      <p>sdfsf</p>
      <p>sdfsf</p>
      <p>sdfsf</p>
      <p>sdfsf</p>
      <p>sdfsf</p>
      <p>sdfsf</p>
    </div>
  </div>

  <script type="text/javascript">
    TRIGGER_SCROLL_SIZE = 50;
    var content = document.getElementById("content");

    function scrollHandler() {
      var scrollHeight = content.scrollHeight;
      var scrollTop = content.scrollTop;
      var clientHeight = content.clientHeight;
      console.log(`scrollTop: ${scrollTop}, scrollHeight: ${scrollHeight}, clientHeight: ${clientHeight}, substraction: ${scrollHeight - (scrollTop + clientHeight)}`);
      if (scrollHeight - (scrollTop + clientHeight) <= TRIGGER_SCROLL_SIZE) {
        console.log('append');
        var node = document.createElement("p");
        var textNode = document.createTextNode("ppp");
        node.appendChild(textNode);
        content.appendChild(node);
      }
    }
  </script>
</body>
</html>
```
