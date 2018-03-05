# AngularJS 2
#### 1. Angularjs2 Life Cycle (list by executing order)
- ngOnChanges: when @input binding changes
- ngOnInit: init component 
- ngDoCheck: every change detection trigger, especially used when change detection strategy is onPush for checking immutable object
- ngAfterContentInit: after `ng-content` init
- ngAfterContentChecked: after `ng-content` check
- ngAfterViewInit: after whole view init 
- ngAfterViewChecked: after whole view init 
- ngOnDestroy: before destroy component
