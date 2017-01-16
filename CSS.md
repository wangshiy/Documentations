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