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