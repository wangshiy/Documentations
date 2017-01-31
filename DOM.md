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
      <p data-impl="1"></p>
      <div>
        <span data-impl=""></spam>
      </div>
      <div data-impl="3">
        <span></span>
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
