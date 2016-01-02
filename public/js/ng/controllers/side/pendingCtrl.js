/**
 *
 * @param $scope
 */
var pendingCtrl = function($scope, api, cp) {

    var s = $scope;

    s.pp_selected = {};
    s.bp_selected = {};
    s.dp_selected = {};
    s.gp_selected = {};
    s.tp_selected = {};

    s.d_dates = {
        target_date: 'date_created',
        ngChange: function() {
            s.setPp({});
            s.setBp({});
            s.setDp({});
            s.setGp({});
            s.setTp({});
        }
    };

    s.setAllEmpty = function() {
        s.pp_selected = {};
        s.bp_selected = {};
        s.dp_selected = {};
        s.tp_selected = {};
        s.gp_selected = {};
    };

    s.seto = function() {
        s.o = a.extend(s.o, {
            print_type: (s.o.print_type || 'screen'),
            language: rs.user_interface_settings.language,
            payment_type_id: rs.user_interface_settings.payment_type_id,
            paid: 0
        });
    };

    s.setPp = function(pp) {
        s.setAllEmpty();
        s.pp_selected = pp;
        if (!rs.isEmpty(pp)) {
            var information = JSON.parse(s.pp_selected.information);
            s.required = s.pp_selected.required;
            s.paid = s.pp_selected.paid;
            s.change = s.pp_selected.change;
            s.unpaid = s.pp_selected.unpaid;
            s.o = information.o;
            s.oo = (information.oo || {});
            s.o.id = s.pp_selected.id;
            s.o.date_modified = rs.getCDT();
            s.o.modified_user_id = rs.identity.id;
        }
        s.seto();
    };

    s.setBp = function(bp) {
        s.setAllEmpty();
        s.bp_selected = bp;
        if (!rs.isEmpty(bp)) {
            s.required = s.bp_selected.required;
            s.paid = s.bp_selected.paid;
            s.change = s.bp_selected.change;
            s.unpaid = s.bp_selected.unpaid;
            s.o = (s.o || {});
            s.o.id = s.bp_selected.id;
            s.o.date_modified = rs.getCDT();
            s.o.modified_user_id = rs.identity.id;
        }
        s.seto();
    };

    s.setDp = function(dp) {
        s.setAllEmpty();
        s.dp_selected = dp;
        if (!rs.isEmpty(dp)) {
            s.required = s.dp_selected.required;
            s.paid = s.dp_selected.paid;
            s.change = s.dp_selected.change;
            s.unpaid = s.dp_selected.unpaid;
            s.o = (s.o || {});
            s.o.id = s.dp_selected.id;
            s.o.date_modified = rs.getCDT();
            s.o.modified_user_id = rs.identity.id;
        }
        s.seto();
    };

    s.setGp = function(gp) {
        s.setAllEmpty();
        s.gp_selected = gp;
        if (!rs.isEmpty(gp)) {
            s.required = s.gp_selected.required;
            s.paid = s.gp_selected.paid;
            s.change = s.gp_selected.change;
            s.unpaid = s.gp_selected.unpaid;
            s.o = (s.o || {});
            s.o.id = s.gp_selected.id;
            s.o.date_modified = rs.getCDT();
            s.o.modified_user_id = rs.identity.id;
        }
        s.seto();
    };

     s.setTp = function(tp) {
        s.setAllEmpty();
        s.tp_selected = tp;
        if (!rs.isEmpty(tp)) {
            s.required = s.tp_selected.required;
            s.paid = s.tp_selected.paid;
            s.change = s.tp_selected.change;
            s.unpaid = s.tp_selected.unpaid;
            s.o = (s.o || {});
            s.o.id = s.tp_selected.id;
            s.o.date_modified = rs.getCDT();
            s.o.modified_user_id = rs.identity.id;
        }
        s.seto();
    };

    rs.initPending = function(not_first) {
        s.total_amount = 0;
        s.most_recent = null;
        s.oldest_debt = null;
        a.forEach(['pp', 'bp', 'dp', 'gp', 'tp'], function(tbl){
            a.forEach(rs.client[tbl].pending, function(pending){
                s.total_amount += pF(pending.unpaid);
                if (!s.most_recent || ((new Date(s.most_recent).getTime()) > (new Date(pending.date_created).getTime()))) {
                    s.most_recent = pending.date_created;
                }
                if (!s.oldest_debt || ((new Date(s.oldest_debt).getTime()) < (new Date(pending.date_created).getTime()))) {
                    s.oldest_debt = pending.date_created;
                }
            });
        });
        if (!not_first) {
            if (rs.client.pp.pending.length == 1) {
                s.setPp(rs.client.pp.pending[0]);
            } else if (rs.client.bp.pending.length == 1) {
                s.setBp(rs.client.bp.pending[0]);
            } else if (rs.client.dp.pending.length == 1) {
                s.setDp(rs.client.dp.pending[0]);
            } else if (rs.client.gp.pending.length == 1) {
                s.setGp(rs.client.gp.pending[0]);
            } else if (rs.client.tp.pending.length == 1) {
                s.setTp(rs.client.tp.pending[0]);
            }
        }
    };

    s.printBoardingBill = function() {
        var id = s.bp_selected.r_boarding_id;
        if (!s.o.language || !s.o.print_type) {
            rs.alertMsg('Please select language and print type')
        } else {
            if (rs.r_boarding[id]) {
                rs.hs('.submit', '.al');
                rs.rsvReport(s.o, rs.r_boarding[id], id, 'r_boarding');
                rs.sh('.submit', '.al');
            }
        }
    };

    s.printDaycareBill = function() {
        var id = s.dp_selected.r_daycare_id;
        if (!s.o.language || !s.o.print_type) {
            rs.alertMsg('Please select language and print type')
        } else {
            if (rs.r_daycare[id]) {
                rs.hs('.submit', '.al');
                rs.rsvReport(s.o, rs.r_daycare[id], id, 'r_daycare');
                rs.sh('.submit', '.al');
            }
        }
    };

    s.printGroomsBill = function() {
        var id = s.gp_selected.r_grooms_id;
        if (!s.o.language || !s.o.print_type) {
            rs.alertMsg('Please select language and print type')
        } else {
            if (rs.r_grooms[id]) {
                rs.hs('.submit', '.al');
                rs.rsvReport(s.o, rs.r_grooms[id], id, 'r_grooms');
                rs.sh('.submit', '.al');
            }
        }
    };

    s.printTrainingBill = function() {
        var id = s.tp_selected.r_training_id;
        if (!s.o.language || !s.o.print_type) {
            rs.alertMsg('Please select language and print type')
        } else {
            if (rs.r_training[id]) {
                rs.hs('.submit', '.al');
                rs.rsvReport(s.o, rs.r_training[id], id, 'r_training');
                rs.sh('.submit', '.al');
            }
        }
    };

    s.processBoardingPayment = function() {
        if (!s.o.payment_type_id || !s.paid) {
            rs.alertMsg("Please select payment type and payment amount")
        } else {
            rs.hs('.submit', '.al');
            var required = s.required,
                paid = s.paid,
                change = 0,
                unpaid = 0;
            if ((required - paid) > 0) {
                unpaid = required - paid;
            } else {
                change = paid - required;
            }
            var payment_status_id = ((required - paid) > 0 ? 2 : 1);
            s.o = a.extend(s.o, {
                payment_type_id: s.o.payment_type_id,
                payment_status_id: payment_status_id,
                paid: paid,
                change: change,
                unpaid: unpaid,
                date_modified: rs.getCDT(),
                modified_user_id: rs.identity.id
            });
            s.change = change;
            s.unpaid = unpaid;
            api.post('boarding_payments', s.o.id, s.o).then(function(r){
                rs.sh('.submit', '.al');
                if (payment_status_id == 1) {
                    rs.client.bp.pending_total -= required;
                    a.forEach(rs.client.bp.pending, function(pending, index){
                        if (pending.id == s.o.id) {
                            rs.client.bp.pending.splice(index, 1);
                        }
                    });
                    delete rs.boarding_payments[s.o.id];
                }
                rs.r_boarding[s.bp_selected.r_boarding_id].o = r.data;
                cp.buildClientsBoardingBills();

                if (s.o.use_deposit) {
                    s.d_mod = (s.d_mod || {});
                    s.d_mod.date_created = (s.d_mod.date_created || rs.getCDT());
                    s.d_mod = a.extend(s.d_mod, {
                        client_id: rs.client.id,
                        plus_minus: 'minus',
                        payment_type_id: 0,
                        payment_amount: pF(paid).toFixed(2),
                        is_a_tip: 0,
                        tip_user_id: 0,
                        language: s.o.language,
                        print_type: s.o.print_type,
                        created_user_id: rs.identity.id
                    });
                    api.post('deposits', s.d_mod.id, s.d_mod).then(function (r) {
                        s.d_mod.id = r.data.id;
                        crud.setTableAfterSubmit(crud.tbl_arr.deposits, s.d_mod);
                        cp.buildClientsDeposits();
                    });
                }
                rs.initPending(1);
            });
        }
    };

    s.processDaycarePayment = function() {
        if (!s.o.payment_type_id || !s.paid) {
            rs.alertMsg("Please select payment type and payment amount")
        } else {
            rs.hs('.submit', '.al');
            var required = s.required,
                paid = s.paid,
                change = 0,
                unpaid = 0;
            if ((required - paid) > 0) {
                unpaid = required - paid;
            } else {
                change = paid - required;
            }
            var payment_status_id = ((required - paid) > 0 ? 2 : 1);
            s.o = a.extend(s.o, {
                payment_type_id: s.o.payment_type_id,
                payment_status_id: payment_status_id,
                paid: paid,
                change: change,
                unpaid: unpaid,
                date_modified: rs.getCDT(),
                modified_user_id: rs.identity.id
            });
            s.change = change;
            s.unpaid = unpaid;
            api.post('daycare_payments', s.o.id, s.o).then(function(r){
                rs.sh('.submit', '.al');
                if (payment_status_id == 1) {
                    rs.client.dp.pending_total -= required;
                    a.forEach(rs.client.dp.pending, function(pending, index){
                        if (pending.id == s.o.id) {
                            rs.client.dp.pending.splice(index, 1);
                        }
                    });
                    delete rs.daycare_payments[s.o.id];
                }
                rs.r_daycare[s.dp_selected.r_daycare_id].o = r.data;
                cp.buildClientsDaycareBills();

                if (s.o.use_deposit) {
                    s.d_mod = (s.d_mod || {});
                    s.d_mod.date_created = (s.d_mod.date_created || rs.getCDT());
                    s.d_mod = a.extend(s.d_mod, {
                        client_id: rs.client.id,
                        plus_minus: 'minus',
                        payment_type_id: 0,
                        payment_amount: pF(paid).toFixed(2),
                        is_a_tip: 0,
                        tip_user_id: 0,
                        language: s.o.language,
                        print_type: s.o.print_type,
                        created_user_id: rs.identity.id
                    });
                    api.post('deposits', s.d_mod.id, s.d_mod).then(function (r) {
                        s.d_mod.id = r.data.id;
                        crud.setTableAfterSubmit(crud.tbl_arr.deposits, s.d_mod);
                        cp.buildClientsDeposits();
                    });
                }
                rs.initPending(1);
            });
        }
    };

    s.processGroomsPayment = function() {
        if (!s.o.payment_type_id || !s.paid) {
            rs.alertMsg("Please select payment type and payment amount")
        } else {
            rs.hs('.submit', '.al');
            var required = s.required,
                paid = s.paid,
                change = 0,
                unpaid = 0;
            if ((required - paid) > 0) {
                unpaid = required - paid;
            } else {
                change = paid - required;
            }
            var payment_status_id = ((required - paid) > 0 ? 2 : 1);
            s.o = a.extend(s.o, {
                payment_type_id: s.o.payment_type_id,
                payment_status_id: payment_status_id,
                paid: paid,
                change: change,
                unpaid: unpaid,
                date_modified: rs.getCDT(),
                modified_user_id: rs.identity.id
            });
            s.change = change;
            s.unpaid = unpaid;
            api.post('grooms_payments', s.o.id, s.o).then(function(r){
                rs.sh('.submit', '.al');
                if (payment_status_id == 1) {
                    rs.client.gp.pending_total -= required;
                    a.forEach(rs.client.gp.pending, function(pending, index){
                        if (pending.id == s.o.id) {
                            rs.client.gp.pending.splice(index, 1);
                        }
                    });
                    delete rs.grooms_payments[s.o.id];
                }
                rs.r_grooms[s.gp_selected.r_grooms_id].o = r.data;
                cp.buildClientsGroomsBills();

                if (s.o.use_deposit) {
                    s.d_mod = (s.d_mod || {});
                    s.d_mod.date_created = (s.d_mod.date_created || rs.getCDT());
                    s.d_mod = a.extend(s.d_mod, {
                        client_id: rs.client.id,
                        plus_minus: 'minus',
                        payment_type_id: 0,
                        payment_amount: pF(paid).toFixed(2),
                        is_a_tip: 0,
                        tip_user_id: 0,
                        language: s.o.language,
                        print_type: s.o.print_type,
                        created_user_id: rs.identity.id
                    });
                    api.post('deposits', s.d_mod.id, s.d_mod).then(function (r) {
                        s.d_mod.id = r.data.id;
                        crud.setTableAfterSubmit(crud.tbl_arr.deposits, s.d_mod);
                        cp.buildClientsDeposits();
                    });
                }
                rs.initPending(1);
            });
        }
    };

     s.processTrainingPayment = function() {
        if (!s.o.payment_type_id || !s.paid) {
            rs.alertMsg("Please select payment type and payment amount")
        } else {
            rs.hs('.submit', '.al');
            var required = s.required,
                paid = s.paid,
                change = 0,
                unpaid = 0;
            if ((required - paid) > 0) {
                unpaid = required - paid;
            } else {
                change = paid - required;
            }
            var payment_status_id = ((required - paid) > 0 ? 2 : 1);
            s.o = a.extend(s.o, {
                payment_type_id: s.o.payment_type_id,
                payment_status_id: payment_status_id,
                paid: paid,
                change: change,
                unpaid: unpaid,
                date_modified: rs.getCDT(),
                modified_user_id: rs.identity.id
            });
            s.change = change;
            s.unpaid = unpaid;
            api.post('training_payments', s.o.id, s.o).then(function(r){
                rs.sh('.submit', '.al');
                if (payment_status_id == 1) {
                    rs.client.tp.pending_total -= required;
                    a.forEach(rs.client.tp.pending, function(pending, index){
                        if (pending.id == s.o.id) {
                            rs.client.tp.pending.splice(index, 1);
                        }
                    });
                    delete rs.training_payments[s.o.id];
                }
                rs.r_training[s.tp_selected.r_training_id].o = r.data;
                cp.buildClientsTrainingBills();

                if (s.o.use_deposit) {
                    s.d_mod = (s.d_mod || {});
                    s.d_mod.date_created = (s.d_mod.date_created || rs.getCDT());
                    s.d_mod = a.extend(s.d_mod, {
                        client_id: rs.client.id,
                        plus_minus: 'minus',
                        payment_type_id: 0,
                        payment_amount: pF(paid).toFixed(2),
                        is_a_tip: 0,
                        tip_user_id: 0,
                        language: s.o.language,
                        print_type: s.o.print_type,
                        created_user_id: rs.identity.id
                    });
                    api.post('deposits', s.d_mod.id, s.d_mod).then(function (r) {
                        s.d_mod.id = r.data.id;
                        crud.setTableAfterSubmit(crud.tbl_arr.deposits, s.d_mod);
                        cp.buildClientsDeposits();
                    });
                }
                rs.initPending(1);
            });
        }
    }



};