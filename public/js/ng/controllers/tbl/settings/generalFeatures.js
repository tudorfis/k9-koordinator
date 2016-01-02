var generalFeaturesCtrl = function($scope, api, crud, settings, cp) {
    var s = $scope;
    s.saveGf = function() {
        rs.hs('.btn_save_gf', '.al_save_gf');
        var gf_query = '';
        a.forEach(rs.general_features, function(item){
            gf_query += 'update `general_features` set `v` = "'+item.v+'" where `id` = "'+item.id+'"; ';
        });
        api.query('general_features', gf_query, 'multi_query').then(function(){
            rs.sh('.btn_save_gf', '.al_save_gf');
        });
    };
    s.rebuildDso = function() {
        settings.buildDso();
    };
    s.setClientSearchBy = function() {
        cp.setClientSearchBy();
    };
};