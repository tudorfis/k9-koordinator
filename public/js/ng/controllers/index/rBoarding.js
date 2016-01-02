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
var rBoardingCtrl = function($scope, api, cFunc, crud, $timeout, cp, rsv) {

    var s = $scope;

    s.o = {};
    rs.partial_show = 0;
    s.r_boarding_mod = {};
    s.d_dates = {
        target_date: ['date_in', 'date_out', 'date_checkout']
    };

    rs.setRo = function(s, tbl, id) {
        if (rs[tbl][id] && !rs.isEmpty(rs[tbl][id].o)) {
            s.o = rs[tbl][id].o;
        } else {
            s.o = {};
        }
        s.o = a.extend(s.o, {
            print_type: (s.o.print_type || 'screen'),
            language: rs.user_interface_settings.language,
            payment_type_id: rs.user_interface_settings.payment_type_id,
            amount: 0
        });
    };

    s.getMod = function(r_boarding, type) {
        rs.section = 'check_in_out';
        rs.partial_show = (r_boarding.in_out == 'out' ? 1 : 0);
        s.r_boarding_mod = a.extend(r_boarding, {
            in_out: (r_boarding.in_out || 'in'),
            pet_id: rs.pet.id,
            client_id: rs.client.id,
            charge_type: (r_boarding.charge_type || rs.boarding_settings.charge_type)
        });
        s.r_boarding_mod.deposit = (s.r_boarding_mod.deposit || 0);
        if (type == 'new') {
            s.r_boarding_mod = a.extend(s.r_boarding_mod, {
                date_in: rs.getCurrentDate(),
                time_in: rs.getCurrentTime(),
                date_out: rs.getCurrentDate(),
                is_halfday: 2
            });
            if (rs.pet.records_boarding) {
                var pr = rs.pet.records_boarding;
                s.r_boarding_mod = a.extend(s.r_boarding_mod, {
                    records_boarding: pr,
                    charge_type_id: pr.charge_type_id,
                    stay_reason_id: pr.stay_reason_id,
                    is_extra_pet: pr.is_extra_pet,
                    is_handle_carefully: pr.is_handle_carefully
                });
            } else {
                var ps = rs.boarding_settings;
                s.r_boarding_mod = a.extend(s.r_boarding_mod, {
                    charge_type_id: ps.charge_type_id,
                    stay_reason_id: ps.stay_reason_id,
                    is_extra_pet: ps.is_extra_pet,
                    is_handle_carefully: ps.is_handle_carefully
                });
            }
            rs.setRo(s, 'r_boarding', null);
        } else {
            rs.setRo(s, 'r_boarding', r_boarding.id);
        }
    };

    rs.post.r_boarding_mod = {
        beforeSubmit: function() {
            rs.post.r_boarding_mod.break_submit = 0;
            if (!s.r_boarding_mod.id) {
                rs.checkDatesExists(s, 'r_boarding', 'r_boarding_mod', 'date_in', 'date_out', rs.post.r_boarding_mod);
                rs.checkDatesBigger(s, 'r_boarding_mod', 'date_in', 'date_out', rs.post.r_boarding_mod);
                rs.checkDatesToday(s, 'r_boarding_mod', 'date_in', rs.post.r_boarding_mod);
                rs.checkDatesWeekendHolidaysSeason(s, 'r_boarding_mod', 'date_in', 'date_out', rs.post.r_boarding_mod);
                rs.checkCheckInOutTime(s, 'r_boarding_mod', 'time_in', 'time_out', rs.post.r_boarding_mod);
                rs.setRo(s, 'r_boarding', null);
            } else {
                rs.setRo(s, 'r_boarding', s.r_boarding_mod.id);
            }
        },
        afterSubmit: function(){
            rsv.afterSubmit(s, 'r_boarding', 'r_boarding_mod');
            var rb = s.r_boarding_mod;
            if (!rs.pet.records_boarding) {
                var records_data = {
                    client_id: rb.client_id,
                    pet_id: rb.pet_id,
                    charge_type: rb.charge_type,
                    charge_type_id: rb.charge_type_id,
                    stay_reason_id: rb.stay_reason_id,
                    is_extra_pet: rb.is_extra_pet,
                    is_handle_carefully: rb.is_handle_carefully
                };
                api.post('records_boarding', '', records_data).then(function (r) {
                    crud.setTableAfterSubmit(crud.tbl_arr.records_boarding, r.data);
                    rs.pet.records_boarding = r.data;
                });
            }
            if (s.r_boarding_mod.deposit && !s.r_boarding_mod.did_deposit && pF(s.r_boarding_mod.deposit) > 0) {
                s.r_boarding_mod.did_deposit = 1;
                var deposits_data = {
                    client_id: rb.client_id,
                    plus_minus: 'plus',
                    payment_type_id: 1,
                    payment_amount: rb.deposit,
                    is_a_tip: 0,
                    tip_user_id: 0,
                    language: 'en',
                    print_type: 'screen',
                    date_created: rs.getCDT(),
                    created_user_id: rs.identity.id
                };
                api.post('deposits', '', deposits_data).then(function (r) {
                    api.post('r_boarding', s.r_boarding_mod.id, s.r_boarding_mod);
                    crud.setTableAfterSubmit(crud.tbl_arr.deposits, r.data);
                    cp.buildClientsBoardingBills();
                    cp.buildClientsDeposits();
                });
            }
        }
    };

    s.delete = function(id) {
        rs.confirmMsg('Are you sure you want to delete this boarding reservation ?', function(){
            rsv.afterDelete(id, 'r_boarding', 'r_boarding_mod');
        });
    };

    rs.checkoutPet = function(scope_id, r_mod, tbl) {
        var s = $(scope_id).scope();
        if (!s[r_mod].o || rs.isEmpty(s[r_mod].o)) {
            rs.alertMsg("You have to pay first before checking out a pet !");
        } else {
            if (s[r_mod].in_out == 'in') {
                var data = {
                    in_out: 'out',
                    date_checkout: rs.getCurrentDate(),
                    time_checkout: rs.getCurrentTime()
                };
                api.post(tbl, s[r_mod].id, data).then(function(r){
                    s[r_mod] = a.extend(s[r_mod], data);
                    crud.setTableAfterSubmit(crud.tbl_arr[tbl], s[r_mod]);
                    rs.partial_show = 1;
                });
            }
        }
    };

    rs.printRsvBill = function(scope_id, r_mod, tbl) {
        var s = $(scope_id).scope();
        if (!s.o.language || !s.o.print_type) {
            rs.alertMsg('Please select language and print type')
        } else {
            if (rs[tbl][s[r_mod].id]) {
                rs.hs('.btn_print', '.al_print');
                var report = rs.rsvReport(s.o, rs[tbl][s[r_mod].id],  s[r_mod].id, tbl);
                s.o.required = report.total;
                rs.sh('.btn_print', '.al_print');
            }
        }
    };

    rs.post.boarding_payments = {
        beforeSubmit: function() {
            var report = rs.rsvReport(s.o, rs.r_boarding[s.r_boarding_mod.id], s.r_boarding_mod.id, 'r_boarding', 1),
                required = report.total,
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
                r_boarding_id: s.r_boarding_mod.id,
                payment_status_id: ((required - paid) > 0 ? 2 : 1),
                required: required,
                paid: paid,
                change: change,
                unpaid: unpaid,
                information: JSON.stringify(s.r_boarding_mod),
                date_created: (s.o.date_created || rs.getCDT()),
                date_modified: rs.getCDT(),
                created_user_id: (s.o.created_user_id || rs.identity.id),
                modified_user_id: rs.identity.id
            });
        },
        afterSubmit: function() {
            rs.r_boarding[s.o.r_boarding_id].o = s.o;
            crud.setTableAfterSubmit(crud.tbl_arr.boarding_payments, s.o);
            crud.setTableAfterSubmit(crud.tbl_arr.r_boarding, rs.r_boarding[s.o.r_boarding_id]);
            cp.buildClientsBoardingBills();
        }
    };

};