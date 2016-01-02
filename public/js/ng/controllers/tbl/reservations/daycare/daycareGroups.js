var daycareGroupsCtrl = function($scope, crud) {
    var s = $scope;
    s.daycareGroups = {
        array: [
            {t: 'ID', c: 'id', is_p: 1},
            {t: 'Name', c: 'v', is_p: 1},
            {t: 'Limits', c: 'limits', is_p: 1},
            {t: 'Fullday rate', c: 'full_day', p: '$', f: ' | number:2', is_p: 1},
            {t: 'Halfday rate', c: 'half_day', p: '$', f: ' | number:2', is_p: 1},
            {t: 'In use', c: 'status_id', is_p: 0, is_c: 1},
            {t: 'Override', c: 'override', is_c: 1, is_p: 0}
        ],
        tbl:        'daycare_groups',
        t:          'daycare_groups',
        predicate:  'predicate_dg',
        reverse:    'reverse_dg',
        all_have_predicate: 0,
        show: {},
        tables_arr: crud.tbl_arr.daycare_grous
    };
};