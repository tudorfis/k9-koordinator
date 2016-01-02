var securityLevelsCtrl = function($scope, api, crud, $timeout, settings){
    var s = $scope;
    s.loading = false;
    s.role_v = '';
    s.r_sl_cp = [];
    s.addRole = function() {
        if (!s.role_v) {
            rs.alertMsg('Please enter a name for the desired level');
        } else {
            s.loading = true;
            var role_mod = {
                n: rs.lowercaseUnderscore(s.role_v),
                v: s.role_v
            };
            api.post('role', '', role_mod).then(function(r){
                role_mod.id = r.data.id;
                crud.setTableAfterSubmit(crud.tbl_arr.role, role_mod);
                s.role_v = '';
                var sl_cp_query = '',
                    v = false;
                a.forEach(rs.security_levels, function(item, sl_id){
                    sl_cp_query += "insert into `sl_cp` set `role_id` = '"+role_mod.id+"', `sl_id` = '"+sl_id+"', `v` = '"+v+"'; ";
                });
                api.query('sl_cp', sl_cp_query, 'multi_query').then(function(){
                    $timeout(function(){
                        api.get('sl_cp', '', '', {filter:{role_id: role_mod.id}}).then(function(r){
                            a.forEach(r.data, function(item){
                                crud.setTableAfterSubmit(crud.tbl_arr.sl_cp, item);
                            });
                            settings.buildSecurityLevels();
                            s.setRoleId(role_mod.id);
                            s.loading = false;
                        });
                    }, 3000);
                });
            });
        }
    };
    s.deleteRole = function(r) {
        rs.confirmMsg('Be carefull, deleting roles causes serious problems on users and ' +
                            ' their management, are you sure you want to continue ?', function(){
            s.loading = true;
            crud.deleteItem(crud.tbl_arr.role, 'role', r.id, false, 'permanent');
            var sl_cp_query = "delete from `sl_cp` where `role_id` = '"+ r.id+"';";
            api.query('sl_cp', sl_cp_query, 'multi_query').then(function(){
                $timeout(function(){
                    a.forEach(rs.sl_cp, function(item){
                        if (item.role_id == r.id) {
                            crud.deleteItem(crud.tbl_arr.sl_cp, 'sl_cp', item.id, true);
                        }
                    });
                    settings.buildSecurityLevels();
                    s.setRoleId(1);
                    s.loading = false;
                }, 3000);
            });
        });
    };
    s.saveLevels = function() {
        rs.hs('.btn_save_levels', '.al_save_levels');
        var sl_cp_query = '';
        a.forEach(rs.sl_cp, function(item, id){
            if (s.role_id == item.role_id) {
                var data = {
                        id: id,
                        role_id: item.role_id,
                        sl_id: item.sl_id,
                        v: item.v
                    };
                crud.setTableAfterSubmit([{tbl: 'sl_cp', t: 'ws', with_id: 1}], data);
                sl_cp_query += "update `sl_cp` set `v` = '"+item.v+"' where `id` = '"+ id +"'; ";
            }
        });
        api.query('sl_cp', sl_cp_query, 'multi_query').then(function(r){
            rs.sh('.btn_save_levels', '.al_save_levels');
        });
    };
    s.cuAll = function(start, end, value) {
        for (i = start; i < end; i++) {
            var sl_cp_id = s.r_sl_cp[i].id;
            rs.sl_cp[sl_cp_id].v = value;
        }
    };
    s.setRoleId = function(role_id) {
        s.role_id = role_id;
        s.r_sl_cp = [];
        a.forEach(rs.sl_cp, function(item, sl_cp_id){
            if(item.role_id == s.role_id) {
                if (item.sl_id && item) {
                    s.r_sl_cp.push({
                        id: sl_cp_id,
                        title: rs.security_levels[item.sl_id].title,
                    });
                }
            }
        });
    };
    s.setRoleId(1);
};
var asterixRgFilter = function($compile) {
    return function(id) {
        var str = '';
        if (['17','34','38'].indexOf(id) !== -1) {
            str = '<span style="color: #ff0000">*</span>';
        } else if (['22','32','33','37','38'].indexOf(id) !== -1) {
            str = '<span style="color: #00aa00">*</span>';
        }
        $('#cb'+id).replaceWith(str);
    }
};
var cuFieldsetDirective = function($compile){
    return {
        restrict: 'E',
        link: function(scope, el, atts) {
            template =
                '<fieldset style="margin-bottom: 30px;">' +
                '<div style="margin-top: -50px;>' +
                    '<div class="left"><h4>'+ atts.title +'</h4></div>' +
                        '<div class="right">' +
                            '<a class="" ' +
                                ' ng-click="cuAll('+atts.start+','+atts.end+', true)">' +
                                '<sub><i class="fa fa-check"></i> Check</sub></a> ' +
                                ' - ' +
                            '<a class="" ' +
                              ' ng-click="cuAll('+atts.start+','+atts.end+', false)"><sub>Uncheck</sub></a>' +
                        '</div>' +
                    '</div>' +
                    '<div ng-repeat="rsl in r_sl_cp | array | slice:'+atts.start+':'+atts.end+'">' +
                        '<input-checkbox ' +
                            ' title="{{rsl.title}}" ' +
                            ' ng-model="sl_cp[\'{{rsl.id}}\'].v"> ' +
                        '</input-checkbox> ' +
                        '<div class="left" style="margin-right: 10px; font-size: 20px;"> ' +
                            ' <div id="cb{{$root.sl_cp[rsl.id].sl_id}}">&nbsp;</div> ' +
                        '</div>' +
                        ' {{$root.sl_cp[rsl.id].sl_id | asterixRg}} ' +
                    '</div>' +
                '</fieldset>';
            el.replaceWith($compile(template)(scope));
        }
    }
};