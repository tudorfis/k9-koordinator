/**
 *
 * @param $scope
 * @param crud
 * @param $timeout
 * @param cp
 * @param rsv
 */
var rDaycareCtrl = function($scope, api, crud, $timeout, cp, rsv) {

    var s = $scope;

    s.o = {};
    rs.partial_show = 0;
    s.r_daycare_mod = {};
    s.d_dates = {
        target_date: ['date_in', 'date_out', 'date_checkout']
    };

    s.getMod = function(r_daycare, type) {
        rs.section = 'check_in_out';
        rs.partial_show = (r_daycare.in_out == 'out' ? 1 : 0);
        s.r_daycare_mod = a.extend(r_daycare, {
            in_out: (r_daycare.in_out || 'in'),
            pet_id: rs.pet.id,
            client_id: rs.client.id
        });
        if (type == 'new') {
            s.r_daycare_mod = a.extend(s.r_daycare_mod, {
                date_in: rs.getCurrentDate(),
                time_in: rs.getCurrentTime(),
                date_out: rs.getCurrentDate(),
                is_halfday: 0
            });
            if (rs.pet.records_daycare) {
                var pr = rs.pet.records_daycare;
                s.r_daycare_mod = a.extend(s.r_daycare_mod, {
                    records_daycare: pr,
                    daycare_group_id: pr.daycare_group_id,
                });
            } else {
                var ps = rs.daycare_settings;
                s.r_daycare_mod = a.extend(s.r_daycare_mod, {
                    daycare_group_id: ps.se_prefered_group
                });
            }
            rs.setRo(s, 'r_daycare', null);
        } else {
            rs.setRo(s, 'r_daycare', r_daycare.id);
        }
    };

    rs.post.r_daycare_mod = {
        beforeSubmit: function() {
            rs.post.r_daycare_mod.break_submit = 0;
            if (!s.r_daycare_mod.id) {
                rs.checkDatesExists(s, 'r_daycare', 'r_daycare_mod', 'date_in', 'date_out', rs.post.r_daycare_mod);
                rs.checkDatesBigger(s, 'r_daycare_mod', 'date_in', 'date_out', rs.post.r_daycare_mod);
                rs.checkDatesToday(s, 'r_daycare_mod', 'date_in', rs.post.r_daycare_mod);
                rs.setRo(s, 'r_daycare', null);
            } else {
                rs.setRo(s, 'r_daycare', s.r_daycare_mod.id);
            }
        },
        afterSubmit: function(){
            rsv.afterSubmit(s, 'r_daycare', 'r_daycare_mod');
            var rb = s.r_daycare_mod;
            if (!rs.pet.records_daycare) {
                var records_data = {
                    client_id: rb.client_id,
                    pet_id: rb.pet_id,
                    daycare_group_id: rb.daycare_group_id,
                };
                api.post('records_daycare', '', records_data).then(function(r){
                    crud.setTableAfterSubmit(crud.tbl_arr.records_daycare, r.data);
                    rs.pet.records_daycare = r.data;
                });
            }
        }
    };

    s.delete = function(id) {
        rs.confirmMsg('Are you sure you want to delete this daycare reservation ?', function(){
            rsv.afterDelete(id, 'r_daycare', 'r_daycare_mod');
        });
    };

    rs.post.daycare_payments = {
        beforeSubmit: function() {
            var daycare_report = rs.rsvReport(s.o, rs.r_daycare[s.r_daycare_mod.id], s.r_daycare_mod.id, 'r_daycare', 1),
                required = daycare_report.total,
                paid = s.o.paid,
                change = 0,
                unpaid = 0;

            if ((required - paid) > 0) {
                unpaid = required - paid;
            } else {
                change = paid - required;
            }
            s.o = a.extend(s.o, {
                client_id: rs.client.id,
                pet_id: rs.pet.id,
                r_daycare_id: s.r_daycare_mod.id,
                payment_status_id: ((required - paid) > 0 ? 2 : 1),
                required: required,
                paid: paid,
                change: change,
                unpaid: unpaid,
                information: JSON.stringify(s.r_daycare_mod),
                date_created: (s.o.date_created || rs.getCDT()),
                date_modified: rs.getCDT(),
                created_user_id: (s.o.created_user_id || rs.identity.id),
                modified_user_id: rs.identity.id
            });
        },
        afterSubmit: function() {
            rs.r_daycare[s.o.r_daycare_id].o = s.o;
            crud.setTableAfterSubmit(crud.tbl_arr.daycare_payments, s.o);
            crud.setTableAfterSubmit(crud.tbl_arr.r_daycare, rs.r_daycare[s.o.r_daycare_id]);
            cp.buildClientsDaycareBills();
        }
    };

    s.sort_o = 'date_in';
    s.sort_o_r = 'true';
    s.dg_id = '';
    s.sd = '';

};

