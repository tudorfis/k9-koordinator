var myAccountCtrl = function($scope, crud, api) {
    var s = $scope;
    rs.identity.password = '';
    rs.post.identity = {
        afterSubmit: function() {
            crud.setTableAfterSubmit(crud.tbl_arr.users, rs.identity);
        }
    };
};