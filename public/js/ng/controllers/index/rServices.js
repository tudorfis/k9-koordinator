/**
 *
 * @param $scope
 * @param api
 * @param crud
 * @param $compile
 */
var rServicesCtrl = function($scope, api, crud, $compile) {

    var s = $scope;
    rs.r_ss_mod = {};
    rs.getSSPrice = function(){
        a.forEach(rs.schedule_services, function(item){
            if (rs.r_ss_mod.ss_id == item.id) {
                rs.r_ss_mod.ss_price = item.price;
                return false;
            }
        });
    };

    rs.submitSS = function(r_type, r_id) {
        rs.sh('.al', '.submit');
        rs.r_ss_mod = a.extend(rs.r_ss_mod, {
            client_id: rs.client.id,
            pet_id: rs.pet.id,
            r_type: r_type,
            r_id: r_id,
        });
        api.post('r_ss', '', rs.r_ss_mod).then(function(r){
            rs.pet[r_type][r_id].r_ss = (rs.pet[r_type][r_id].r_ss || {});
            rs.pet[r_type][r_id].r_ss[r.data.id] = r.data;
            rs.r_ss = (rs.r_ss || {});
            crud.setTableAfterSubmit(crud.tbl_arr.r_ss, r.data);
            rs.hs('.al', '.submit');
        });
    };

    rs.post.r_ss_mod = {
        beforeSubmit: function() {
            var s = {},
                r_type = rs.prd_selected,
                r_type_mod = r_type+'_mod';

            if (r_type == 'r_boarding')     s = $('#rBoardingCtrl').scope();
            else if (r_type == 'r_daycare')  s = $('#rDaycareCtrl').scope();
            else if (r_type == 'r_training') s = $('#rTrainingCtrl').scope();
            else if (r_type == 'r_grooms')   s = $('#rGroomsCtrl').scope();

            rs.post.r_ss_mod.break_submit = 0;

            a.forEach(rs.pet[r_type][s[r_type_mod].id].r_ss, function(item){
                if (item.ss_id == rs.r_ss_mod.ss_id) {
                    rs.alertMsg("This service is already added, please delete it to modify");
                    rs.post.r_ss_mod.break_submit = 1;
                    return false;
                }
            });
            if (!rs.r_ss_mod.ss_everyday) {
                rs.checkDatesExtra(s, r_type_mod, 'date_in', 'date_out', rs.r_ss_mod.ss_date, rs.post.r_ss_mod,
                    "Select date according to pets stay, don't schedule services on invalid dates");
            }
            if (!rs.post.r_ss_mod.break_submit) {
                rs.submitSS(r_type, s[r_type_mod].id);
                rs.post.r_ss_mod.break_submit = 1;
            }
        }
    };

    rs.addRecordsServices = function(scope_id, r_type, r_type_mod) {
        var s = $(scope_id).scope();
        var addRss = function(s, r_type, r_type_mod, r_ss) {
            rs.added_records_services = 1;
            var data = {
                client_id: rs.client.id,
                pet_id: rs.pet.id,
                r_type: r_type,
                r_id: s[r_type_mod].id,
                ss_id: r_ss.ss_id,
                ss_price: rs.schedule_services[r_ss.ss_id].price,
                ss_times: r_ss.no_charges,
                ss_instructions: '',
                ss_exclude_checkin: !r_ss.is_checkin_date,
                ss_exclude_checkout: !r_ss.is_checkout_date,
                ss_date: '',
                ss_everyday: 1
            };
            api.post('r_ss', '', data).then(function(r){
                crud.setTableAfterSubmit(crud.tbl_arr.r_ss, r.data);
                rs.pet[r_type][s[r_type_mod].id].r_ss[r.data.id] = r.data;
                rs.sh('.submit', '.al');
            });
        };
        if (!rs.pet.records_services || rs.ma(rs.pet.records_services).length == 0) {
            rs.alertMsg("You do not have any records services registered");
        } else {
            rs.hs('.submit', '.al');
            a.forEach(rs.pet.records_services, function(r_ss){
                rs.pet[r_type][s[r_type_mod].id].r_ss = (rs.pet[r_type][s[r_type_mod].id].r_ss || {});
                if (r_ss.schedule == 'schedule_always' ||
                        (r_type == 'r_boarding' && r_ss.schedule == 'only_boarding') ||
                            (r_type == 'r_daycare' && r_ss.schedule == 'only_daycare')) {

                    if (rs.pet[r_type][s[r_type_mod].id].r_ss &&
                        rs.ma(rs.pet[r_type][s[r_type_mod].id].r_ss).length > 0) {

                        var confirm_add = 0,
                            item_add = {};
                        a.forEach(rs.pet[r_type][s[r_type_mod].id].r_ss, function(item){
                            if (item.ss_id == r_ss.ss_id) {
                                confirm_add = 1;
                                item_add = item;
                            }
                        });
                        if (confirm_add) {
                            var message = "Do you want to replace '"+ rs.schedule_services[item_add.ss_id].v
                                        +"' with the one from records: '"+  rs.schedule_services[r_ss.ss_id].v +"' ?";
                            rs.confirmMsg(message, function(){
                                crud.deleteItem(crud.tbl_arr.r_ss, 'r_ss', item_add.id).then(function(r){
                                    delete s[r_type][s[r_type_mod].id].r_ss[item_add.id];
                                    addRss(s, r_type, r_type_mod, r_ss);
                                });
                            });
                        } else {
                            addRss(s, r_type, r_type_mod, r_ss);
                        }
                    } else {
                        addRss(s, r_type, r_type_mod, r_ss);
                    }
                }
            });
            rs.sh('.submit', '.al');
        }
    };

    rs.deleteRecordsServices = function(scope_id, r_type, r_type_mod) {
        var s = $(scope_id).scope();
        rs.confirmMsg("Are you sure you want to delete all the services scheduled for this reservation ?", function(){
            if (rs.pet[r_type][s[r_type_mod].id].r_ss &&
                rs.ma(rs.pet[r_type][s[r_type_mod].id].r_ss).length > 0) {
                rs.hs('.submit', '.al');
                a.forEach(rs.pet[r_type][s[r_type_mod].id].r_ss, function (item) {
                    crud.deleteItem(crud.tbl_arr.r_ss, 'r_ss', item.id);
                });
                rs.pet[r_type][s[r_type_mod].id].r_ss = {};
                rs.sh('.submit', '.al');
            } else {
                rs.alertMsg("No services to delete");
            }
            rs.added_records_services = 0;
        });
    };

    rs.deleteSS = function(scope_id, r_type, r_type_mod, id) {
        var s = $(scope_id).scope();
        rs.confirmMsg('Are you sure you want to delete this service ?', function(){
            crud.deleteItem(crud.tbl_arr.r_ss, 'r_ss', id).then(function(r){
                delete s[r_type][s[r_type_mod].id].r_ss[id];
                if (rs.pet[r_type][s[r_type_mod].id].r_ss && rs.ma(rs.pet[r_type][s[r_type_mod].id].r_ss).length == 0) {
                    rs.added_records_services = 0;
                }
            });
        });
    };


};

