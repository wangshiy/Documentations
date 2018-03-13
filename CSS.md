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
#### 3. How to make element inside div scrollable ?
Specify div's height and width and then set `overflow-x` or `overflow-y` to `scroll`
```javascript
<!DOCTYPE html>
<html>
  <head>
  </head>
  <body>
	<div style="height:100px;width:25px;overflow-y:scroll;overflow-x:scroll">
      <p>hello world</p>
	  <p>hello world</p>
	  <p>hello world</p>
	  <p>hello world</p>
	  <p>hello world</p>
	  <p>hello world</p>
	  <p>hello world</p>
	  <p>hello world</p>
	  <p>hello world</p>
	  <p>hello world</p>
	</div>
  </body>
</html>
```
#### 4. What is CSS specificity and how is it calculated ?
Specificity determines, which CSS rule is applied by the browsers.
It is calculated based on the sum of each matching selector's weight (id > class > tag)
#### 5. What is CSS child selector, general siblings selector and adjacent sibling selector ?
`>`: return all direct children of the element

`~`: return all following siblings of the element

`+`: return the immediate following sibling of the element
```javascript
<!DOCTYPE html>
<html>
<head>
  <style>
    .hover-content{
      display:none;
    }
    #hover-trigger1:hover + .hover-content{
      display:block;
    }
    #hover-trigger2:hover ~ .hover-content{
      display:block;
    }
    #hover-trigger3:hover > .hover-content{
      display:block;
    }
  </style>
</head>
<body>
  <h2 id="hover-trigger1">Hover Title 1</h2>
  <div class="hover-content">
    <p>This is the hover content 1</p>
  </div>
  <div class="hover-content">
    <p>This is the hover content 1</p>
  </div>
  <h2 id="hover-trigger2">Hover Title 2</h2>
  <div class="hover-content">
    <p>This is the hover content 2</p>
  </div>
  <div class="hover-content">
    <p>This is the hover content 2</p>
  </div>
  <div id="hover-trigger3">Hover Title 3
    <div class="hover-content">
      <p>This is the hover content 3</p>
    </div>
    <div class="hover-content">
      <p>This is the hover content 3</p>
    </div>
    <div>
      <p class="hover-content">This is the hover content 3</p>
    </div>
  </div>
</body>
</html>
```
#### 6. What are pros and cons between CSS animation and JS animation ?
In general, CSS is used for small and static animation, JS is used for complex animation
- CSS can use GPU acceleration, so it is faster
- But CSS is can not do very complex and logical animation as JS
- Also CSS will encoutner browser compatibliltiy issues so may need vendor-prefix
#### 7. Differences between responsive design and adaptive design ?
`Responsive design`: be responsive for any given screen width
`Adaptive design`: be responsive for specific screen width
#### 8. Differences between repaint and reflow ?
reflow is more expensive that repaint
`repaint`: changes made on elem skin but not the dom layout e.g. visibility, background-color
`reflow`: changes affected the page layout e.g. resizing page, manipulate dom
#### 9. What is display flex ?
flexbox is a new layout mode in css3 and to make elems layout predictably with responsive design
#### 9.1. How to make a div prefect center inside a div ?
outside div `display:flex;`, inside div `margin:auto;`
```javascript
<!doctype html>
<html>
  <head>
    <style>
      .flex-container{
        width:300px;
        height:300px;
        background-color:black;
        display:flex;
      }

      .flex-item{
        width:100px;
        height:100px;
        background-color:white;
        margin:auto;
      }
    </style>
  </head>
  <body>
    <div class="flex-container">
      <div class="flex-item">
      </div>
    </div>
  </body>
</html>
```

#### 7. What are properties are animatable ?
In general, most numeric css properties are animatable.
- https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_animated_properties

#### 8. What are differences are `display: inline` and `display: inline-block` ?
- `display: inline`: can not set `height`, `width`, `margin-top`, `margin-bottom`, `padding-top`, `padding-bottom`
- `display: inline-block`: can set `height`, `width`, `margin` `padding`, but there are spaces between each block
- Method to clear spacing between inline-block is to set parent `word-spacing: -4px;` for Chrome and etc.
```html
  <div style="width: 100%; height: 100px; background-color: yellow;word-spacing: -4px;">
    <span style="display: inline-block; width: 100px; height: 30px;background-color: red;padding: 10px;">jjj</span>
    <span style="display: inline-block; width: 100px; height: 30px;background-color: red;padding: 10px;">jjj</span>
    <span style="display: inline-block; width: 100px; height: 30px;background-color: red;padding: 10px;">jjj</span>
    <span style="display: inline-block; width: 100px; height: 30px;background-color: red;padding: 10px;">jjj</span>
  </div>
```
