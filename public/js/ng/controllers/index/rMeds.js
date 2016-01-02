/**
 *
 * @param $scope
 * @param api
 * @param crud
 * @param $timeout
 */
var rMedsCtrl = function($scope, api, crud, $timeout) {

    var s = $scope;
    rs.r_meds_mod = {};

    rs.doCheckboxesMd = function(scope_id, t, n, type1, type2) {
        var s = (scope_id == 'root' ? rs : $(scope_id).scope()),
            m = $('.'+ type1 +'_morning'),
            a = $('.'+ type1 +'_afternoon'),
            e = $('.'+ type1 +'_evening'),
            check = null;
        s[t][type2+'_morning'] = 0;
        s[t][type2+'_afternoon'] = 0;
        s[t][type2+'_evening'] = 0;
        if (scope_id == 'root') {
           check = !rs[t][n];
        } else {
           check = s[t][n];
        }
        if (check) {
            m.prop('disabled', 1);
            a.prop('disabled', 1);
            e.prop('disabled', 1);
        } else {
            m.prop('disabled', 0);
            a.prop('disabled', 0);
            e.prop('disabled', 0);
        }
    };

    rs.submitMeds = function(r_type, r_id) {
        rs.sh('.al', '.submit');
        rs.r_meds_mod = a.extend(rs.r_meds_mod, {
            client_id: rs.client.id,
            pet_id: rs.pet.id,
            r_type: r_type,
            r_id: r_id,
        });
        api.post('r_meds', '', rs.r_meds_mod).then(function(r){
            rs.pet[r_type][r_id].r_meds = (rs.pet[r_type][r_id].r_meds || {});
            rs.pet[r_type][r_id].r_meds[r.data.id] = r.data;
            rs.r_meds = (rs.r_meds || {});
            crud.setTableAfterSubmit(crud.tbl_arr.r_meds, r.data);
            rs.hs('.al', '.submit');
        });
    };

    rs.post.r_meds_mod = {
        beforeSubmit: function() {
            var s = {},
                r_type = rs.prd_selected,
                r_type_mod = r_type+'_mod';

            if (r_type == 'r_boarding')     s = $('#rBoardingCtrl').scope();
            else if (r_type == 'r_daycare')  s = $('#rDaycareCtrl').scope();
            else if (r_type == 'r_training') s = $('#rTrainingCtrl').scope();
            else if (r_type == 'r_grooms')   s = $('#rGroomsCtrl').scope();

            rs.post.r_meds_mod.break_submit = 0;
            a.forEach(rs.pet[r_type][s[r_type_mod].id].r_meds, function(item){
                if (item.med_id == rs.r_meds_mod.med_id) {
                    rs.alertMsg("This medication is already added, please delete it to modify");
                    rs.post.r_meds_mod.break_submit = 1;
                    return false;
                }
            });
            if (!rs.r_meds_mod.med_everyday) {
                rs.checkDatesExtra(s, r_type_mod, 'date_in', 'date_out', rs.r_meds_mod.med_date, rs.post.r_meds_mod,
                    "Select date according to pets stay, don't add medication on  invalid dates");
            }
            if (!rs.post.r_meds_mod.break_submit) {
                rs.submitMeds(r_type, s[r_type_mod].id);
                rs.post.r_meds_mod.break_submit = 1;
            }
        }
    };

    rs.addRecordsMeds = function(scope_id, r_type, r_type_mod) {
        var s = $(scope_id).scope();
        var addMeds = function(s, r_type, r_type_mod, r_med) {
            rs.added_records_meds = 1;
            $timeout(function(){
                var data = {
                    client_id: rs.client.id,
                    pet_id: rs.pet.id,
                    r_type: r_type,
                    r_id: s[r_type_mod].id,
                    med_id: r_med.md_id,
                    med_instructions: r_med.md_instructions,
                    med_type_id: r_med.md_type_id,
                    med_dosage_id: r_med.md_dosage_id,
                    med_dose_type_id: r_med.md_dose_type_id,
                    med_morning: r_med.md_morning,
                    med_afternoon: r_med.md_afternoon,
                    med_evening: r_med.md_evening,
                    med_as_needed: r_med.md_as_needed,
                    med_date: r_med.md_date,
                    med_everyday: r_med.md_everyday,
                };
                api.post('r_meds', '', data).then(function(r){
                    crud.setTableAfterSubmit(crud.tbl_arr.r_meds, r.data);
                    rs.pet[r_type][s[r_type_mod].id].r_meds[r.data.id] = r.data;
                    rs.sh('.submit', '.al');
                });
            }, 100);
        };
        if (!rs.pet.records_meds || rs.ma(rs.pet.records_meds).length == 0) {
            rs.alertMsg("You do not have any records meds registered");
        } else {
            rs.hs('.submit', '.al');
            a.forEach(rs.pet.records_meds, function(r_med){
                rs.pet[r_type][s[r_type_mod].id].r_meds = (rs.pet[r_type][s[r_type_mod].id].r_meds || {});
                if ((r_type == 'r_boarding' && r_med.md_only_daycare != 1) ||
                        (r_type == 'r_daycare' && r_med.md_only_daycare == 0)) {

                    if (rs.pet[r_type][s[r_type_mod].id].r_meds &&
                            rs.ma(rs.pet[r_type][s[r_type_mod].id].r_meds).length > 0) {

                        var confirm_add = 0,
                            item_add = {};
                        a.forEach(rs.pet[r_type][s[r_type_mod].id].r_meds, function(item){
                            if (item.med_id == r_med.md_id) {
                                confirm_add = 1;
                                item_add = item;
                            }
                        });
                        if (confirm_add) {
                            var message = "Do you want to replace '"+ rs.meds[item_add.med_id].v
                                        +"' with the one from records: '"+  rs.meds[r_med.md_id].v +"' ?";
                            rs.confirmMsg(message, function(){
                                crud.deleteItem(crud.tbl_arr.r_meds, 'r_meds', item_add.id).then(function(r){
                                    delete s[r_type][s[r_type_mod].id].r_meds[item_add.id];
                                    addMeds(s, r_type, r_type_mod, r_med);
                                });
                            });
                        } else {
                            addMeds(s, r_type, r_type_mod, r_med);
                        }
                    } else {
                        addMeds(s, r_type, r_type_mod, r_med);
                    }
                }
            });
            rs.sh('.submit', '.al');
        }
    };

    rs.deleteRecordsMeds = function(scope_id, r_type, r_type_mod) {
        var s = $(scope_id).scope();
        rs.confirmMsg("Are you sure you want to delete all the meds scheduled for this reservation ?", function(){
            if (rs.pet[r_type][s[r_type_mod].id].r_meds &&
                rs.ma(rs.pet[r_type][s[r_type_mod].id].r_meds).length > 0) {
                rs.hs('.submit', '.al');
                a.forEach(rs.pet[r_type][s[r_type_mod].id].r_meds, function (item) {
                    crud.deleteItem(crud.tbl_arr.r_meds, 'r_meds', item.id);
                });
                rs.pet[r_type][s[r_type_mod].id].r_meds = {};
                rs.sh('.submit', '.al');
            } else {
                rs.alertMsg("No meds to delete");
            }
            rs.added_records_meds = 0;
        });
    };

    rs.deleteMeds = function(scope_id, r_type, r_type_mod, id) {
        var s = $(scope_id).scope();
        rs.confirmMsg('Are you sure you want to delete this medication ?', function(){
            crud.deleteItem('r_meds', id).then(function(r){
                delete rs.pet[r_type][s[r_type_mod].id].r_meds[id];
                if (rs.pet[r_type][s[r_type_mod].id].r_meds && rs.ma(rs.pet[r_type][s[r_type_mod].id].r_meds).length == 0) {
                    rs.added_records_meds = 0;
                }
            });
        });
    };

};

