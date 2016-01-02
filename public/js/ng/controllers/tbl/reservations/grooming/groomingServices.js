var groomingServicesCtrl = function ($scope, api, crud) {
    var s = $scope;
    rs.base_type_filter.unshift({n: '- all types -', v: ''});
    s.groomingServices = {
        array: [
            {t: 'Grooming service', c: 'v', is_p: 1},
            {t: 'Type', c: 'base_type_id', is_s: 1, w_e: 1, v: 'n', o: "$root.base_type_array", is_p: 1},
            {t: 'Miniature', c: 'miniature', p: '$', f: ' | number:2', is_p: 1},
            {t: 'Small', c: 'v_1', p: '$', f: ' | number:2', is_p: 1},
            {t: 'Medium', c: 'v_2', p: '$', f: ' | number:2', is_p: 1},
            {t: 'Large', c: 'v_3', p: '$', f: ' | number:2', is_p: 1},
            {t: 'Miniature', c: 'v_4', p: '$', f: ' | number:2', is_p: 1},
            {t: 'Med Lg', c: 'v_5', p: '$', f: ' | number:2', is_p: 1},
            {t: 'Giant', c: 'v_6', p: '$', f: ' | number:2', is_p: 1},
            {t: 'Cat', c: 'v_7', p: '$', f: ' | number:2', is_p: 1},
            {t: 'Other', c: 'v_8', p: '$', f: ' | number:2', is_p: 1},
            {t: 'HCP', c: 'hcp', p: '$', f: ' | number:2', is_p: 1, tt: "Handle carefully price"},
            {t: 'In use', c: 'in_use', is_c: 1, is_p: 1}
        ],
        tbl:        'grooming_services',
        t:          'grooming_services',
        predicate:  'predicate_gs',
        reverse:    'reverse_gs',
        all_have_predicate: 0,
        show: {},
        tables_arr: crud.tbl_arr.grooming_services,
        with_default_filter: {
            n: 'base_type_id',
            v: '1',
            m: 'gs_type'
        }
    };
};