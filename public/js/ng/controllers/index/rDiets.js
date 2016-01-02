/**
 * Diets
 * @param $scope
 * @param api
 * @param crud
 * @param $timeout
 */
var rDietsCtrl = function($scope, api, crud, $timeout) {

    var s = $scope;
    rs.r_diets_mod = {};

    rs.submitDiets = function(r_type, r_id) {
        rs.sh('.al', '.submit');
        rs.r_diets_mod = a.extend(rs.r_diets_mod, {
            client_id: rs.client.id,
            pet_id: rs.pet.id,
            r_type: r_type,
            r_id: r_id,
        });
        api.post('r_diets', '', rs.r_diets_mod).then(function(r){
            rs.pet[r_type][r_id].r_diets = (rs.pet[r_type][r_id].r_diets || {});
            rs.pet[r_type][r_id].r_diets[r.data.id] = r.data;
            rs.r_diets = (rs.r_diets || {});
            crud.setTableAfterSubmit(crud.tbl_arr.r_diets, r.data);
            rs.hs('.al', '.submit');
        });
    };

    rs.post.r_diets_mod = {
        beforeSubmit: function() {
            var s = {},
                r_type = rs.prd_selected,
                r_type_mod = r_type+'_mod';

            if (r_type == 'r_boarding')     s = $('#rBoardingCtrl').scope();
            else if (r_type == 'r_daycare')  s = $('#rDaycareCtrl').scope();
            else if (r_type == 'r_training') s = $('#rTrainingCtrl').scope();
            else if (r_type == 'r_grooms')   s = $('#rGroomsCtrl').scope();

            rs.post.r_diets_mod.break_submit = 0;
            a.forEach(rs.pet[r_type][s[r_type_mod].id].r_diets, function(item){
                if (item.diet_id == rs.r_diets_mod.diet_id) {
                    rs.alertMsg("This diet is already added, please delete it to modify");
                    rs.post.r_diets_mod.break_submit = 1;
                    return false;
                }
            });
            if (!rs.r_diets_mod.med_everyday) {
                rs.checkDatesExtra(s, r_type_mod, 'date_in', 'date_out', rs.r_diets_mod.diet_date, rs.post.r_diets_mod,
                    "Select date according to pets stay, don't add diets on  invalid dates");
            }
            if (!rs.post.r_diets_mod.break_submit) {
                rs.submitDiets(r_type, s[r_type_mod].id);
                rs.post.r_diets_mod.break_submit = 1;
            }
        }
    };

    rs.addRecordsDiets = function(scope_id, r_type, r_type_mod) {
        var s = $(scope_id).scope();
        var addDiets = function(s, r_type, r_type_mod, r_diet) {
            rs.added_records_diets = 1;
            $timeout(function(){
                var data = {
                    client_id: rs.client.id,
                    pet_id: rs.pet.id,
                    r_type: r_type,
                    r_id: s[r_type_mod].id,
                    diet_id: r_diet.md_id,
                    diet_instructions: r_diet.md_instructions,
                    diet_type_id: r_diet.md_type_id,
                    diet_dosage_id: r_diet.md_dosage_id,
                    diet_dose_type_id: r_diet.md_dose_type_id,
                    diet_morning: r_diet.md_morning,
                    diet_afternoon: r_diet.md_afternoon,
                    diet_evening: r_diet.md_evening,
                    diet_as_needed: r_diet.md_as_needed,
                    diet_date: r_diet.md_date,
                    diet_everyday: r_diet.md_everyday,
                };
                api.post('r_diets', '', data).then(function(r){
                    crud.setTableAfterSubmit(crud.tbl_arr.r_diets, r.data);
                    rs.pet[r_type][s[r_type_mod].id].r_diets[r.data.id] = r.data;
                    rs.sh('.submit', '.al');
                });
            }, 100);
        };
        if (!rs.pet.records_diets || rs.ma(rs.pet.records_diets).length == 0) {
            rs.alertMsg("You do not have any diet records registered");
        } else {
            rs.hs('.submit', '.al');
            a.forEach(rs.pet.records_diets, function(r_diet){
                rs.pet[r_type][s[r_type_mod].id].r_diets = (rs.pet[r_type][s[r_type_mod].id].r_diets || {});
                if ((r_type == 'r_boarding' && r_diet.md_only_daycare != 1) ||
                        (r_type == 'r_daycare' && r_diet.md_only_daycare == 0)) {

                    if (rs.pet[r_type][s[r_type_mod].id].r_diets &&
                        rs.ma(rs.pet[r_type][s[r_type_mod].id].r_diets).length > 0) {

                        var confirm_add = 0,
                            item_add = {};
                        a.forEach(rs.pet[r_type][s[r_type_mod].id].r_diets, function(item){
                            if (item.diet_id == r_diet.md_id) {
                                confirm_add = 1;
                                item_add = item;
                            }
                        });
                        if (confirm_add) {
                            var message = "Do you want to replace '"+ rs.diets[item_add.diet_id].v
                                    +"' with the one from records: '"+  rs.diets[r_diet.md_id].v +"' ?";
                            rs.confirmMsg(message, function(){
                                crud.deleteItem(crud.tbl_arr.r_diets, 'r_diets', item_add.id).then(function(r){
                                    delete s[r_type][s[r_type_mod].id].r_diets[item_add.id];
                                    addDiets(s, r_type, r_type_mod, r_diet);
                                });
                            });
                        } else {
                            addDiets(s, r_type, r_type_mod, r_diet);
                        }
                    } else {
                        addDiets(s, r_type, r_type_mod, r_diet);
                    }
                }
            });
            rs.sh('.submit', '.al');
        }
    };

    rs.deleteRecordsDiets = function(scope_id, r_type, r_type_mod) {
        var s = $(scope_id).scope();
        rs.confirmMsg("Are you sure you want to delete all the diets scheduled for this reservation ?", function(){
            if (rs.pet[r_type][s[r_type_mod].id].r_diets &&
                rs.ma(rs.pet[r_type][s[r_type_mod].id].r_diets).length > 0) {
                rs.hs('.submit', '.al');
                a.forEach(rs.pet[r_type][s[r_type_mod].id].r_diets, function (item) {
                    crud.deleteItem(crud.tbl_arr.r_diets, 'r_diets', item.id);
                });
                rs.pet[r_type][s[r_type_mod].id].r_diets = {};
                rs.sh('.submit', '.al');
            } else {
                rs.alertMsg("No diets to delete");
            }
            rs.added_records_diets = 0;
        });
    };

    rs.deleteDiets = function(scope_id, r_type, r_type_mod, id) {
        var s = $(scope_id).scope();
        rs.confirmMsg('Are you sure you want to delete this diet ?', function(){
            crud.deleteItem(crud.tbl_arr.r_diets, 'r_diets', id).then(function(r){
                delete rs.pet[r_type][s[r_type_mod].id].r_diets[id];
                if (rs.pet[r_type][s[r_type_mod].id].r_diets && rs.ma(rs.pet[r_type][s[r_type_mod].id].r_diets).length == 0) {
                    rs.added_records_diets = 0;
                }
            });
        });
    };

};

