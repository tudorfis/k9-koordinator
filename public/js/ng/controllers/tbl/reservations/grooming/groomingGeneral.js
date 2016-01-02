var groomingGeneralCtrl = function($scope, api, crud){
    var s = $scope;
    s.saveGo = function() {
        rs.hs('.btn_save_go', '.al_save_go');
        var go_query = '';
        a.forEach(rs.grooming_options, function(item){
            go_query += 'update `grooming_options` set `v` = "'+item.v+'" where `id` = "'+item.id+'"; ';
        });
        api.query('grooming_options', go_query, 'multi_query').then(function(){
            rs.sh('.btn_save_go', '.al_save_go');
        });
    };
    s.saveGp = function() {
        rs.hs('.btn_save_gp', '.al_save_gp');
        var data = {
            groomer_id: s.groomer_id,
            pet_breed_id: s.pet_breed_id,
            priority: s.priority
        };
        api.post('grooming_priority', '', data).then(function(r){
            data.id = r.data.id;
            if (data.id) {
                crud.setTableAfterSubmit(crud.tbl_arr.grooming_priority, data);
            }
            rs.sh('.btn_save_gp', '.al_save_gp');
        });
    };
    s.deleteGp = function(gp) {
        crud.deleteItem(crud.tbl_arr.grooming_priority, 'grooming_priority', gp.id);
    };
    s.saveBt = function(nr, id) {
        rs.hs('.btn_save_bt'+nr, '.al_save_bt'+nr);
        var data = {
            v: rs.grooming_options[id].v
        };
        api.post('grooming_options', id, data).then(function(r){
            rs.sh('.btn_save_bt'+nr, '.al_save_bt'+nr);
        });
    };
};