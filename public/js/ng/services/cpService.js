
/**
 * client / pet service
 */
var cpService = function(models, access) {

    var self = this;
    this.rsv_tables = ['r_boarding', 'r_daycare', 'r_training', 'r_grooms'];
    this.clients_b = null;

    this.doAll = function() {

        /** builds **/
        self.initCp();
        self.buildCp();
        self.buildPets();
        self.buildClients();
        self.buildClientOptions('clients_membership', 'client_membership');
        self.buildClientOptions('clients_survey', 'client_survey');
        self.buildClientOptions('clients_private', 'client_private');
        self.setClientSearchBy();
        self.buildClientsPosBills();
        self.buildClientsBoardingBills();
        self.buildClientsDaycareBills();
        self.buildClientsGroomsBills();
        self.buildClientsTrainingBills();
        self.buildClientsDeposits();

        /** extra **/
        self.clients_b = rs.unbind(rs.clients);
    };
    
    /** set cp **/
    this.initCp = function() {
        if (!access.checkBoarding()) self.rsv_tables.splice(self.rsv_tables.indexOf('r_boarding'), 1);
        if (!access.checkDaycare())  self.rsv_tables.splice(self.rsv_tables.indexOf('r_daycare'), 1);
        if (!access.checkTraining()) self.rsv_tables.splice(self.rsv_tables.indexOf('r_training'), 1);
        if (!access.checkGrooming()) self.rsv_tables.splice(self.rsv_tables.indexOf('r_grooms'), 1);
    };

    /** build cp **/
    this.buildCp = function() {
        var cp_cp = {},
            cp = {};
        a.forEach(rs.cp, function(item){
            var client_id = item.client_id,
                pet_id = item.pet_id;
            if (rs.clients[client_id] && rs.pets[pet_id]) {
                if (cp[client_id]) {
                    cp[client_id].push(pet_id);
                } else {
                    cp[client_id] = [pet_id];
                }
                cp_cp[pet_id] = [client_id];
            }
        });
        rs.cp = cp;
        rs.cp_cp = cp_cp;
    };

    /** build pet rsv **/
    this.buildPetsRsv = function() {
        /** make rsv **/
        a.forEach(self.rsv_tables, function(tbl){
            a.forEach(rs[tbl], function(item){
                if (item.pet_id && rs.pets[item.pet_id]) {
                    if (!rs.pets[item.pet_id][tbl]) {
                        rs.pets[item.pet_id][tbl] = {};
                    }
                    rs.pets[item.pet_id][tbl][item.id] = item;
                }
                var payment_tbl = tbl.replace("r_", "")+"_payments";
                a.forEach(rs[payment_tbl], function(item_payment){
                    if (item_payment[tbl+'_id'] == item.id) {
                        rs[tbl][item.id].o = item_payment;
                        rs.pets[item.pet_id][tbl][item.id].o = item_payment;
                    }
                });
            });
        });
    };

    /** extra rsv **/
    this.buildPetsRsvExtra = function() {
        /** services **/
        a.forEach(rs.r_ss, function(item){
            if (rs.pets[item.pet_id] && rs.pets[item.pet_id][item.r_type]) {
                a.forEach(rs.pets[item.pet_id][item.r_type], function(r_b){
                    if (r_b.id == item.r_id) {
                        if (!rs.pets[item.pet_id][item.r_type][item.r_id].r_ss) {
                            rs.pets[item.pet_id][item.r_type][item.r_id].r_ss = {};
                        };
                        rs.pets[item.pet_id][item.r_type][item.r_id].r_ss[item.id] = item;
                        return false;
                    }
                });
            }
        });
        /** meds **/
        a.forEach(rs.r_meds, function(item){
            if (rs.pets[item.pet_id] && rs.pets[item.pet_id][item.r_type]) {
                a.forEach(rs.pets[item.pet_id][item.r_type], function(r_b){
                    if (r_b.id == item.r_id) {
                        if (!rs.pets[item.pet_id][item.r_type][item.r_id].r_meds) {
                            rs.pets[item.pet_id][item.r_type][item.r_id].r_meds = {};
                        }
                        rs.pets[item.pet_id][item.r_type][item.r_id].r_meds[item.id] = item;
                        return false;
                    }
                });
            }
        });
        /** diets **/
        a.forEach(rs.r_diets, function(item){
            if (rs.pets[item.pet_id] && rs.pets[item.pet_id][item.r_type]) {
                a.forEach(rs.pets[item.pet_id][item.r_type], function(r_b){
                    if (r_b.id == item.r_id) {
                        if (!rs.pets[item.pet_id][item.r_type][item.r_id].r_diets) {
                            rs.pets[item.pet_id][item.r_type][item.r_id].r_diets = {};
                        }
                        rs.pets[item.pet_id][item.r_type][item.r_id].r_diets[item.id] = item;
                        return false;
                    }
                });
            }
        });
    };

    /** build pets records **/
    this.buildPetsRecords = function() {
        a.forEach(rs.records_boarding, function(item){
            if (rs.pets[item.pet_id]) {
                rs.pets[item.pet_id].records_boarding = item;
                return false;
            }
        });
        a.forEach(rs.records_daycare, function(item){
            if (rs.pets[item.pet_id]) {
                rs.pets[item.pet_id].records_daycare = item;
                return false;
            }
        });
        a.forEach(rs.records_training, function(item){
            if (rs.pets[item.pet_id]) {
                rs.pets[item.pet_id].records_training = item;
                return false;
            }
        });
        a.forEach(rs.records_grooming, function(item){
            if (rs.pets[item.pet_id]) {
                rs.pets[item.pet_id].records_grooming = item;
                rs.pets[item.pet_id].records_grooming.gs_ids =
                    (rs.pets[item.pet_id].records_grooming.gs_ids ?
                        JSON.parse(rs.pets[item.pet_id].records_grooming.gs_ids) : []);
                return false;
            }
        });
        a.forEach(rs.records_services, function(item){
            if (rs.pets[item.pet_id]) {
                rs.pets[item.pet_id].records_services = (rs.pets[item.pet_id].records_services || {});
                rs.pets[item.pet_id].records_services[item.id] = item;
            }
        });
        a.forEach(rs.records_meds_diets, function(item){
            if (rs.pets[item.pet_id]) {
                if (item.type == 1) {
                    rs.pets[item.pet_id].records_meds = (rs.pets[item.pet_id].records_meds || {});
                    rs.pets[item.pet_id].records_meds[item.id] = item;
                } else if (item.type == 2) {
                    rs.pets[item.pet_id].records_diets = (rs.pets[item.pet_id].records_diets || {});
                    rs.pets[item.pet_id].records_diets[item.id] = item;
                }
            }
        });
    };

    /** build pets **/
    this.buildPets = function(type){

        /** pet rsv **/
        self.buildPetsRsv();

        /** pet extra rsv **/
        self.buildPetsRsvExtra();

        /** pet records **/
        self.buildPetsRecords();

        /** calculate no of visits **/
        self.calculatePetNoVisits();

        /** make last veterinary apointment **/
        a.forEach(rs.pet_vet, function(pet_vet){
            if (rs.pets[pet_vet.pet_id]) {
                rs.pets[pet_vet.pet_id].pet_vet = pet_vet;
            }
        });

        /** add sticky notes **/
        a.forEach(rs.sticky, function(item){
            if (rs.cp_cp[item.pet_id] && !item.client_id) {
                rs.pets[item.pet_id].sticky = item;
            }
        });
    };

    /** pet make no visits **/
    this.calculatePetNoVisits = function(pet) {
        var calculateVisits = function(pet) {
            pet.no_visits = 0;
            a.forEach(self.rsv_tables, function(r_tbl){
                pet.no_visits += (pet[r_tbl] ? rs.ma(pet[r_tbl]).length : 0);
            });
        };
        if (pet) {
            calculateVisits(pet);
        } else {
            a.forEach(rs.pets, function(pet){
                calculateVisits(pet);
            });
        }
    };

    this.setClientPrefferedPhone = function(client){
        client.preffered_phone = (client.contact_phone || '');
        switch (client.preffered_phone_id) {
            case 1: client.preffered_phone  = (client.contact_phone ? client.contact_phone : ''); break;
            case 2: client.preffered_phone  = (client.contact_cell ? client.contact_cell : ''); break;
            case 3: client.preffered_phone  = (client.contact_work_phone ? client.contact_work_phone : ''); break;
            case 4: client.preffered_phone  = (client.emergency_phone ? client.emergency_phone : ''); break;
        }
        return client;
    };

    /** build clients **/
    this.buildClients = function(type) {
        a.forEach(rs.clients, function(client, client_id){
            var pet_id = (rs.cp[client_id]) ? rs.cp[client_id].slice(-1)[0] : '';
            rs.clients[client_id].pet = (pet_id) ? rs.pets[pet_id] : {};
            client = self.setClientPrefferedPhone(client);
        });
        /** sticky **/
        a.forEach(rs.sticky, function(item){
            if (rs.cp[item.client_id] && !item.pet_id) {
                rs.clients[item.client_id].sticky = item;
            }
        });
        /** reward points **/
        a.forEach(rs.clients_rewards, function(item){
            if (rs.clients[item.client_id]) {
                rs.clients[item.client_id].reward_points = (rs.cp[item.client_id] ? pF(item.points) : 0);
            }
        });
        /** client refferals **/
        a.forEach(rs.clients_survey, function(item){
            if (item.client_survey_findout_id == 5) {
                rs.clients[item.reffered_id].refferals = (rs.clients[item.reffered_id].refferals || 0);
                rs.clients[item.reffered_id].refferals += 1;
            }
        });
    };

    /** build client options **/
    this.buildClientOptions = function(table, target) {
        a.forEach(rs[table], function(item){
            if (rs.clients[item.client_id]) {
                rs.clients[item.client_id][target] = item;
            }
        });
    };

    this.setClientSearchBy = function() {
        rs.client_search_by = 'name';
        var default_search_id = rs.general_features[23].v;
        if (default_search_id == 5) {
            rs.client_search_by = 'breed';
        } else if (default_search_id == 4) {
            rs.client_search_by = 'pet_id';
        } else if (default_search_id == 3) {
            rs.client_search_by = 'pet';
        } else if (default_search_id == 2) {
            rs.client_search_by = 'phone';
        } else if (default_search_id == 1 && rs.access.checkMembership()) {
            rs.client_search_by = 'membership';
        }
    };

    this.buildClientsPosBills = function() {
        a.forEach(rs.clients, function(client){
            client.pp = {
                processed: [],
                pending: [],
                refunded: [],
                pending_total: 0,
                processed_total: 0,
                refunded_total: 0
            }
        });
        a.forEach(rs.pos_payments, function(pp){
            if (pp.client_id) {
                if (rs.clients[pp.client_id]) {
                    if (pp.payment_status_id == 1) {
                        rs.clients[pp.client_id].pp.processed.push(pp);
                        rs.clients[pp.client_id].pp.processed_total += pp.required;
                    } else if (pp.payment_status_id == 2) {
                        rs.clients[pp.client_id].pp.pending.push(pp);
                        rs.clients[pp.client_id].pp.pending_total += pp.unpaid;
                    } else if (pp.payment_status_id == 3) {
                        rs.clients[pp.client_id].pp.refunded.push(pp);
                        rs.clients[pp.client_id].pp.refunded_total += pp.required;
                    }
                }
            }
        });
    };

    this.buildClientsBoardingBills = function() {
        a.forEach(rs.clients, function(client){
            client.bp = {
                processed: [],
                pending: [],
                pending_total: 0,
                processed_total: 0,
            }
        });
        a.forEach(rs.boarding_payments, function(bp){
            if (bp.client_id) {
                if (rs.clients[bp.client_id]) {
                    if (bp.payment_status_id == 1) {
                        rs.clients[bp.client_id].bp.processed.push(bp);
                        rs.clients[bp.client_id].bp.processed_total += bp.required;
                    } else if (bp.payment_status_id == 2) {
                        rs.clients[bp.client_id].bp.pending.push(bp);
                        rs.clients[bp.client_id].bp.pending_total += bp.unpaid;
                    }
                }
            }
        });
    };

    this.buildClientsDaycareBills = function() {
        a.forEach(rs.clients, function(client){
            client.dp = {
                processed: [],
                pending: [],
                pending_total: 0,
                processed_total: 0,
            }
        });
        a.forEach(rs.daycare_payments, function(dp){
            if (dp.client_id) {
                if (rs.clients[dp.client_id]) {
                    if (dp.payment_status_id == 1) {
                        rs.clients[dp.client_id].dp.processed.push(dp);
                        rs.clients[dp.client_id].dp.processed_total += dp.required;
                    } else if (dp.payment_status_id == 2) {
                        rs.clients[dp.client_id].dp.pending.push(dp);
                        rs.clients[dp.client_id].dp.pending_total += dp.unpaid;
                    }
                }
            }
        });
    };

    this.buildClientsGroomsBills = function() {
        a.forEach(rs.clients, function(client){
            client.gp = {
                processed: [],
                pending: [],
                pending_total: 0,
                processed_total: 0,
            }
        });
        a.forEach(rs.grooms_payments, function(gp){
            if (gp.client_id) {
                if (rs.clients[gp.client_id]) {
                    if (gp.payment_status_id == 1) {
                        rs.clients[gp.client_id].gp.processed.push(gp);
                        rs.clients[gp.client_id].gp.processed_total += gp.required;
                    } else if (gp.payment_status_id == 2) {
                        rs.clients[gp.client_id].gp.pending.push(gp);
                        rs.clients[gp.client_id].gp.pending_total += gp.unpaid;
                    }
                }
            }
        });
    };

    this.buildClientsTrainingBills = function() {
        a.forEach(rs.clients, function(client){
            client.tp = {
                processed: [],
                pending: [],
                pending_total: 0,
                processed_total: 0,
            }
        });
        a.forEach(rs.training_payments, function(tp){
            if (tp.client_id) {
                if (rs.clients[tp.client_id]) {
                    if (tp.payment_status_id == 1) {
                        rs.clients[tp.client_id].tp.processed.push(tp);
                        rs.clients[tp.client_id].tp.processed_total += tp.required;
                    } else if (tp.payment_status_id == 2) {
                        rs.clients[tp.client_id].tp.pending.push(tp);
                        rs.clients[tp.client_id].tp.pending_total += tp.unpaid;
                    }
                }
            }
        });
    };

    this.buildClientsDeposits = function() {
        a.forEach(rs.clients, function(client){
            client.deposits = {
                total: 0,
                data: []
            }
        });
        a.forEach(rs.deposits, function(d){
            if (rs.clients[d.client_id]) {
                if (d.plus_minus == 'plus') {
                    rs.clients[d.client_id].deposits.total += pF(d.payment_amount);
                } else if (d.plus_minus == 'minus') {
                    rs.clients[d.client_id].deposits.total -= pF(d.payment_amount);
                }
                rs.clients[d.client_id].deposits.data.push(d);
            }
        })
    };

};