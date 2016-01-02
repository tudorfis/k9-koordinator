var depositsCtrl = function($scope, crud, cp, api) {

    var s = $scope;

    s.d_mod  = {};

    s.d_dates = {
        target_date: 'date_created',
        ngChange: function() {
            s.setDMod({}, 0);
        }
    };

    s.setDMod = function(d_mod, not_editable) {
        s.d_mod = d_mod;
        s.not_editable = not_editable;
    };

    s.deleteDeposit = function(id) {
        rs.confirmMsg('Are you sure you want to delete this deposit ?', function(){
            crud.deleteItem(crud.tbl_arr.deposits, 'deposits', id, 'permanent');
            cp.buildClientsDeposits();
        });
    };

    rs.initDeposits = function(){
        s.d_mod.print_type = (s.d_mod.print_type || 'screen');
        s.d_mod.language = rs.user_interface_settings.language;
        s.d_mod.payment_type_id = rs.user_interface_settings.payment_type_id;
    };

    /**
     * Process deposit
     * @param scopeId
     */
    rs.processDeposit = function(scopeId) {
        var s = $(scopeId).scope();
        if (!s.d_mod.payment_type_id || !s.d_mod.payment_amount) {
            rs.alertMsg('Please select payment type and amount');
        } else {
            var messages = 'You have successfully deposited: '+
                pF(s.d_mod.payment_amount).toFixed(2) +' $ for '+
                    rs.client.last_name+', '+rs.client.first_name;
            rs.confirmMsg(messages, function(){
                rs.hs('.btn_d', '.al_d');
                s.d_mod.date_created = (s.d_mod.date_created || rs.getCDT());
                var id = (s.d_mod.id || ''),
                    data = a.extend(s.d_mod, {
                        client_id: rs.client.id,
                        plus_minus: 'plus',
                        date_created: (s.d_mod.date_created || null),
                        created_user_id: rs.identity.id,
                    });
                api.post('deposits', id, data).then(function (r) {
                    s.d_mod.id = r.data.id;
                    data.id = r.data.id;
                    crud.setTableAfterSubmit(crud.tbl_arr.deposits, data);
                    cp.buildClientsDeposits();
                    rs.sh('.btn_d', '.al_d');
                });
            });
        }
    };

    /**
     * Print bill
     * @param scopeId
     */
    rs.printDepositBill = function(scopeId) {
        var s = $(scopeId).scope();
        if (!s.d_mod.language || !s.d_mod.print_type) {
            rs.alertMsg('Please select language and print type')
        } else {
            rs.hs('.btn_print_d', '.al_print_d');
            rs.depositReport(s.d_mod);
            rs.sh('.btn_print_d', '.al_print_d');
        }
    }


};