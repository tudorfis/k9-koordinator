var commissionsCtrl = function($scope, api, crud, settings) {
    var s = $scope;
    s.cg_mod = {};
    s.ct_mod = {};
    s.updateC = function(target, table) {
        $('.cBtn').hide();
        $('.cAl').show();
        var data = {
            commissions_new_customers_board:
                rs.boarding_settings.commissions_new_customers_board,
        };
        api.post('boarding_settings', '', data).then(function(r){
            crud.setTableAfterSubmit(crud.tbl_arr.boarding_settings, data);
            $('.cBtn').fadeIn('medium');
            $('.cAl').hide();
        });
    };
    s.changeGT = function(id, target, table) {
        s[target] = rs[table][id];
    };
    s.updateGT = function(id, target, table) {
        var error = false;
        switch (target) {
            case 'cg_mod':
                if (!id) {
                    rs.alertMsg('Select a groomer please');
                    error = true;
                }
                break;
            case 'ct_mod':
                if (!id) {
                    rs.alertMsg('Select a trainer please');
                    error = true;
                }
                break;
        }
        if (!error) {
            switch (target){
                case 'cg_mod':
                    $('.cgBtn').hide();
                    $('.cgAl').show();
                    break;
                case 'ct_mod':
                    $('.ctBtn').hide();
                    $('.ctAl').show();
                    break;
            }
            api.post(table, id, s[target]).then(function(r){
                crud.setTableAfterSubmit(crud.tbl_arr[table], s[target]);
                settings.buildUsersRoles();
                switch (target){
                    case 'cg_mod':
                        $('.cgBtn').fadeIn('medium');
                        $('.cgAl').hide();
                        break;
                    case 'ct_mod':
                        $('.ctBtn').fadeIn('medium');
                        $('.ctAl').hide();
                        break;
                }
            });
        }
    };
    s.updateSR = function(id, data, table, target) {
        $('.'+ target +'Btn'+id).hide();
        $('.'+ target +'Al'+id).show();
        api.post(table, id, data).then(function(r){
            crud.setTableAfterSubmit(crud.tbl_arr[table], data);
            $('.'+ target +'Btn'+id).fadeIn('medium');
            $('.'+ target +'Al'+id).hide();
        });
    };
    s.setAll = function(percentage, table) {
        a.forEach(rs[table], function(item, id){
            rs[table][id].commission_percentage = percentage;
        });
        var go_query = 'update '+ table +' set commission_percentage=\''+ percentage +'\'';
        api.query(table, go_query, 'multi_query');
    };
    s.changeGrooming = function() {
        a.forEach(rs.grooming_commissions, function(item){
            if (item.groomer_id == s.cg_mod.groomer_id) {
                s.cg_mod = item;
                s.$broadcast('cg_mod');
                return false;
            }
        });
    };
    s.saveGrooming = function() {
        if (!s.cg_mod.groomer_id) {
            rs.alertMsg('Please select a groomer first');
        } else {
            rs.hs('.btn_cg', '.al_cg');
            var id = (s.cg_mod.id || '');
            api.post('grooming_commissions', id, s.cg_mod).then(function(r){
                s.cg_mod.id = r.data.id;
                crud.setTableAfterSubmit(crud.tbl_arr.grooming_commissions, s.cg_mod);
                s.$broadcast('cg_mod');
                rs.sh('.btn_cg', '.al_cg');
            });
        }
    }
};