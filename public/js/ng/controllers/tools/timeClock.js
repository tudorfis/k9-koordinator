var timeClockCtrl = function ($scope, api, crud, pdf, $filter, $timeout) {
    var s = $scope;
    s.tokensArray = null;
    s.d_dates = {
        target_date: 'date',
    };
    s.timeClock = {
        array: [
            {t: 'Employee', c: 'user_id', is_s: 1, v: 'v', o: "$root.users", is_p: 1, we: 1},
            {t: 'Date', c: 'date', is_p: 1, is_date: 1},
            {t: 'Start time', c: 'start_time', is_p: 1, is_time: 1},
            {t: 'End time', c: 'end_time', is_p: 1, is_time: 1},
            {t: 'Total time', c: 'total_time', is_p: 1, is_time: 1}
        ],
        tbl:        'tokens',
        t:          'tokens',
        predicate:  'predicate_tc',
        reverse:    'reverse_tc',
        all_have_predicate: 0,
        show: {}
    };
    s.makePdf = function(type) {
        var tokens_array = [],
            tokens_tbl = {};
        if (!rs.isEmpty(s.tokensArray)) {
            var header_style = 'tableHeader';
            tokens_array.push([
                {text: 'Employee',   style: header_style},
                {text: 'Date', style: header_style},
                {text: 'Start time', style: header_style},
                {text: 'End time',   style: header_style},
                {text: 'Total time',   style: header_style}
            ]);
            a.forEach(s.tokensArray, function(item){
                tokens_array.push([
                    (rs.users[item.user_id] ? rs.users[item.user_id].v : '-'),
                    (item.date || '-'),
                    (item.start_time || '-'),
                    (item.end_time || '-'),
                    (item.total_time || '-')
                ]);
            });
            tokens_tbl = {
                style: 'tableExample',
                table: {
                    headerRows: 1,
                    widths: ['*', '*', '*', '*', '*'],
                    body: tokens_array
                },
                layout: 'lightHorizontalLines'
            }
        } else {
            tokens_tbl = {
                text: "\t\n\n - no time schedule for this employee on this date -",
                style: 'subTitle2'
            }
        }
        var docDefinition = {
            content: [
                {
                    text: 'Time clock schedule',
                    style: 'topTitle'
                },
                {
                    stack: [
                        {text: ['On dates: ',
                            {
                                text: (s.f_d || '- all dates -'),
                                color: 'gray',
                                bold: false
                            }
                        ], bold: true},
                        {text: ['Employee: ',
                            {
                                text: (s.f_u ? rs.users[s.f_u].v : '- all employees -'),
                                color: 'gray',
                                bold: false
                            }
                        ], bold: true}
                    ]
                },
                {text: '-\n'},
                tokens_tbl
            ],
            styles: pdf.styles
        };
        docDefinition.content.unshift(pdf.contactInfoHeader());
        var report_name = 'report_time_clock_'+ rs.getCDT() +'.pdf';
        pdf.options(type, docDefinition, report_name);
    };

};