var servicesTableDirective = function($compile) {
    return {
        restrict: 'E',
        compile: function (el, atts) {
            return function (s, el, atts) {
                var temp =
                    '<table class="small-12">'+
                        '<thead>'+
                            '<tr>'+
                                '<th>Date</th>'+
                                '<th>Qty</th>'+
                                '<th>Service</th>'+
                                '<th>Instructions</th>'+
                                '<th>Price</th>'+
                                '<th>Exclude on checkin</th>'+
                                '<th>Exclude on checkout</th>'+
                                '<th></th>'+
                            '</tr>'+
                        '</thead>'+
                        '<tbody>'+
                            '<tr ng-repeat="r_ss in '+ atts.rTypeIn +'">'+
                                '<td>{{(r_ss.ss_everyday == 1 ? "everyday" : r_ss.ss_date)}}</td>'+
                                '<td>{{r_ss.ss_times}}</td>'+
                                '<td>{{$root.schedule_services[r_ss.ss_id].v}}</td>'+
                                '<td>{{r_ss.ss_instructions || \'-\'}}</td>'+
                                '<td>$ {{r_ss.ss_price}}</td>'+
                                '<td>{{(r_ss.ss_exclude_checkin ? \'yes\' : \'no\')}}</td>'+
                                '<td>{{(r_ss.ss_exclude_checkout ? \'yes\' : \'no\')}}</td>'+
                                '<td>'+
                                    '<a class="button tiny radius" ' +
                                      ' ng-hide="$root.partial_show" ' +
                                      ' ng-click="deleteSS(\''+ atts.scopeId +'\', \''+ atts.rType +'\', \''+ atts.rTypeMod +'\', r_ss.id)">'+
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

var addRecordsServicesBtnDirective = function($compile) {
    return {
        restrict: "E",
        compile: function(el, atts) {
            return function(s, el, atts) {
                var temp =
                    '<div class="small-6 column">'+
                        '<a class="button tiny radius submit" '+
                            ' ng-hide="$root.added_records_services" '+
                            ' ng-click="addRecordsServices(\''+ atts.scopeId +'\', \''+ atts.rType +'\', \''+ atts.rTypeMod +'\')">'+
                                '<i class="fa fa-plus-square-o"></i> Add services from records'+
                        '</a>'+
                        '<i class="fa fa-spin fa-spinner fa-2x al" style="display: none;"></i>'+
                    '</div>'+
                    '<div class="small-6 column">'+
                        '<a class="button tiny radius submit" '+
                            ' ng-hide="ma($root.pet.'+ atts.rType +'['+ atts.rTypeMod +'.id].r_ss).length == 0" '+
                            ' ng-click="deleteRecordsServices(\''+ atts.scopeId +'\', \''+ atts.rType +'\', \''+ atts.rTypeMod +'\')">'+
                                '<i class="fa fa-trash"></i> Delete all services'+
                        '</a>'+
                        '<i class="fa fa-spin fa-spinner fa-2x al" style="display: none;"></i>'+
                    '</div>';

                el.replaceWith($compile(temp)(s));
            }
        }
    }
};