var medsTableDirective = function($compile) {
    return {
        restrict: 'E',
        compile: function (el, atts) {
            return function (s, el, atts) {
                var temp =
                    '<table class="small-12">'+
                        '<thead>'+
                            '<tr>'+
                                '<th>Name</th>'+
                                '<th>Morning</th>'+
                                '<th>Afternoon</th>'+
                                '<th>Evening</th>'+
                                '<th>As needed</th>'+
                                '<th>Instructions</th>'+
                                '<th>Med type</th>'+
                                '<th>Dose type</th>'+
                                '<th>Date</th>'+
                                '<th></th>'+
                            '</tr>'+
                        '</thead>'+
                        '<tbody>'+
                            '<tr ng-repeat="r_med in '+ atts.rTypeIn +'">'+
                                '<td>{{$root.meds[r_med.med_id].v}}</td>'+
                                '<td>{{(r_med.med_morning ? \'yes\' : \'no\')}}</td>'+
                                '<td>{{(r_med.med_afternoon ? \'yes\' : \'no\')}}</td>'+
                                '<td>{{(r_med.med_evening ? \'yes\' : \'no\')}}</td>'+
                                '<td>{{(r_med.med_as_needed ? \'as needed\' : \'-\')}}</td>'+
                                '<td>{{r_med.med_instructions || \'-\'}}</td>'+
                                '<td>{{$root.meds_type[r_med.med_type_id].v}}</td>'+
                                '<td>'+
                                    '<div ng-show="r_med.med_dosage_id">'+
                                        '{{$root.md_dosage[r_med.med_dosage_id].v}}'+
                                    '</div>'+
                                    '<div ng-show="r_med.med_dose_type_id">'+
                                        '{{$root.md_dose_type[r_med.med_dose_type_id].v}}'+
                                    '</div>'+
                                '</td>'+
                                '<td>'+
                                    '{{(r_med.med_everyday ? \'daily\' : r_med.med_date)}}</td>'+
                                '<td>'+
                                    '<a class="button tiny radius" ' +
                                      ' ng-hide="$root.partial_show" ' +
                                      ' ng-click="deleteMeds(\''+ atts.scopeId +'\', \''+ atts.rType +'\', \''+ atts.rTypeMod +'\', r_med.id)">'+
                                        '<i class="fi-trash"></i>'+
                                    '</a>'+
                                '</td>'+
                            '</tr>'+
                        '</tbody>'+
                    '</table>';
                el.replaceWith($compile(temp)(s));
            }
        }
    }
};

