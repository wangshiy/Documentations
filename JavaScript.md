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
#### 8. JavaScript pass by value or reference ?
Primitives are passed by value, Objects are passed by reference.
```html`
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
  this.observers = [];

  return {
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
