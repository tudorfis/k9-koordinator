var trainingGroupsCtrl = function ($scope, api) {
    var s = $scope;
    s.trainingGroups = {
        array: [
            {t: 'Rank', c: 'rank', is_p: 1},
            {t: 'Name', c: 'v', is_p: 1},
            {t: 'Price', c: 'price', p: '$', f: ' | number:2', is_p: 1},
            {t: 'Limit', c: 'limit', is_p: 1},
            {t: 'Instructions', c: 'instructions', is_p: 0}
        ],
        tbl:        'training_groups',
        t:          'training_groups',
        predicate:  'predicate_tg',
        reverse:    'reverse_tg',
        all_have_predicate: 0,
        show: {},
        tables_arr:
            [{tbl: 'training_groups', t: 'rs', with_id: 1},
                {tbl: 'training_groups', t: 'ws', with_id: 1}]
    };
    s.trainingOptions = {
        array: [
            {t: 'Name', c: 'v', is_p: 0},
            {t: 'Description', c: 'description', is_p: 0},
            {t: 'Price', c: 'price', p: '$', f: ' | number:2', is_p: 0}
        ],
        tbl:        'training_options',
        t:          'training_options',
        predicate:  'predicate_to',
        reverse:    'reverse_to',
        all_have_predicate: 0,
        show: {},
        tables_arr:
            [{tbl: 'training_options', t: 'rs', with_id: 1},
                {tbl: 'training_options', t: 'ws', with_id: 1}]
    };
    s.tg_id = null;
    s.selectTgId = function(el) {
        s.tg_id = el.id;
        s.training_options = {};
        a.forEach(rs.training_options, function(item){
            if (item.tg_id == s.tg_id) {
                s.training_options[item.id] = item;
            }
        });
    }
};