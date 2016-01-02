var groomingRatesCtrl = function ($scope, api, crud) {
    var s = $scope;
    s.groomingRates = {
        array: [
            {t: 'Grooming type', c: 'v', is_p: 1},
            {t: 'Multiplier', c: 'multiplier', is_p: 1},
            {t: 'Change price', c: 'change_price', is_c: 1, is_p: 1}
        ],
        tbl:        'grooming_rates',
        t:          'grooming_rates',
        predicate:  'predicate_gr',
        reverse:    'reverse_gr',
        all_have_predicate: 0,
        show: {},
        tables_arr: crud.tbl_arr.grooming_rates
    };
    s.saveHr = function() {
        rs.hs('.btn_save_hr', '.al_save_hr');
        var hr_query = '';
        a.forEach([9,10,11], function(id){
            var item = rs.grooming_options[id];
            hr_query += 'update `grooming_options` set `v` = "'+item.v+'" where `id` = "'+item.id+'"; ';
        });
        api.query('grooming_options', hr_query, 'multi_query').then(function(){
            rs.sh('.btn_save_hr', '.al_save_hr');
        });
    };
};