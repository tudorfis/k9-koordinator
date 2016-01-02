/**
 *
 * @param $scope
 * @param api
 * @param cFunc
 * @param crud
 * @param $timeout
 * @param cp
 * @param rsv
 */
var rGroomsCtrl = function($scope, api, cFunc, crud, $timeout, cp, rsv) {

    var s = $scope;

    s.o = {};
    rs.partial_show = 0;
    s.r_grooms_mod = {};
    s.d_dates = {
        target_date: ['date_in', 'date_out', 'date_checkout']
    };

    s.getMod = function(r_grooms, type) {
        rs.section = 'check_in_out';
        rs.partial_show = (r_grooms.in_out == 'out' ? 1 : 0);
        s.r_grooms_mod = a.extend(r_grooms, {
            in_out: (r_grooms.in_out || 'in'),
            pet_id: rs.pet.id,
            client_id: rs.client.id
        });
        if (type == 'new') {
            s.r_grooms_mod = a.extend(s.r_grooms_mod, {
                date_in: rs.getCurrentDate(),
                time_in: rs.getCurrentTime(),
                date_out: rs.getCurrentDate(),
            });
            if (rs.pet.records_grooming) {
                var pr = rs.pet.records_grooming;
                s.r_grooms_mod = a.extend(s.r_grooms_mod, {
                    records_grooms: pr,
                    groomer_id: pr.g_id,
                    base_type_id: pr.base_type_id,
                    grooming_rate_id: pr.gr_id,
                    multiplier: rs.grooming_rates[pr.gr_id].multiplier
                });
                a.forEach(rs.pet.records_grooming.gs_ids, function(gs_id){
                    s.r_grooms_mod['gs_'+gs_id] = true;
                });
            }
            rs.setRo(s, 'r_grooms', null);
        } else {
            if (r_grooms.gs_array && rs.ma(r_grooms.gs_array).length > 0) {
                a.forEach(r_grooms.gs_array, function(gs_id){
                    s.r_grooms_mod['gs_'+gs_id] = true;
                });
            }
            rs.setRo(s, 'r_grooms', r_grooms.id);
        }
    };

    rs.post.r_grooms_mod = {
        beforeSubmit: function() {
            rs.post.r_grooms_mod.break_submit = 0;
            if (!s.r_grooms_mod.id) {
                rs.checkDatesExists(s, 'r_grooms', 'r_grooms_mod', 'date_in', 'date_out', rs.post.r_grooms_mod);
                rs.checkDatesBigger(s, 'r_grooms_mod', 'date_in', 'date_out', rs.post.r_grooms_mod);
                rs.checkDatesToday(s, 'r_grooms_mod', 'date_in', rs.post.r_grooms_mod);
                rs.setRo(s, 'r_grooms', null);
            } else {
                rs.setRo(s, 'r_grooms', s.r_grooms_mod.id);
            }
            rs.post.r_grooms_mod.break_submit = 1;
            a.forEach(rs.grooming_services, function (gs, gs_id) {
                if (s.r_grooms_mod['gs_' + gs_id]) {
                    rs.post.r_grooms_mod.break_submit = 0;
                    return false;
                }
            });
            if (rs.post.r_grooms_mod.break_submit) {
                rs.alertMsg("Please add gromming services");
            } else {
                rs.post.r_grooms_mod.break_submit = 0;
                s.r_grooms_mod.gs_array = [];
                a.forEach(rs.grooming_services, function (gs, gs_id) {
                    if (s.r_grooms_mod['gs_' + gs_id]) {
                        s.r_grooms_mod.gs_array.push(gs_id);
                    }
                });
                s.r_grooms_mod.gs_array = JSON.stringify(s.r_grooms_mod.gs_array);
            }
        },
        afterSubmit: function(){
            rsv.afterSubmit(s, 'r_grooms', 'r_grooms_mod');
            var rg = s.r_grooms_mod;
            if (!rs.pet.records_grooming) {
                var records_data = {
                    client_id: rg.client_id,
                    pet_id: rg.pet_id,
                    g_id: rg.groomer_id,
                    base_type_id: rg.base_type_id,
                    gr_id: rg.grooming_rate_id,
                    gs_ids: rg.gs_array
                };
                api.post('records_grooming', '', records_data).then(function(r){
                    crud.setTableAfterSubmit(crud.tbl_arr.records_grooming, r.data);
                    r.data.gs_ids = JSON.parse(r.data.gs_ids);
                    rs.pet.records_grooming = r.data;
                });
            }
            s.r_grooms_mod.gs_array = JSON.parse(s.r_grooms_mod.gs_array);
        }
    };

    s.delete = function (id) {
        rs.confirmMsg('Are you sure you want to delete this groom reservation ?', function(){
            rsv.afterDelete(id, 'r_grooms', 'r_grooms_mod');
        });
    };

    rs.post.grooms_payments = {
        beforeSubmit: function() {
            var grooms_report = rs.rsvReport(s.o, rs.r_grooms[s.r_grooms_mod.id], s.r_grooms_mod.id, 'r_grooms', 1),
                required = grooms_report.total,
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
                r_grooms_id: s.r_grooms_mod.id,
                payment_status_id: ((required - paid) > 0 ? 2 : 1),
                required: required,
                paid: paid,
                change: change,
                unpaid: unpaid,
                information: JSON.stringify(s.r_grooms_mod),
                date_created: (s.o.date_created || rs.getCDT()),
                date_modified: rs.getCDT(),
                created_user_id: (s.o.created_user_id || rs.identity.id),
                modified_user_id: rs.identity.id
            });
        },
        afterSubmit: function() {
            rs.r_grooms[s.o.r_grooms_id].o = s.o;
            crud.setTableAfterSubmit(crud.tbl_arr.grooms_payments, s.o);
            crud.setTableAfterSubmit(crud.tbl_arr.r_grooms, rs.r_grooms[s.o.r_grooms_id]);
            cp.buildClientsGroomsBills();
        }
    };

    s.clearInputs = function () {
        a.forEach(rs.grooming_services, function (gs, gs_id) {
            s.r_grooms_mod['gs_' + gs_id] = false;
        });
    };

};


