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
- <img alt="this is a img">
- <form><label for="test"></label><input name="test" /></form>

