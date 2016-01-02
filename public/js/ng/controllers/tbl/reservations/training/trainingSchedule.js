var trainingScheduleCtrl = function ($scope, crud) {
    var s = $scope;
    rs.post.ts = {
        afterSubmit: function() {
            crud.setTableAfterSubmit(crud.tbl_arr.training_schedule, s.ts);
            s.ts = {};
        }
    };
    s.trainingSchedule = {
        array: [
            {t: 'Class name', c: 'tg_id', is_s: 1, v: 'v', o: "$root.training_groups", is_p: 1},
            {t: 'Date start', c: 'date_in', is_p: 1, is_date: 1},
            {t: 'Time in', c: 'time_in', is_p: 1, is_time: 1},
            {t: 'Date end', c: 'date_out', is_p: 1, is_date: 1},
            {t: 'Time out', c: 'time_out', is_p: 1, is_time: 1},
            {t: 'Duration/Time', c: 'time_duration', is_p: 1, is_time: 1},
            {t: 'Limit', c: 'tg_id', is_t: 1, v: 'limit', o: "$root.training_groups", is_p: 1},
            {t: 'Rate', c: 'tg_id', is_t: 1, v: 'price', o: "$root.training_groups", is_p: 1, p: '$', f: ' | number:2',},
            {t: 'Trainer', c: 't_id', is_s: 1, v: 'v', o: "$root.trainers", is_p: 1}
        ],
        tbl:        'training_schedule',
        t:          'training_schedule',
        predicate:  'predicate_ts',
        reverse:    'reverse_ts',
        all_have_predicate: 0,
        show: {},
        tables_arr: crud.tbl_arr.training_schedule
    };
};