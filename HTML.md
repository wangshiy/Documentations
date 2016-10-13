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
<!--
<bdo dir="rtl">
This text will go right-to-left
</bdo>
-->
```