var addRecordsMedsBtnDirective = function($compile) {
    return {
        restrict: "E",
        compile: function(el, atts) {
            return function(s, el, atts) {
                var temp =
                    '<div class="small-6 column">'+
                        '<a class="button tiny radius submit" '+
                            ' ng-hide="$root.added_records_meds" '+
                            ' ng-click="addRecordsMeds(\''+ atts.scopeId +'\', \''+ atts.rType +'\', \''+ atts.rTypeMod +'\')">'+
                                '<i class="fa fa-plus-square-o"></i> Add meds from records'+
                        '</a>'+
                        '<i class="fa fa-spin fa-spinner fa-2x al" style="display: none;"></i>'+
                    '</div>'+
                    '<div class="small-6 column">'+
                        '<a class="button tiny radius submit" '+
                            ' ng-hide="ma($root.pet.'+ atts.rType +'['+ atts.rTypeMod +'.id].r_meds).length == 0" '+
                            ' ng-click="deleteRecordsMeds(\''+ atts.scopeId +'\', \''+ atts.rType +'\', \''+ atts.rTypeMod +'\')">'+
                                '<i class="fa fa-trash"></i> Delete all meds'+
                        '</a>'+
                        '<i class="fa fa-spin fa-spinner fa-2x al" style="display: none;"></i>'+
                    '</div>';
                el.replaceWith($compile(temp)(s));
            }
        }
    }
};