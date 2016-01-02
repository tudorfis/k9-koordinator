var discountsBoardingCtrl = function ($scope, api, crud) {
    var s = $scope;
    s.saveLtd = function() {
        rs.sh('.al_sltd', '.btn_sltd');
        a.forEach(rs.discounts_boarding_long_term, function(item){
            api.post('discounts_boarding_long_term', item.id, item).then(function(r){
                crud.setTableAfterSubmit(crud.tbl_arr.discounts_boarding_long_term, item);
                rs.hs('.al_sltd', '.btn_sltd');
            });
        });
    };
    s.saveNc = function() {
        rs.sh('.al_snc', '.btn_snc');
        a.forEach(rs.discounts_boarding_new_client, function(item){
            api.post('discounts_boarding_new_client', item.id, item).then(function(r){
                crud.setTableAfterSubmit(crud.tbl_arr.discounts_boarding_new_client, item);
                rs.hs('.al_snc', '.btn_snc');
            });
        });
    };
    s.savePc = function() {
        rs.sh('.al_spc', '.btn_spc');
        a.forEach(rs.discounts_boarding_priority_club, function(item){
            api.post('discounts_boarding_priority_club', item.id, item).then(function(r){
                crud.setTableAfterSubmit(crud.tbl_arr.discounts_boarding_priority_club, item);
                rs.hs('.al_spc', '.btn_spc');
            });
        });
    };
    s.discountsBoardingMultiplePet = {
        array: [
            {t: 'ID', c: 'id', is_p: 1},
            {t: 'Type', c: 'boarding_runtype_id', is_s: 1, v: 'v', o: "$root.boarding_runtypes", is_p: 1},
            {t: 'In %', c: 'is_percentage', is_p: 1, is_c: 1},
            {t: '1 Pet discount', c: '1_pet_discount', is_p: 1},
            {t: '2 Pet discount', c: '2_pet_discount', is_p: 1},
            {t: '3 Pet discount', c: '3_pet_discount', is_p: 1}
        ],
        tbl:        'discounts_boarding_multiple_pet',
        t:          'discounts_boarding_multiple_pet',
        predicate:  'predicate_dbmp',
        reverse:    'reverse_dbmp',
        all_have_predicate: 0,
        show: {},
        tables_arr:
            crud.tbl_arr.discounts_boarding_multiple_pet
    };
};