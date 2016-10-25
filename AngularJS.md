# JavaScript
#### 1. How child controllers access parent controllers scope ? 
Use `$scope.$parent` or `ng-controller="parentCtrl as p"`
``` JavaScript
<!DOCTYPE html>
<html>
  <head>
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.5.6/angular.min.js"></script>
  </head>
  <body ng-app="myApp">
    <div ng-controller="parentCtrl as p" style="background:red;">
      <p>{{p.name}}</p>
      <div ng-controller="childCtrl1 as c1" style="background:yellow;margin-left:50px;">
        <p>{{p.name}}</p>
        <p>{{c1.name}}</p>
        <div ng-controller="childCtrl2 as c2" style="background:green;margin-left:50px;">
          <p>{{p.name}}</p>
          <p>{{c1.name}}</p>
          <p>{{c2.name}}</p>
        </div>
      </div>
    </div>

    <script type="text/javascript">
      var app = angular.module("myApp",[]);
      app.controller("parentCtrl",["$scope",function($scope){
        var self = this;
        self.name = "parent";
      }]);
      app.controller("childCtrl1",["$scope",function($scope){
        var self = this;
        self.name = "child1";
        console.log("parent scope from child1: ",$scope.$parent);
      }]);
      app.controller("childCtrl2",["$scope",function($scope){
        var self = this;
        self.name = "child2";
        console.log("child1 scope from child2: ",$scope.$parent);
        console.log("parent scope from child2: ",$scope.$parent.$parent);
      }]);
    </script>
  </body>
</html>
```