/**
 *
 * @returns {Function}
 */
var filterDaycare = function(){
    return function(rDaycare) {
        var s = ($('#rDaycareCtrl').scope() || {}),
            filteredDaycare = {};
        if (rDaycare && rs.r_daycare && s.sd) {
            a.forEach(rDaycare, function(item){
                var date_in_t = new Date(item.date_in).getTime(),
                    date_out_t = new Date(item.date_out).getTime(),
                    time_t = new Date(s.sd).getTime();
                if (time_t >= date_in_t && time_t <= date_out_t) {
                    filteredDaycare[item.id] = item;
                }
            });
            return filteredDaycare;
        } else {
            return rDaycare;
        }
    };
};

/**
 *
 * @returns {Function}
 */
var filterDaycareColor = function(){
    return function(time, obj) {
        var s = $('#rDaycareCtrl').scope();
        if (time && rs.r_daycare && rs.daycare_groups && s.dg_id) {
            var limit = pF(rs.daycare_groups[s.dg_id].limit),
                nr = 0;
            a.forEach(rs.r_daycare, function(item){
                var date_in_t = new Date(item.date_in).getTime(),
                    date_out_t = new Date(item.date_out).getTime(),
                    time_t = new Date(time).getTime();
                if (time_t >= date_in_t && time_t <= date_out_t) {
                    nr += 1;
                }
            });
            if (time == s.sd) {
                return 'bg-purple';
            } else if (nr > limit) {
                return 'bg-red';
            } else if (nr == limit) {
                return 'bg-orange';
            } else if (1 == 0 /** condition for not available **/) {
                return 'bg-gray';
            } else {
                return 'bg-white';
            }
        }
    };
};

/**
 *
 * @returns {Function}
 */
var filterDaycareNr = function(){
    return function(time) {
        var s = $('#rDaycareCtrl').scope();
        if (time && rs.r_daycare && rs.daycare_groups && s.dg_id) {
                var limit = rs.daycare_groups[s.dg_id].limit,
                nr = 0;
            a.forEach(rs.r_daycare, function(item){
                var date_in_t = new Date(item.date_in).getTime(),
                    date_out_t = new Date(item.date_out).getTime(),
                    time_t = new Date(time).getTime();
                if (time_t >= date_in_t && time_t <= date_out_t) {
                    nr += 1;
                }
            });
            return nr;
        }
    };
};

/**
 *
 * @param $compile
 * @returns {{restrict: string, compile: Function}}
 */
var weekdaysDaycare = function($compile) {
    return {
        restrict: 'A',
        compile: function(el, atts) {
            return function (s, el, atts) {

                var template =
                    '<table ng-show="dg_id" ' +
                        ' class="small-12 table-bordered table-bold">' +
                        '<tr>' +
                            '<td>' +
                                '<span style="cursor: pointer;" ' +
                                    ' ng-click="sd = \'\'">- show all -</span>' +
                            '</td>';

                for (var i = -1; i <= 8; i++) {
                    var date = new Date();
                    date.setDate(date.getDate()+i);
                    var date_str = rs.getCurrentDate(date),
                        date_day = date.toString().substring(0, 3);

                    template +=
                        '<td style="cursor: pointer;" '+
                           ' class="{{\''+ date_str +'\' | filterDaycareColor}}" '+
                           ' ng-click="sd = \''+date_str+'\'">' +
                                date_day +'<br />'+
                                date_str + '<hr />'+
                                '{{\''+ date_str +'\' | filterDaycareNr}}' +
                        '</td>';
                }
                template += '</tr></table>';
                el.replaceWith($compile(template)(s));
            }
        }
    }
};