var dietsTableDirective = function($compile) {
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
                            '<th>Everyday</th>'+
                            '<th>As needed</th>'+
                            '<th>Instructions</th>'+
                            '<th>Diet type</th>'+
                            '<th>Dose type</th>'+
                            '<th>Date</th>'+
                            '<th></th>'+
                            '</tr>'+
                        '</thead>'+
                        '<tbody>'+
                            '<tr ng-repeat="r_diet in '+ atts.rTypeIn +'">'+
                                '<td>{{$root.diets[r_diet.diet_id].v}}</td>'+
                                '<td>{{(r_diet.diet_morning ? \'yes\' : \'no\')}}</td>'+
                                '<td>{{(r_diet.diet_afternoon ? \'yes\' : \'no\')}}</td>'+
                                '<td>{{(r_diet.diet_evening ? \'yes\' : \'no\')}}</td>'+
                                '<td>{{(r_diet.diet_as_needed ? \'as needed\' : \'-\')}}</td>'+
                                '<td>{{r_diet.diet_instructions || \'-\'}}</td>'+
                                '<td>{{$root.diets_type[r_diet.diet_type_id].v}}</td>'+
                                '<td>'+
                                    '<div ng-show="r_diet.diet_dosage_id">'+
                                        '{{$root.md_dosage[r_diet.diet_dosage_id].v}}'+
                                    '</div>'+
                                    '<div ng-show="r_diet.diet_dose_type_id">'+
                                        '{{$root.md_dose_type[r_diet.diet_dose_type_id].v}}'+
                                    '</div>'+
                                '</td>'+
                                '<td>{{(r_diet.diet_everyday ? \'daily\' : r_diet.diet_date)}}</td>'+
                                '<td>'+
                                    '<a class="button tiny radius" ' +
                                      ' ng-hide="$root.partial_show" ' +
                                      ' ng-click="deleteDiets(\''+ atts.scopeId +'\', \''+ atts.rType +'\', \''+ atts.rTypeMod +'\', r_diet.id)">'+
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

var addRecordsDietsBtnDirective = function($compile) {
    return {
        restrict: "E",
        compile: function(el, atts) {
            return function(s, el, atts) {
                var temp =
                    '<div class="small-6 column">'+
                        '<a class="button tiny radius submit" '+
                            ' ng-hide="$root.added_records_diets" '+
                            ' ng-click="addRecordsDiets(\''+ atts.scopeId +'\', \''+ atts.rType +'\', \''+ atts.rTypeMod +'\')">'+
                                '<i class="fa fa-plus-square-o"></i> Add diets from records'+
                        '</a>'+
                        '<i class="fa fa-spin fa-spinner fa-2x al" style="display: none;"></i>'+
                    '</div>'+
                    '<div class="small-6 column">'+
                        '<a class="button tiny radius submit" '+
                            ' ng-hide="ma($root.pet.'+ atts.rType +'['+ atts.rTypeMod +'.id].r_diets).length == 0" '+
                            ' ng-click="deleteRecordsDiets(\''+ atts.scopeId +'\', \''+ atts.rType +'\', \''+ atts.rTypeMod +'\')">'+
                                '<i class="fa fa-trash"></i> Delete all diets'+
                        '</a>'+
                        '<i class="fa fa-spin fa-spinner fa-2x al" style="display: none;"></i>'+
                    '</div>';
                el.replaceWith($compile(temp)(s));
            }
        }
    }
};