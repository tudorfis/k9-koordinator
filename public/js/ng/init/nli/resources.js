
    /** services **/
    mainApp.service('api',      apiService);
    mainApp.service('models',   modelsService);

    /** filters **/
    mainApp.filter('l', commonFilters.Bootstrap.L);

    /** run **/
    mainApp.run(convertsRun);
    mainApp.run(scrollUpRun);
    mainApp.run(loadingMaskRun);
    mainApp.run(foundationRun);

    /** directives **/
    mainApp.directive('menuLink',   commonDirectives.Bootstrap.MenuLink);

    /** controllers **/
    mainApp.controller('MainCtrl', mainCtrl);

    /** constant **/
    mainApp.constant('config', configConstant);