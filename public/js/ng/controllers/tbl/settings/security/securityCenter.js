var securityCenterCtrl = function($scope, api, crud) {
    var s = $scope;
    s.saveCenter = function() {
        if (!s.user_id || !s.role_id) {
            rs.alertMsg('Please select employee and level of access');
        } else {
            rs.hs('.btn_save_center', '.al_save_center');
            var user_data = rs.users[s.user_id];
            user_data.role_id = s.role_id;
            api.post('users', user_data.id, user_data).then(function(r){
                crud.setTableAfterSubmit(crud.tbl_arr.users, user_data);
                rs.sh('.btn_save_center', '.al_save_center');
            });
        }
    }
};