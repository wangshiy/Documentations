# CSS
#### 1. How to hide/show a child picture on hovering on its parent?
Keypoint is `.child{visibility:hidden}` and `.parent:hover .child{visibility: initial}`
```javascript
<html>
  <head>
    <style>
      .parent{
        background-color: blue;
        width: 400px;
        height:400px;
      }
      
      .parent:hover .child{
        visibility: initial;
      }
      
      .child{
        visibility: hidden;
        background-color: red;
        width: 200px;
        height: 200px;
      }
    </style>
  </head>
  
  <body>
    <div class="parent">
      <div class="child">
      </div>
    </div>
  </body>
</html>
```
#### 2. How would you ensure the child is positioned in the top right of the parent picture?
When child's position is based on parent, keypoint is child should be `position:absolute` and parent should be `position: absolute/relative`
```javascript
<html>
  <head>
    <style>
      .parent{
        background-color: blue;
        width: 400px;
        height:400px;
        position:relative;
      }  
      
      .child{
        background-color: red;
        width: 200px;
        height: 200px;
        position:absolute;
        top:0px;
        right:0px;
      }
    </style>
  </head>
  
  <body>
    <div class="parent">
      <div class="child">
      </div>
    </div>
  </body>
</html>
```