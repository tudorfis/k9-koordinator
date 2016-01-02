var rewardsProgramCtrl = function($scope, crud) {
    var s = $scope;
    rs.post.promotions_mod = {
        afterSubmit: function() {
            crud.setTableAfterSubmit(crud.tbl_arr.promotions, s.promotions_mod);
            s.promotions_mod = {};
        }
    };
    s.editPromotion = function(p) {
        s.promotions_mod = p;
    };
    s.deletePromotion = function(id) {
        rs.confirmMsg("Are you sure you want to delete this promotion", function(){
            crud.deleteItem(crud.tbl_arr.promotions, 'promotions', id);
        });
    }
};