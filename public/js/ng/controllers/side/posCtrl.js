/**
 * Pos Ctrl
 * @param api
 * @param $scope
 * @param $timeout
 * @param cp
 * @param pdf
 */
var posCtrl = function(api, $scope, $timeout, cp, pdf, crud){

    var s = $scope;

    s.o = {
        print_type: 'screen',
        promotion_id: '',
        promotion_discount: 0,
    };

    s.add_qty = null;
    s.use_coupon_promotion = false;
    s.is_walk_in_sale = false;
    s.oo = [];
    s.ri_selected = {};
    s.rio_selected = {};

    s.required = 0;
    s.paid = 0;
    s.change = 0;
    s.unpaid = 0;

    s.filter_inventory_relationship = {
        table: 'retail_vi',
        cn_id: 'retail_vendor_id',
        ev_id: 'vendor_id',
        an_id: 'retail_inventory_id',
        at:    'retail_inventory'
    };

    rs.initPos = function() {
        s.o.print_type = (s.o.print_type || 'screen');
        s.o.language = rs.user_interface_settings.language;
        s.o.payment_type_id = rs.user_interface_settings.payment_type_id;
    };

    s.setRi = function(ri) {

        /** set values **/
        if (s.ri_selected.id && (s.ri_selected.id != ri.id)) {
            s.add_qty = null;
        }

        /** if quantity bigger then existing on stock **/
        if ((pF(s.add_qty) > pF(ri.quantity)) && !s.is_refund) {
            rs.alertMsg("Please enter an valid quantity according to stock inventory");
            s.add_qty = null;
            return;
        }

        /** set vendor id **/
        a.forEach(rs.retail_vi, function(rvi){
            if (rvi.retail_inventory_id == ri.id) {
                ri.vendor_id = rvi.retail_vendor_id;
                ri.vendor_cost = pF(rvi.our_cost).toFixed(2);
                return false;
            }
        });

        /** set class adaos / discounts **/
        ri.total = pF(ri.price) * pF(s.add_qty);
        var temp_total = ri.total;
        ri.margin_p = 0;
        ri.margin_t = 0;
        ri.markup_t = 0;
        a.forEach(rs.classes_discounts, function(cs){
            ri[cs+'_p'] = 0;
            ri[cs+'_t'] = 0;
        });

        var retail_class = rs.retail_classes[ri.class_id];
        if (retail_class) {
            if ((ri.margin_p = pF(retail_class.margin)) > 0) {
                ri.margin_t = pF((temp_total * ri.margin_p) / 100).toFixed(2);
                ri.total -= pF(ri.margin_t);
            } else {
                ri.markup_t = pF(retail_class.markup);
                ri.total -= ri.markup_t;
            }
            a.forEach(rs.classes_discounts, function(cs){
                if ((ri[cs+'_p'] = pF(retail_class[cs])) > 0) {
                    ri[cs+'_t'] = pF((temp_total * ri[cs+'_p']) / 100).toFixed(2);
                    ri.total -= pF(ri[cs+'_t']);
                }
            });
        }

        /** taxes **/
        ri.tax_name = '';
        ri.tax_percentage = 0;
        ri.tax_total = 0;

        ri.o_tax_name = '';
        ri.o_tax_percentage = 0;
        ri.o_tax_total = 0;

        if (ri.tax) {

            ri.tax_name = 'State tax';
            ri.tax_percentage = pF(rs.tax_settings.state_tax);
            ri.tax_total = pF((temp_total * ri.tax_percentage) / 100).toFixed(2);
            ri.total += pF(ri.tax_total);

            if (rs.tax_settings.o_tax_in_use) {
                ri.o_tax_name = rs.tax_settings.o_tax_name;
                ri.o_tax_percentage = pF(rs.tax_settings.o_tax_amount);
                ri.o_tax_total = pF((temp_total * ri.o_tax_percentage) / 100).toFixed(2);
                ri.total += pF(ri.o_tax_total);
            }
        }

        /** vendor cost **/
        if (ri.vendor_cost) {
            ri.total += pF(ri.vendor_cost);
        }

        ri.add_qty = s.add_qty;
        ri.adaos = pF(ri.margin_t) + pF(ri.markup_t);
        ri.discount = 0;
        a.forEach(rs.classes_discounts, function(cs){
            ri.discount += pF(ri[cs+'_t']);
        });

        /** set values **/
        ri.total = pF(ri.total).toFixed(2);
        s.ri_selected = ri;

    };

    s.setRio = function(rio, index) {
        rio.index = index;
        s.rio_selected = rio;
    };

    s.addItem = function() {
        if (!s.is_refund && (rs.isEmpty(s.ri_selected) || !s.add_qty)) {
            rs.alertMsg('Please select an inventory item and a quantity');
        } else {
            if (!s.is_refund) {
                rs.retail_inventory[s.ri_selected.id].quantity -= s.add_qty;
            }
            var ri_selected = rs.unbind(s.ri_selected);
            s.oo.push(ri_selected);
            s.ri_selected = {};
            s.add_qty = null;
            s.calculateTotal();
        }
    };

    /** CLEAR **/
    /** ############################## **/
    s.clearAll = function() {
        if (!s.o.id && !s.is_refund) {
            a.forEach(s.oo, function (rio, k) {
                rs.retail_inventory[rio.id].quantity += rio.add_qty;
            });
        }
        s.oo = [];
        s.calculateTotal();
        s.o.id = '';
        s.change = 0;
        s.did_client_promotions = 0;
    };

    s.clearSale = function(item) {
        a.forEach(s.oo, function(rio, k){
            if (item.index == rio.index) {
                s.oo.splice(k, 1);
                if (!s.o.id && !s.is_refund) {
                    rs.retail_inventory[rio.id].quantity += rio.add_qty;
                }
                s.calculateTotal();
            }
        });
    };

    /** CALCULATE **/
    /** ############################## **/
    s.calculateTotal = function() {
        s.required = 0;
        s.unpaid = 0;
        a.forEach(s.oo, function(rio){
            s.required += pF(rio.total);
        });
        if (s.required > 0 && s.o.promotion_discount) {
            s.required -= pF(s.o.promotion_discount);
        }
        s.unpaid = s.required;
    };

    s.calculatePromotion = function() {
        if (s.o.promotion_id) {
            s.o.promotion_points = pF(rs.promotions[s.o.promotion_id].points);
            s.o.promotion_discount = s.o.promotion_points / pF(rs.promotions_settings.points_per_dollar);
        } else {
            s.o.promotion_points = 0;
            s.o.promotion_discount = 0;
        }
        rs.client.reward_points = (rs.client.reward_points || 0);
        if (pF(rs.client.reward_points) < pF(s.o.promotion_points)) {
            rs.alertMsg("You don't have enogh points for this reward program");
            s.o.promotion_id = 0;
            s.o.promotion_points = 0;
            s.o.promotion_discount = 0;
        }
        s.did_client_promotions = 0;
        s.calculateTotal()
    };

    s.calculateCoupon = function() {
        var ri = s.ri_selected;
        ri.coupon_total = 0;
        if (rs.access.checkCouponsPos()) {
            if (s.coupon_discount < 0 || s.coupon_discount > 100) {
                rs.alertMsg("Please enter a value between 0 and 100");
            } else {
                ri.coupon_modifier = s.coupon_modifier;
                ri.coupon_discount = s.coupon_discount;
            }
            if (pF(s.coupon_modifier) == 2 && s.coupon_discount) {
                ri.coupon_total = s.coupon_discount;
            } else if (pF(s.coupon_modifier) == 1 && s.coupon_discount) {
                var product_total = pF(ri.price) * pF(s.add_qty);
                ri.coupon_total = (product_total * pF(s.coupon_discount)) / 100;
            }
        }
    };

    s.restockInventory = function() {
        if (s.o.id && s.is_refund) {
            a.forEach(s.oo, function (rio, k) {
                rs.retail_inventory[rio.id].quantity += rio.add_qty;
                rio.add_qty = 0;
            });
        }
    };

    /** PAYMENT **/
    /** ############################## **/
    rs.processPosPayment = function(payment_status_id, scopeId) {
        var s = $(scopeId).scope();
        if (s.oo.length == 0) {
            rs.alertMsg('Please select items from inventory');
        } else {
            if (payment_status_id == 1 && !s.o.use_deposit && (!s.o.payment_type_id || !s.paid)) {
                rs.alertMsg('Please select payment type and amount');
            } else {
                var information = {
                    o: s.o,
                    oo: s.oo
                };
                s.o.date_created = (s.o.date_created || rs.getCDT());

                if (!s.is_refund) {
                    if (s.o.paid) {
                        s.paid += pF(s.o.paid);
                    }
                    if (pF(s.paid) > pF(s.required)) {
                        s.change = pF(s.paid) - pF(s.required);
                        s.unpaid = 0;
                    } else if (pF(s.paid) < pF(s.required)) {
                        s.change = 0;
                        s.unpaid = pF(s.required) - pF(s.paid);
                        payment_status_id = 2;
                    } else if (pF(s.paid) == pF(s.required)) {
                        s.change = 0;
                        s.unpaid = 0;
                    }
                } else {
                    s.paid = 0;
                    s.change = 0;
                    s.unpaid = 0;
                }
                rs.hs('.submit', '.al');
                rs.hs('.btn_pp', '.al_pp');

                s.o.required = s.required;
                s.o.paid = s.paid;
                s.o.change = s.change;
                s.o.unpaid = s.unpaid;
                s.o.payment_status_id = payment_status_id;

                var id = (s.o.id || ''),
                    data = {
                        client_id: (!s.is_walk_in_sale ? rs.client.id : 0),
                        use_deposit: (s.o.use_deposit || 0),
                        payment_status_id: payment_status_id,
                        payment_type_id: s.o.payment_type_id,
                        required: pF(s.required).toFixed(2),
                        paid: pF(s.paid).toFixed(2),
                        change: pF(s.change).toFixed(2),
                        unpaid: pF(s.unpaid).toFixed(2),
                        information: JSON.stringify(information),
                        created_user_id: rs.identity.id,
                        date_created: (s.o.date_created || null),
                        date_modified: (s.o.date_modified || null),
                        modified_user_id: (s.o.modified_user_id || null)
                    };
                api.post('pos_payments', id, data).then(function(r){
                    s.o.id = r.data.id;
                    crud.setTableAfterSubmit(crud.tbl_arr.pos_payments,  r.data);
                    cp.buildClientsPosBills();
                    a.forEach(s.oo, function (rio) {
                        var ri_data = {
                            quantity: rs.retail_inventory[rio.id].quantity
                        };
                        api.post('retail_inventory', rio.id, ri_data);
                    });

                    if (rs.access.checkRewards() && rs.access.checkRewardsIsActive
                                    && !s.is_walk_in_sale && !s.did_client_promotions) {
                        var client = rs.clients[rs.client.id];
                        client.reward_points = (client.reward_points || 0);
                        if (s.o.promotion_id) {
                            client.reward_points = pF(client.reward_points) - pF(s.o.promotion_points);
                        }
                        if (!s.is_refund) {
                            var acumulated_points = pF(s.required) / pF(rs.promotions_settings.points_per_dollar);
                            rs.alertMsg('Congratulations! You have acumulated '+ pF(acumulated_points).toFixed(2) +' reward points !');

                            client.reward_points += acumulated_points;
                            client.reward_points = pF(client.reward_points).toFixed(2);
                            var data = {
                                client_id: client.id,
                                points: client.reward_points
                            };
                            var extra_json = {
                                filter: {
                                    id_n: 'client_id',
                                    id_v: rs.client.id,
                                }
                            };
                            api.post('clients_rewards', '', data, '', extra_json).then(function(r){
                                s.did_client_promotions = 1;
                            });
                        }
                    }

                    if (s.o.use_deposit) {
                        s.d_mod = (s.d_mod || {});
                        s.d_mod.date_created = (s.d_mod.date_created || rs.getCDT());
                        s.d_mod = a.extend(s.d_mod, {
                            client_id: rs.client.id,
                            plus_minus: 'minus',
                            payment_type_id: 0,
                            payment_amount: pF(s.paid).toFixed(2),
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
                    rs.sh('.submit', '.al');
                    rs.sh('.btn_pp', '.al_pp');
                });
            }
        }
    };

    /** PRINT **/
    /** ################################ **/
    rs.printPosBill = function(scopeId) {
        var s = $(scopeId).scope();
        if (!s.o.language || !s.o.print_type) {
            rs.alertMsg('Please select language and print type')
        } else if (s.oo.length == 0) {
            rs.alertMsg('Please add inventory items');
        } else {
            rs.hs('.submit', '.al');
            rs.hs('.btn_print', '.al_print');
            rs.posReport(
                s.o.language,
                s.o.print_type,
                s.is_walk_in_sale,
                s.required,
                s.paid,
                s.change,
                s.unpaid,
                s.o,
                s.oo
            );
            rs.sh('.submit', '.al');
            rs.sh('.btn_print', '.al_print');
        }
    }
};