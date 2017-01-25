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
#### 3. How to broadcast notifications to controllers ?
Register a `service` to do `$rootScope.$broadcast("channel1",{})` and then controller to do `$scope.$on("channel1",callback)`
``` javascript
<!doctype>
<html>
  <head>
  	<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.5.6/angular.min.js"></script>
  </head>
  <body ng-app="myApp" ng-controller="myCtrl">
    <script type="text/javascript">
    	var myApp = angular.module("myApp",[]);

    	myApp.service("broadcastService",function($rootScope){
    		console.log("broadcastService init!");

    		var channels = {
    			channel1: {channelId:"", msg:"this is channel1"},
    			channel2: {channelId:"", msg:"this is channel2"}
    		};

    		function boardcastHandler(channel){
    			$rootScope.$broadcast(channel, channels[channel]);
    		}

    		this.start = function(channel){
                var intervalId = setInterval(boardcastHandler.bind(null,channel),1000);
                channels[channel].channelId = intervalId;
    		}

    		this.stop = function(channel){
    			clearInterval(channels[channel].channelId);
    			channels[channel].channelId = "";
    		}
    		
    	});

    	myApp.controller("myCtrl",["$scope","broadcastService",function($scope,broadcastService){
    		console.log("myCtrl init!");
    		function eventHandler(event,res){
    			console.log(event,res);
    		}
    		broadcastService.start("channel1");
    		$scope.$on("channel1", eventHandler);

    		setTimeout(function(){
    			broadcastService.stop("channel1");
    			broadcastService.start("channel2");
    			$scope.$on("channel2", eventHandler);
    		},5000);
    	}]);
    </script>
  </body>
</html>
```
#### 4. Difference between $apply() and $digest() ?
- `$digest()` is called automatically after like `ng-click`, `$apply()` is called manually
- `$digest()` takes no argument, `$apply()` can take a callback function
- `$digest()` impacts on current `$scope` and its children, `$apply()` impacts on `$rootScope.$digest()`
``` javascript
<!DOCTYPE html>
<html>
<head>
  <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.5.6/angular.min.js"></script>
</head>
<body ng-app="myApp" ng-controller="myCtrl">
  <p>{{date.time}}</p>
  <button ng-click="updateTime()">ngClick Button</button>
  <button id="eventListenerBtn">eventListener Button</button>
  
  <script>
    var myApp = angular.module("myApp",[]);
    var myController = myApp.controller("myCtrl",["$scope","$timeout",function($scope,$timeout){
      $scope.updateTime = function(){
        $scope.date = {time: new Date()};
      };
      
      var clickBtn = document.getElementById("eventListenerBtn");
      clickBtn.addEventListener("click",function(){
        $scope.date = {time: new Date()};
        $scope.$digest();//important
      });
      
      setTimeout(function(){
        console.log("update1");
        $scope.date = {time: new Date()};
        $scope.$digest();//important
      },3000);
      
      setTimeout(function(){
        console.log("update2");
        $scope.$apply(function(){
          $scope.date = {time: new Date()};
        });//important
      },6000);
      
      $timeout(function(){
        console.log("update3");
        $scope.date = {time: new Date()};
      },9000);//$timeout will trigger $digest but setTimeout will not
    }]);
  </script>
</body>
</html>
```
