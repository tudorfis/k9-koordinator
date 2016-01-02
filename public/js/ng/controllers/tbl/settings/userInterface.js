var userInterfaceCtrl = function($scope, settings) {
    var s = $scope;
    s.doTelFormats = function() {
        settings.buildFoundationPatterns();
    };
};