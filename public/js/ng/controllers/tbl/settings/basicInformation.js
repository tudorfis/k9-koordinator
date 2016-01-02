var basicInformationCtrl = function($scope, pdf) {
    var s = $scope;
    rs.post.basic_information = {
        afterSubmit: function() {
            pdf.makeImage(rs, 'settings', 'report_image_id', 'report_image', 'path_thumb');
        }
    };
};