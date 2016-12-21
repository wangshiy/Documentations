# DOM 
#### 1. Differences between `window` and `document` ? 
`window`: is a global object and everything runs under it e.g document, console, localStorage, location etc.
`document`: is a property of window and represents DOM
#### 2. Differences between `window.onload` and `document.onload` ?
`window.onload`: fires when DOM is ready and all other contents images, css and scripts finish loaded
`document.onload`: fires when DOM is ready 
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
