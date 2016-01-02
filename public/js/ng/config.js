
    /** config **/
    mainApp.config(['$httpProvider', function($httpProvider) {
        $httpProvider.defaults.useXDomain = true;
        delete $httpProvider.defaults.headers.common['X-Requested-With'];
    }]);

    /** controller name **/
    mainApp.config(['$provide', function ($provide) {
        $provide.decorator('$controller', [
            '$delegate',
            function ($delegate) {
                return function(constructor, locals) {
                    if (typeof constructor == "string") {
                        locals.$scope.controllerName =  constructor;
                    }
                    return $delegate(constructor, locals);
                }
            }]);
    }]);

    /** factory **/
    mainApp.factory('transformRequestAsFormPost', transformRequestAsFormPost);
    mainApp.factory('httpInterceptor', httpInterceptor).config(function ($httpProvider) {
        $httpProvider.interceptors.push('httpInterceptor');
    });

    mainApp.run(function($http, $rootScope){
        $http.defaults.headers.post["Content-Type"] = "application/x-www-form-urlencoded";
        rs = $rootScope;
        a = angular;
        pF = parseFloat;
        pI = parseInt;
        c = console;
        c.l = c.log;
    });


