var generalSettingsCtrl = function($scope, settings) {
    var s = $scope;
    rs.post.general_settings = {
        afterSubmit: function(){
            rs.parseStyle('settings', '#fromStyle', '#toStyle');
            settings.buildSiteLogo();
        }
    };
};