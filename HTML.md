# HTML
#### 1. What is `doctype` ?
`doctype`: is an instruction to the browser of the version of html document and how browser should render it
```javascript
<!doctype html>
```
#### 2. What is the use of `data-` attribute ?
`data-`: allow you to embed extra data in the DOM element 
```javascript
<div id="div1" data-list-size="5">
</div>

var div1 = document.getElementById("div1");
var dataListSize = div1.getAttribute("data-list-size");
console.log(dataListSize); // 5
```
#### 3. How to change html text direction ?
Use Bi-Direction Override
```html
<bdo dir="rtl">
This text will go right-to-left
</bdo>
```
#### 4. How to highlight text in html ?
Use mark element
```html
<p>This is <mark>highlight</mark></p>
```
#### 5. How to ensure click the picture and go to a specific link ?
Use `<a></a>` to wrap `<img>`
```html
<a href="https://www.google.com" target="_blank" ><img src="">></a>
```
#### 6. How to ensure website accessibility ?
- Semantic HTML
- ARIA role tag
- `<img alt="this is a img">`
- `<form><label for="test"></label><input name="test" /></form>`

#### 7. How to create a hamburger mean icon ?
Use `div` and set `width`, `height`, `background-color` to simulate each line.
```javascript
<!doctype html>
<html>
  <head>
    <style>
      .line{
        width:30px;
        height:5px;
        background-color:black;
        margin-top:5px;
      }
    </style>
  </head>
  <body>
    <div>
      <div class="line"></div>
      <div class="line"></div>
      <div class="line"></div>
    </div>
  </body>
</html>
```
#### 8. How to create a toggle switch button ?
Use `input` and `span` and `+` selector.
```javascript
<!DOCTYPE html>
<html>
<head>
<style>
.switch {
  position: relative;
  display: inline-flex;
  align-items: center;
  justify-content: space-around;
  width: 60px;
  height: 34px;
}

.switch::before {
  content: "yes";
  z-index: 10;
}

.switch::after {
  content: "no";
  z-index: 10;
}

.switch input {display:none;}

.slider {
  position: absolute;
  cursor: pointer;
  top: 0;
  left: 0;
  right: 0;
  bottom: 0;
  background-color: #ccc;
  -webkit-transition: .4s;
  transition: .4s;
}

.slider::before {
  position: absolute;
  z-index: 100;
  content: "";
  height: 26px;
  width: 26px;
  left: 4px;
  bottom: 4px;
  background-color: white;
  -webkit-transition: .4s;
  transition: .4s;
}

input:checked + .slider {
  background-color: #2196F3;
}

input:checked + .slider::before {
  -webkit-transform: translateX(26px);
  -ms-transform: translateX(26px);
  transform: translateX(26px);
}

/* Rounded sliders */
.slider.round {
  border-radius: 34px;
}

.slider.round::before {
  border-radius: 50%;
}
</style>
</head>
<body>

<label class="switch">
  <input type="checkbox">
  <span class="slider round"></span>
</label>
<label class="switch">
  <input type="checkbox" checked>
  <span class="slider round"></span>
</label>

</body>
</html> 
```