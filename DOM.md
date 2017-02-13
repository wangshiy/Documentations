# DOM 
#### 1. Differences between `window` and `document` ? 
`window`: is a global object and everything runs under it e.g document, console, localStorage, location etc.
`document`: is a property of window and represents DOM
#### 2. Differences between `window.onload` and `document.onload` ?
`window.onload`: fires when DOM is ready and all other contents images, css and scripts finish loaded
`document.onload`: fires when DOM is ready 
#### 3. Implement `getElementsByAttribute` ?
`elem.hasAttribute(attr)` and `elem.getAttribute(attr)`
``` JavaScript
<!DOCTYPE html>
<html>
  <head>
  </head>
  <body>
    <p data-impl="1">j</p>
    <div>
      <span data-impl="">k</span>
    </div>
    <div data-impl="3">
      <span>l</span>
    </div>

    <script>
    Document.prototype.getElementsByAttribute = function(attr,value){
      var elems = document.getElementsByTagName("*");
      var elem;
      //console.log(elems);
      var result = [];
      for(var i = 0; i < elems.length; i++){
        elem = elems[i];
        //console.log("elem",elem);
        //console.log("attr",elem.getAttribute(attr));
        if(value === undefined){
          if(elem && elem.hasAttribute(attr)){
            result.push(elem);
          }
        }else{
          if(elem && elem.hasAttribute(attr) && elem.getAttribute(attr) === value){
            result.push(elem);
          }     
        }
      }
      return result;
    };

    console.log(document.getElementsByAttribute("data-impl").length);// 3
    console.log(document.getElementsByAttribute("data-impl","1").length);// 1
    </script>
  </body>
</html>
```
#### 4. Add/remove a class from the element ?
`elem.classList.add();`
`elem.classList.remove();`
``` JavaScript
<!DOCTYPE html>
<html>
<head>
  <style>
    .one{
      background-color: red;
    }
    .two{
      background-color: blue;
    }
    .three{
      background-color: yellow;
    }
  </style>
</head>
<body>
  <p class="one">1</p>
  <div>
    <span id="target2" class="two">2</span>
  </div>
  <div id="target1" class="">
    <span>3</span>
  </div>
  
  <script>
    function addClass(query, className){
      var elem = document.querySelector(query);
      elem.classList.add(className);
    }

    function removeClass(query, className){
      var elem = document.querySelector(query);
      elem.classList.remove(className);
    }

    addClass("#target1","three");
    removeClass("#target2", "two");
    addClass("#target2", "one");    
  </script>
</body>
</html>
```
#### 5. Implement a stop watch ?
When you pause remember to store the current show time for the next start to accumulate
``` JavaScript
<!DOCTYPE html>
<html>
  <head>
  </head>
  <body>
    <button id="reset">Reset</button> 
    <button id="start-pause">Start/Pause</button> 
    <div id="displayed-time">0.000 </div>
    
    <script>
      var disDiv = document.getElementById("displayed-time");
      var startStopBtn = document.getElementById("start-pause");
      var resetBtn = document.getElementById("reset");

      var timer = 0;
      var freezeTimeAccumulate = 0;
      var counter = 0;

      var intervalId;

      function startStopHandler(){
        var loadingTime = new Date().getTime();
        counter++;
        if(counter % 2 !== 0){
          //start
          intervalId = setInterval(function(){
            timer = new Date().getTime() - loadingTime;
            renderHelper(timer,freezeTimeAccumulate);
          },1);
        }else{
          //pause
          freezeTimeAccumulate = parseFloat(disDiv.innerHTML)*1000;
          clearInterval(intervalId);
        }
      }

      function renderHelper(curTime, accumTime){
        disDiv.innerHTML = parseFloat((curTime + accumTime)/1000).toFixed(3);
      }

      function resetHandler(){
        timer = 0;
        freezeTimeAccumulate = 0;
        counter = 0;
        disDiv.innerHTML = parseFloat(0/1000).toFixed(3);
        if(intervalId !== undefined){
          clearInterval(intervalId);
        }
      }

      startStopBtn.addEventListener("click", startStopHandler, false);
      resetBtn.addEventListener("click", resetHandler, false);
    </script>
  </body>
</html>
```
#### 6. Implement a responsive nav bar ?
1. When talk to reponsive the need one html wear two sets of css
`@media screen and (max-width: 480px){}`
2. Bind `.classList.toggle()` to the top right hamburger icon
``` JavaScript
<!DOCTYPE html>
<html>
<head>
  <style type="text/css">
    .topNav li{
      display: inline-block;
    }
    #icon{
      display: none;
    }

    @media screen and (max-width: 480px){
      .topNav li{
        display: none;
      }
      .topNav.expand li{
        display: block;
      }
      #icon{
        display: inline-block;
        float: right;
        position: absolute;
        right: 10px;
        top: 10px;
      }
    }
    
  </style>
</head>
<body>
  <div>
    <ul class="topNav">
      <li>Menu1</li>
      <li>Menu2</li>
      <li>Menu3</li>
      <li>Menu4</li>
      <li>Menu5</li>
      <li>Menu6</li>
      <li>Menu7</li>
      <li>Menu8</li>
      <li>Menu9</li>
      <li>Menu10</li>
      <li id="icon" onclick="toggle()">☰</li>
    </ul>
  </div>
  <script type="text/javascript">
    var topNav = document.getElementsByClassName("topNav")[0];
    function toggle(){
      topNav.classList.toggle("expand");
    }
  </script>
</body>
</html>
```
#### 7. Make a slideshow ?
- Design html and css 
```javascript
<div>
  <div class="item-container"></div>
  ...

  <a><</a>
  <a>></a>

  <div class="dot-container">
    <span></span>
    ...
  <div>
<div>
```
- write `showSlide(n)` to hide all slides first then light up the curIndex slide and its corresponding dot
```javascript
<!doctype html>
<html>
  <head>
    <style>
      .slides-container{
        position: relative;
        border:2px solid black;
        display: flex;
        width: 100%;
      }
      .slide-item{
        position: relative; /* make sure inner elem can adjust its position*/
        border:2px solid red;
        width:100%;
        height:600px;
        margin: auto;
        animation: fade 1s ease; /* animation */
      }
      @keyframes fade{
        from {opacity: 0;}
        to {opacity: 1;}
      }
      .slide-num{
        position: absolute; /* make sure inner elem can adjust its position*/
        z-index: 1; /* make sure to display on top */
        width: 100%; /* these 2 lines below are to make sure center the absolute position elem */
        text-align: center;
      }
      .slide-img{
        position: absolute; 
        z-index: -1;
        width:100%; /*make sure img fit in div*/
        max-height: 600px; /*make sure img will not exceed */
      }
      .slide-caption{
        position: absolute;
        z-index: 1; /* make sure to display on top */
        bottom:20px;
        width: 100%; /* these 2 lines below are to make sure center the absolute position elem */
        text-align: center;
      }
      #prev{
        position:absolute;
        top: 50%;
        left:0;
        cursor: pointer;
      }
      #next{
        position:absolute;
        top: 50%;
        right:0;
        cursor: pointer;
      }
      .dot-container{
        position: absolute;
        bottom: 0;
        width: 100%;
        text-align: center;
        z-index: 2;
      }
      .dot-container span{
        width: 10px;
        height: 10px;
        display:inline-block; /* make sure empty span can display*/
        border-radius: 50%;
        background-color: black;
        cursor: pointer;
      }
      .dot-container span.active{
        background-color: #ddd;
      }
    </style>
  </head>
  <body>
    <div class="slides-container">
      <div class="slide-item">
        <div class="slide-num">1/3</div>
        <img class="slide-img" src="https://encrypted-tbn2.gstatic.com/images?q=tbn:ANd9GcQHHobhE4IvQbGuIV80hNFIRsC4NfDzQwaK25Og7-ThY7LNdpLwtg"/>
        <div class="slide-caption">Caption1</div>
      </div>
      <div class="slide-item">
        <div class="slide-num">2/3</div>
        <img class="slide-img" src="https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcTpn68w5uU2VpQVfyYZSH6rmpVgy08acI7_5gJOTLplNv3pWnFN"/>
        <div class="slide-caption">Caption2</div>
      </div>
      <div class="slide-item">
        <div class="slide-num">3/3</div>
        <img class="slide-img" src="https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcTz4fpsH_eEuXkenjNs37XXQSrAvGcrueiG8-rylBzCbKQ6pt8V"/>
        <div class="slide-caption">Caption3</div>
      </div>

      <a id="prev" onclick="minusIndex()">&#10094;</a>
      <a id="next" onclick="plusIndex()">&#10095;</a>

      <div class="dot-container">
        <span onclick="showSlide(0)"></span>
        <span onclick="showSlide(1)"></span>
        <span onclick="showSlide(2)"></span>
      </div>
    </div>

    <script type="text/javascript">
      var curIndex = 0;
      var endIndex = 2;
      var slideItems = document.getElementsByClassName("slide-item");
      var dots = document.querySelectorAll(".dot-container span");
      showSlide(curIndex);

      function plusIndex(){
        curIndex++;
        if(curIndex > 2){
          curIndex = 0;
        }else if(curIndex < 0){
          curIndex = endIndex;
        }

        showSlide(curIndex);
      }

      function minusIndex(){
        curIndex--;
        if(curIndex > 2){
          curIndex = 0;
        }else if(curIndex < 0){
          curIndex = endIndex;
        }

        showSlide(curIndex);
      }

      function showSlide(n){
        for(var i = 0; i < slideItems.length; i++){
          slideItems[i].style.display = "none";
        }

        for(var j = 0; j < dots.length; j++){
          dots[j].classList.remove("active");
        }

        slideItems[n].style.display = "block";
        dots[n].classList.add("active");
      }
    </script>
  </body>
</html>
```
#### 8. How to make a countdown timer ?
divide and modulus the distance
```javascript
<!doctype html>
<html>
  <head>
  </head>
  <body>
    <p id="timer"></p>
    <script type="text/javascript">
      var timer = document.getElementById("timer");
      var target = new Date(2017,1,12,17,30,24).getTime();

      setInterval(timerHelper,1000);

      function timerHelper(){
        var now = new Date().getTime();
        var distance = target - now;

        var day = Math.floor(distance / (1000*60*60*24));
        var hour = Math.floor((distance % (1000*60*60*24)) / (1000*60*60));
        var min = Math.floor((distance % (1000*60*60)) / (1000*60));
        var sec = Math.floor((distance % (1000*60)) / (1000));

        var timeStr = day + "days" + hour + "hours" + min + "minutes" + sec + "seconds";

        timer.innerHTML = timeStr;
      }
    </script>
  </body>
</html>
```
#### 9. How to make a modal ?
modal have a grey background div and wrapper a modal content inside
```javascript
<!DOCTYPE html>
<html>
  <head>
    <style type="text/css">
      .modal{
        width: 100%;
        height: 100%;
        background-color: rgba(0,0,0,0.4);
        z-index: 1;
        position: fixed;
        left: 0;
        top: 0;
        display: none;
      }
      .modal-content{
        width: 80%;
        background-color: white;
        box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2),0 6px 20px 0 rgba(0,0,0,0.2);
        margin: auto;
      }
      #closeBtn{
        float: right;
        font-size: 28px;
        font-weight: bold;
        cursor: pointer;
      }
      .modal-header, .modal-footer{
        background-color: #5cb85c;
        padding: 2px 16px; /* make sure background-color can fill div */
      }
    </style>
  </head>
  <body>
    <button onclick="openModal()">open</button>

    <div class="modal">
      <div class="modal-content">
        <div class="modal-header">
          <span id="closeBtn" onclick="closeModal()">&times;</span>
          <h2>This is a header</h2>
        </div>
        <div class="modal-context">
          <p>This is the text</p>
        </div>
        <div class="modal-footer">
          <h2>This is a footer</h2>
        </div>
      </div>
    </div>

    <script type="text/javascript">
      var modal = document.getElementsByClassName("modal")[0];

      function openModal(){
        modal.style.display = "flex";
        event.stopPropagation(); // Here needs to cancel bubbling to let window click listener work
      }

      function closeModal(){
        modal.style.display = "none";
        event.stopPropagation();
      }

      window.onclick = closeModal;
    </script>
  </body>
</html>
```
#### 10. How to make, insertBefore, insertAfter, swap and remove DOM element ?
`parentNode.appendChild()`,`parentNode.insertBefore(newNode, nodeRef)`, `childNode.remove()`
```javascript
<!DOCTYPE html>
<html>
<head>
</head>
<body>
  <ul class="ul-container">
    <li>a</li>
    <li>c</li>
    <li>d</li>
    <li>remove me</li>
    <li>e</li>
    <li>h</li>
    <li>g</li>
  </ul>

  <script type="text/javascript">
    var ul = document.getElementsByClassName("ul-container")[0];
    var c = document.querySelectorAll(".ul-container li")[1];
    var e = document.querySelectorAll(".ul-container li")[4];
    var h = document.querySelectorAll(".ul-container li")[5];
    var g = document.querySelectorAll(".ul-container li")[6];
    var removeMe = document.querySelectorAll(".ul-container li")[3];
    var b = document.createElement("li");
    var bText = document.createTextNode("b");
    b.appendChild(bText);
    var f = document.createElement("li");
    var fText = document.createTextNode("f");
    f.appendChild(fText);

    console.log(ul.insertBefore(b,c).nextElementSibling); // insertBefore
    console.log(ul.insertBefore(f,e.nextSibling).previousElementSibling); // insertAfter
    console.log(ul.insertBefore(g,h).previousElementSibling); // swap
    console.log(removeMe.remove()); // remove
  </script>
</body>
</html>
```