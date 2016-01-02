var holidayAndSeasonCtrl = function($scope, api, crud){
    var s = $scope;
    asd = s;
    s.holidaySetup = {
        array: [
            {t: 'Holiday name', c: 'v', is_p: 1},
            {t: 'Date', c: 'date', is_p: 1, is_date: 1},
            {t: 'Open', c: 'open', is_p: 1, is_c: 1},
        ],
        tbl:        'holiday',
        t:          'holiday',
        predicate:  'predicate_h',
        reverse:    'reverse_h',
        all_have_predicate: 0,
        show: {},
        tables_arr: crud.tbl_arr.holiday
    };
    s.setSm = function(season_mod) {
        s.season_mod = season_mod;
    };
    s.sdaDates = function() {
        a.forEach(rs.days, function(d){
            s.season_mod['is_'+d] =! s.season_mod['is_'+d];
        })
    };
    s.saveSs = function() {
        if (s.season_mod.id) {
            rs.sh('.al_ss', '.btn_ss');
            api.post('season', s.season_mod.id, s.season_mod).then(function(r){
                crud.setTableAfterSubmit(crud.tbl_arr.season, s.season_mod);
                rs.hs('.al_ss', '.btn_ss');
            });
        } else {
            rs.alertMsg("Please select a season");
        }
    };
    s.saveSsr = function() {
        rs.sh('.al_ssr', '.btn_ssr');
        a.forEach(rs.season, function(item){
            api.post('season', item.id, item).then(function(r){
                crud.setTableAfterSubmit(crud.tbl_arr.season, item);
                rs.hs('.al_ssr', '.btn_ssr');
            });
        });
    };
};