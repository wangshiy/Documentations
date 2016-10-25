# AngularJS 
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
#### 2. How to share data between controllers(parallel) ?
Register a `service` for controllers to share
``` javascript
<!DOCTYPE html>
<html>
  <head>
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.5.6/angular.min.js"></script>
  </head>
  <body ng-app="myApp">
    <div ng-controller="parallelCtrl1 as p1" style="background-color:red;">
      <p>{{p1.name}}</p>
      <input ng-model="p1.ShareSerive.message"/>
    </div>
    <div ng-controller="parallelCtrl2 as p2" style="background-color:green;">
      <p>{{p2.name}}</p>
      <input ng-model="p2.ShareSerive.message"/>
    </div>
    <script type="text/javascript">
      var app = angular.module("myApp",[]);
      app.service("ShareSerive",function(){
        var self = this;
        self.message = "hello";
      });
      app.controller("parallelCtrl1",["ShareSerive", function(ShareSerive){
        var self = this;
        self.name = "parallelCtrl1";
        self.ShareSerive = ShareSerive;
      }]);
      app.controller("parallelCtrl2",["ShareSerive", function(ShareSerive){
        var self = this;
        self.name = "parallelCtrl2";
        self.ShareSerive = ShareSerive;
      }]);
    </script>
  </body>
</html>
```
