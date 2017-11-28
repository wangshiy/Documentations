# RxJS
#### 1. combineLastest vs forkJoin(https://www.learnrxjs.io/operators/combination/combinelatest.html) ?
- subscribe to combineLatest will give update when each of the observable emit value
- subscribe to forkJoin will give update when all observables resolve
- e.g. Below example, you will get update from combineLatest every interval, but only get update from forkJoin when you click stop
```javascript
<!DOCTYPE html>
<html>
  <head>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/rxjs/4.0.7/rx.all.js"></script>
  </head>
  <body>

    <button onclick="stopEmit()">stop</button>

    <script>
      const t1 = performance.now();
      let t2;
      let alive = true;
      const Obs1 = Rx.Observable
        .timer(3000, 9000) // delay 2s then every 5s emit
        .timeInterval() // this is optional, in this case e will have interval property
        //.take(2)
        .takeWhile(() => {
          return alive;
        })
        .map((e) => {
          return `Slow:${JSON.stringify(e)}`;
      });

      const Obs2 = Rx.Observable
        .timer(2000, 6000)
        .timeInterval()
        //.take(2)
        .takeWhile(() => {
          return alive;
        })
        .map((e) => {
          return `Medium:${JSON.stringify(e)}`;
      });

      const Obs3 = Rx.Observable
        .timer(1000, 3000)
        .timeInterval()
        //.take(1)
        .takeWhile(() => {
          return alive;
        })
        .map((e) => {
          return `Fast:${JSON.stringify(e)}`;
      });

      const combineObs = Rx.Observable
        .combineLatest(Obs1,Obs2,Obs3, (s1,s2,s3) => {
          return `${s1},${s2},${s3}`;
      });

      const forkJoinObs = Rx.Observable
        .forkJoin(Obs1,Obs2,Obs3, (s1,s2,s3) => {
          return `${s1},${s2},${s3}`;
      });

      const combineSub = combineObs.subscribe((e) => {
        console.log('combineSub:', e);
      });

      const forkJoinSub = forkJoinObs.subscribe((e) => {
        console.log('forkJoinSub:', e);
        t2 = performance.now();
        console.log('time difference(ms):', t2 - t1);// based on take 2 case, max(3000+9000,2000+6000,1000) => 12000ms
      });

      function stopEmit() {
        alive = false;
      }
    </script>
  </body>
</html>
```