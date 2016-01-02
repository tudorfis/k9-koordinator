var layoutSettingsCtrl = function($scope, api, crud) {
    var s = $scope;
    s.layoutBoardingPetSizes = {
        array: [
            {t: 'Pet size',  c: 'v',  is_p: 1 },
            {t: 'Limit', c: 'limits', is_p: 1},
            {t: 'Full day', c: 'full_day', p: '$', f: ' | number:2', is_p: 1 },
            {t: 'Half day', c: 'half_day', p: '$', f: ' | number:2', is_p: 1 },
            {t: 'From weight', c: 'from_weight', is_p: 1 },
            {t: 'To weight', c: 'to_weight', is_p: 1 },
            {t: 'In use', c: 'status_id', is_p: 0, is_c: 1},
            {t: 'Override', c: 'override', is_c: 1, is_p: 0}
        ],
        tbl:         'boarding_petsizes',
        t:           'boarding_petsizes',
        predicate:   'predicate_ps',
        reverse:     'reverse_ps',
        all_have_predicate: 0,
        show: {},
        tables_arr: crud.tbl_arr.boarding_petsizes
    };
    s.layoutBoardingRunTypes = {
        array: [
            {t: 'Runtype', c: 'v', is_p: 1},
            {t: 'Limit', c: 'limits', is_p: 1},
            {t: 'Full day', c: 'full_day', p: '$', f: ' | number:2', is_p: 1},
            {t: 'Half day', c: 'half_day', p: '$', f: ' | number:2', is_p: 1},
            {t: 'In use', c: 'status_id', is_c: 1, is_p: 0},
            {t: 'Override', c: 'override', is_c: 1, is_p: 0}
        ],
        tbl:        'boarding_runtypes',
        t:          'boarding_runtypes',
        predicate:  'predicate_rt',
        reverse:    'reverse_rt',
        all_have_predicate: 0,
        show: {},
        tables_arr: crud.tbl_arr.boarding_runtypes
    };
    s.saveLs = function() {
        rs.hs('.btn_save_ls', '.al_save_ls');
        var go_query = '';
        a.forEach(rs.layout_sections, function(item){
            go_query += 'update `layout_sections` set `in_use` = "'+(item.in_use ? 1 : 0)+'", `v` = "'+item.v+'" where `id` = "'+item.id+'"; ';
        });
        console.log(go_query);
        api.query('layout_sections', go_query, 'multi_query').then(function(){
            rs.sh('.btn_save_ls', '.al_save_ls');
        });
    };
    s.setLr = function(lr) {
        s.layout_runs_mod = lr;
    };
    s.deleteLr = function(lr) {
        rs.confirmMsg('Are you sure you want to delete this ?', function(){
            crud.deleteItem(crud.tbl_arr.layout_runs, 'layout_runs', lr.id);
        })
    };
};