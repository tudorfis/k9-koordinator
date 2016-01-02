var boardingSettings = function($scope, crud) {
    var s = $scope;
    s.boardingPetSizes = {
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
    s.boardingRunTypes = {
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
};