/**
 * Client Pet Controller
 * @param $scope
 * @param api
 * @param $timeout
 * @param cFunc
 * @param cp
 * @param $filter
 * @param crud
 * @param pdf
 * @param models
 */
var cpCtrl = function ($scope, api, $timeout, cFunc, cp, $filter, crud, pdf, models, rsv) {

    var s = $scope;

    /**
    * SAVE / DELETE CLIENT PET
    * ###############################################################################################
    */
    var cpForm = $('#cpForm');
    cpForm.on('submit', function(){
        return false;
    });
    cpForm.on('valid', function(){
        rs.sh('.al_form', cpForm);
        api.post('clients', rs.client.id, rs.client).then(function(r){
            rs.client.id = r.data.id;
            rs.client.date_created = (rs.client.date_created || rs.getCurrentDate());
            api.post('pets', rs.pet.id, rs.pet).then(function(r){
                rs.pet.id = r.data.id;
                rs.pet.date_created = (rs.pet.date_created || rs.getCurrentDate());
                rs.client.pet = rs.pet;
                crud.setTableAfterSubmit(crud.tbl_arr.pets, rs.pet);
                crud.setTableAfterSubmit(crud.tbl_arr.clients, rs.client);
                var cp_data = {
                    client_id: rs.client.id,
                    pet_id:    rs.pet.id
                };
                api.post('cp', '', cp_data, 'taxonomy').then(function(r){
                    var client_id = rs.client.id,
                        pet_id = rs.pet.id;
                    if (!rs.cp[client_id]) {
                        rs.cp[client_id] = [pet_id];
                    } else if (rs.cp[client_id].indexOf(pet_id) == -1) {
                        rs.cp[client_id].push(pet_id);
                    }
                    if (!rs.cp_cp[pet_id]) {
                        rs.cp_cp[pet_id] = [client_id];
                    }
                    rs.client = cp.setClientPrefferedPhone(rs.client);
                    rs.clients[rs.client.id] = rs.client;
                    rs.hs('.al_form', cpForm);
                });
            });
        });
        return false;
    });
    s.deleteCp = function(table, client_id, pet_id) {
        rs.confirmMsg('Are you sure you want to delete ?', function(){
            rs.pet = {};
            if (table == 'clients') {
                crud.deleteItem(crud.tbl_arr.clients, 'clients', client_id);
                if (rs.cp[client_id]) {
                    a.forEach(rs.cp[client_id], function(pet_id){
                        crud.deleteItem(crud.tbl_arr.pets, 'pets', pet_id, true);
                        if (rs.cp_cp[pet_id]) {
                            delete rs.cp_cp[pet_id];
                        }
                    });
                    delete rs.cp[client_id];
                    rs.client = {};
                    s.c = {};
                }
                rs.fadeOutElement('#clients-sticky');
                rs.closeModal('#cpModal');
            } else if (table == 'pets') {
                crud.deleteItem(crud.tbl_arr.pets, 'pets', pet_id);
                var index = rs.cp[client_id].indexOf(pet_id);
                rs.cp[client_id].splice(index, 1);

                if (rs.cp_cp[pet_id]) {
                    delete rs.cp_cp[pet_id];
                }
                var new_pet_id = rs.cp[client_id][rs.cp[client_id].length-1];
                rs.pet = rs.pets[new_pet_id];
                rs.clients[client_id].pet = rs.pet;
            }
            rs.fadeOutElement('#pets-sticky');
        });
    };

    /**
     * CLIENT SURVEY
     * ###############################################################################################
     */
    s.getClientSurvey = function() {
        if (rs.client.client_survey) {
            s.client_survey_mod = rs.client.client_survey;
        } else {
            s.client_survey_mod = {};
            s.client_survey_mod.client_id = rs.client.id;
        }
    };
    rs.post.client_survey_mod = {
        afterSubmit: function () {
            crud.setTableAfterSubmit(crud.tbl_arr.clients_survey, s.client_survey_mod);
            rs.client.client_survey = s.client_survey_mod;
        }
    };
    /**
     * CLIENT MEMBERSHIP
     * ###############################################################################################
     */
    s.getClientMembership = function() {
        if (rs.client.client_membership) {
            s.client_membership_mod = rs.client.client_membership;
        } else {
            s.client_membership_mod = {};
            s.client_membership_mod.client_id = rs.client.id;
        }
        s.client_membership_mod.print_type = 'screen';
        s.clientGenerateBarcode();
    };
    s.clientGenerateBarcode = function(regenerate) {
        if (!s.client_membership_mod.barcode || regenerate) {
            s.client_membership_mod.barcode = cFunc.generateNumber(10);
        }
        $('#clients-membership').find('#barcode').JsBarcode(s.client_membership_mod.barcode.toString());
    };
    s.printMembershipCard = function() {
        rs.hs('.submit', '.al');
        if (s.client_membership_mod.print_photo_client) {
            pdf.makeImage(rs, 'client', 'image_id', 'client_image', 'path_thumb');
        }
        if (s.client_membership_mod.print_photo_pet) {
            pdf.makeImage(rs, 'pet', 'image_id', 'pet_image', 'path_thumb')
        }
        if (s.client_membership_mod.print_photo_client ||
            s.client_membership_mod.print_photo_pet) {
            $timeout(function(){
                rs.clientMembershipReport(s);
            }, 2000);
        } else {
            rs.clientMembershipReport(s);
        }
        rs.sh('.submit', '.al');
    };
    rs.post.client_membership_mod = {
        afterSubmit: function () {
            crud.setTableAfterSubmit(crud.tbl_arr.clients_membership, s.client_membership_mod);
            rs.client.client_membership = s.client_membership_mod;
            s.printMembershipCard();
        }
    };
    /**
     * CLIENT PRIVATE
     * ###############################################################################################
     */
    s.saveClientPrivate = function() {
        rs.hs('.btn_sp', '.al_sp');
        rs.client.client_private = (rs.client.client_private || {});
        rs.client.client_private.client_id = rs.client.id;
        var id = (rs.client.client_private.id || '');
        api.post('clients_private', id, rs.client.client_private).then(function(r){
            rs.client.client_private.id = r.data.id;
            crud.setTableAfterSubmit(crud.tbl_arr.clients_private, rs.client.client_private);
            rs.sh('.btn_sp', '.al_sp');
        });
    };

    /**
     * PET
     * ###############################################################################################
     */
    s.selectPet = function(type, pet_id) {
        if (!pet_id) {
            var current_pet_id = rs.pet.id;
            a.forEach(rs.cp[rs.client.id], function(test_pet_id, k){
                if (test_pet_id == current_pet_id) {
                    if (type == 'previous') {
                        pet_id = rs.cp[rs.client.id][k-1];
                    } else if (type == 'next') {
                        pet_id = rs.cp[rs.client.id][k+1];
                    }
                    return false;
                }
            });
        }
        if (pet_id) {
            rs.pet = rs.pets[pet_id];
            rs.client.pet = rs.pet;
            rs.clients[rs.client.id].pet = rs.pet;
        }
    };
    s.addPet = function() {
        rs.pet = {};
    };
    s.restorePet = function() {
        if (!rs.client.pet) {
            var pet_id = rs.cp[rs.client.id][0];
            rs.client.pet = rs.pets[pet_id];
        }
        rs.pet = rs.client.pet;
    };

    /**
    * NOTEPADS
    * ###############################################################################################
    */
    s.nm = {};
    s.editNotepad = function(n) {
        s.nm = n;
        s.$broadcast('nm');
    };
    s.saveNotepad = function() {
        rs.sh('.al_sn', '.btn_sn');
        s.nm.date_created = (s.nm.date_created || rs.getCDT());
        s.nm.date_modified = rs.getCDT();
        s.nm.id = (s.nm.id || '');
        api.post('notepads', s.nm.id, s.nm).then(function(r){
            s.nm.id = r.data.id;
            crud.setTableAfterSubmit(crud.tbl_arr.notepads, s.nm);
            rs.hs('.al_sn', '.btn_sn');
        });
    };
    s.deleteNotepad = function(id) {
        rs.confirmMsg('Are you sure you want to delete this notepad ?', function(){
            crud.deleteItem(crud.tbl_arr.notepads, 'notepads', id).then(function(){
                s.editNotepad({});
            });
        });
    };

    /**
    * GEO LOCATION
    * ###############################################################################################
    */
    rs.getGeoAddress = function(scope_id, s, f, t, c) {
       if (rs.autoselect_zip) {
           f = (f || 3);
           t = (rs.user_interface_settings.zip_postcode_length || 7);
           c = (rs.user_interface_settings.country || c);
           api.geoLocation(s, f, t, c).then(function(r){
               if (scope_id == '#CpCtrl') {
                   rs.client = a.extend(rs.client, {
                       address_street: r.street,
                       address_city: r.city,
                       address_state: r.state
                   });
               } else if (scope_id == '#CrudCtrl') {
                   var scope_el = $(scope_id).scope();
                   scope_el.crud_mod = a.extend(scope_el.crud_mod, {
                       street: r.street,
                       city: r.city,
                       state: r.state
                   });
               } else if (scope_id == '#MyAccountCtrl') {
                   rs.identity = a.extend(rs.identity, {
                       street: r.street,
                       city: r.city,
                       state: r.state
                   });
               }
           })
       }
    };

    /** Check client preffered phone **/
    rs.checkClientPrefferedPhone = function() {
        if (rs.client.preffered_phone_id) {
            switch (rs.client.preffered_phone_id) {
                case 1:
                    if (!rs.client.contact_phone) {
                        rs.alertMsg("Please enter contact phone");
                        $('input[ng-model="client.contact_phone"]').focus()
                    }
                    break;
                case 2:
                    if (!rs.client.contact_cell) {
                        rs.alertMsg("Please enter contact cell");
                        $('input[ng-model="client.contact_cell"]').focus()
                    }
                    break;
                case 3:
                    if (!rs.client.contact_work_phone) {
                        rs.alertMsg("Please enter work phone");
                        $('input[ng-model="client.contact_work_phone"]').focus()
                    }
                    break;
                case 4:
                    if (!rs.client.emergency_phone) {
                        rs.alertMsg("Please enter emergency phone");
                        $('input[ng-model="client.emergency_phone"]').focus()
                    }
                    break;
            }
        }
    };

    /**
     * STICKY
     * ###############################################################################################
     */
    $(function() {
        $( "#pets-sticky" ).draggable();
        $( "#clients-sticky" ).draggable();
    });

    /** save sticky **/
    rs.saveSticky = function(type) {
        var t = rs[type].sticky;
        t = (t || {});
        t.id = (t.id || '');
        t[type+'_id'] = rs[type].id;
        t.user_id = (t.user_id || rs.identity.id);
        t.date = rs.getCDT();
        api.post('sticky', t.id, t).then(function(r){
            t.id = r.data.id;
            crud.setTableAfterSubmit(crud.tbl_arr[type+'s'], rs[type]);
            crud.setTableAfterSubmit(crud.tbl_arr.sticky, t);
        });
    };

    /** delete sticky **/
    rs.deleteSticky = function(type) {
        if (rs[type].sticky.id) {
            rs.confirmMsg('Are you sure you want to delete this sticky note ?', function(){
                crud.deleteItem(crud.tbl_arr.sticky, 'sticky', rs[type].sticky.id);
                rs[type].sticky = {};
                crud.setTableAfterSubmit(crud.tbl_arr[type+'s'], rs[type]);
            });
        }
    };

    /**
     * SEARCH
     * #############################################################################################
     */
    rs.resetSearch = function() {
        rs.hideContentShowAl();
        rs.clients = cp.clients_b;
        rs.client = {};
        rs.pet = {};
        rs.hideAlShowContent();
    };

    rs.setSearchBy = function(type) {
        rs.client_search_by = type;
        rs.keywords = '';
        rs.pet_type_id = null;
        rs.pet_breed_id = null;
        rs.resetSearch();
        $('.keywords').focus();
    };

    rs.makePetsIds = function(pet_ids) {
        var clients = {};
        a.forEach(pet_ids, function(pet_id){
            if (rs.cp_cp[pet_id]) {
                var client_id = rs.cp_cp[pet_id];
                if (cp.clients_b[client_id]) {
                    var client = cp.clients_b[client_id];
                    client.pet = rs.pets[pet_id];
                    if (!clients[client_id]) {
                        clients[client_id] = client;
                    }
                }
            }
        });
        return clients;
    };

    rs.$watch('keywords', function(){
        if (!rs.keywords && !rs.pet_type_id && !rs.pet_breed_id) {
            rs.resetSearch();
        }
    });

    rs.search = function(check) {
        if (!rs.keywords && !rs.pet_type_id && !rs.pet_breed_id) {
            rs.resetSearch();
        } else {
            rs.hideContentShowAl();
            var pet_ids = [],
                clients = {};
            switch (rs.client_search_by)
            {
                case 'name':
                    a.forEach(rs.clients, function(client){
                        var str1 = (client.first_name ? client.first_name.toLowerCase() : ''),
                            str2 = (client.last_name ? client.last_name.toLowerCase() : ''),
                            match = rs.keywords.toLowerCase();
                        if (str1.match(match) || str2.match(match)) {
                            clients[client.id] = client;
                        }
                    });
                    break;
                case 'pet':
                    a.forEach(rs.pets, function(pet, pet_id){
                        var str = (pet.pet_name ? pet.pet_name.toLowerCase() : ''),
                            match = rs.keywords.toLowerCase();
                        if (str.match(match)) {
                            pet_ids.push(pet_id);
                        }
                    });
                    clients = rs.makePetsIds(pet_ids);
                    break;
                case 'phone':
                    a.forEach(rs.clients, function(client){
                        a.forEach(['contact_phone', 'contact_work_phone', 'contact_cell', 'emergency_phone'], function(phone){
                            var str = client[phone],
                                match = rs.keywords;
                            if (str && str.match(match)) {
                                clients[client.id] = client;
                            }
                        });
                    });
                    break;
                case 'breed':
                    if (rs.pet_type_id !== null) {
                        pet_ids = [];
                        a.forEach(rs.pets, function(pet, pet_id){
                            if (pet.pet_type_id == rs.pet_type_id) {
                                if (check == 'pet_breed_id' && rs.pet_breed_id) {
                                    if (pet.pet_breed_id == rs.pet_breed_id) {
                                        pet_ids.push(pet_id);
                                    }
                                } else {
                                    pet_ids.push(pet_id);
                                }
                            }
                        });
                        clients = rs.makePetsIds(pet_ids);
                    } else {
                        rs.resetSearch();
                    }
                    break;
                case 'pet_id':
                    a.forEach(rs.pets, function(pet, pet_id){
                        var str = pet.id.toString(),
                            match = rs.keywords.toLowerCase();
                        if (str.match(match)) {
                            pet_ids.push(pet_id);
                        }
                    });
                    clients = rs.makePetsIds(pet_ids);
                    break;
                case 'membership':
                    a.forEach(rs.clients, function(client){
                        if (client.client_membership) {
                            var str1 = client.client_membership.barcode.toString()
                            match = rs.keywords.toLowerCase();
                            if (str1.match(match)) {
                                clients[client.id] = client;
                            }
                        }
                    });
                    break;

            }
            rs.clients = clients;

            /** if found **/
            if ($filter('array')(clients).length == 1) {
                var client = $filter('array')(clients)[0];
                rs.client = client;
                rs.pet = client.pet;
            }

            rs.hideAlShowContent();
        }
    };

    /** PET PANEL **/
    /** #################################### **/
    s.updatePet = function() {
        $('.petBtn').hide();
        $('.petAl').show();
        api.post('pets', rs.pet.id, rs.pet).then(function(r){
            crud.setTableAfterSubmit(crud.tbl_arr.pets, rs.pet);
            $('.petBtn').fadeIn('medium');
            $('.petAl').hide();
        });
    };

    /** UPDATE PET VET **/
    /** ###################################################################### **/
    rs.updatePetVet = function() {
        $('.pvBtn').hide();
        $('.pvAl').show();
        rs.pet.pet_vet = rs.pet.pet_vet || {};
        rs.pet.pet_vet.pet_id = rs.pet.id;
        var pet_vet_id = ((rs.pet_vet && rs.pet.pet_vet.id) ? rs.pet.pet_vet.id : '');
        api.post('pet_vet', pet_vet_id, rs.pet.pet_vet).then(function(r){
            rs.pet.pet_vet.id = r.data.id;
            crud.setTableAfterSubmit(crud.tbl_arr.pet_vet, rs.pet.pet_vet);
            crud.setTableAfterSubmit(crud.tbl_arr.pets, rs.pet);
            $('.pvBtn').fadeIn('medium');
            $('.pvAl').hide();
        });
    };

    /** QUICK CHECKIN **/
    /** #################################### **/
    s.checkInBoarding = function() {
        $timeout(function(){
            var isCheckedin = false,
                today = rs.getCurrentDate();
            a.forEach(rs.r_boarding, function(item, id){
                if ((item.date_in == today || item.date_out == today) && item.in_out == 'in' &&
                        item.pet_id == rs.pet.id && item.client_id == rs.client.id) {
                    isCheckedin = true;
                    return false;
                }
            });
            rs.prd_selected = 'r_boarding';
            if (isCheckedin) {
                rs.alertMsg('Already checked in the pet for today, you can modify if necesary');
            } else {
                var charge_type_id = null,
                    stay_reason_id = null,
                    is_handle_carefully = null,
                    is_extra_pet = null,
                    is_set = 0;
                if (rs.isEmpty(rs.pet.records_boarding)) {
                    if (!rs.boarding_settings.charge_type_id && !rs.boarding_settings.stay_reason_id) {
                        rs.alertMsg('First set boarding records for pet or set default settings in "Reservations" - "Boarding settings"!');
                        $('#recordsBoardingModal').foundation('reveal', 'open');
                    } else {
                        charge_type_id = rs.boarding_settings.charge_type_id;
                        stay_reason_id = rs.boarding_settings.stay_reason_id;
                        is_handle_carefully = rs.boarding_settings.is_handle_carefully;
                        is_extra_pet = rs.boarding_settings.is_extra_pet;
                        is_set = 1;
                    }
                } else {
                    charge_type_id = rs.pet.records_boarding.charge_type_id;
                    stay_reason_id = rs.pet.records_boarding.stay_reason_id;
                    is_handle_carefully = rs.pet.records_boarding.is_handle_carefully;
                    is_extra_pet = rs.pet.records_boarding.is_extra_pet;
                    is_set = 1;
                }
                if (is_set) {
                    s.r_boarding_mod = {
                        client_id: rs.client.id,
                        pet_id: rs.pet.id,
                        stay_reason_id: stay_reason_id,
                        charge_type: rs.boarding_settings.charge_type,
                        charge_type_id: charge_type_id,
                        is_handle_carefully: is_handle_carefully,
                        is_extra_pet: is_extra_pet,
                        in_out: 'in',
                        date_in: rs.getCurrentDate(),
                        time_in: rs.getCurrentTime(),
                        date_out: rs.getCurrentDate(),
                        time_out: rs.getCurrentTime()
                    };
                    api.post('r_boarding', '', s.r_boarding_mod).then(function(r){
                        s.r_boarding_mod = r.data;
                        rsv.afterSubmit(s, 'r_boarding', 'r_boarding_mod');
                        crud.setTableAfterSubmit(crud.tbl_arr.pets, rs.pet);
                        crud.setTableAfterSubmit(crud.tbl_arr.r_boarding, s.r_boarding_mod);
                    });
                }
            }
        }, 200);
    };

    s.checkInDaycare = function() {
        $timeout(function(){
            var isCheckedin = false,
                today = rs.getCurrentDate();
            a.forEach(rs.r_daycare, function(item, id){
                if ((item.date_in == today || item.date_out == today) && item.in_out == 'in' &&
                        item.pet_id == rs.pet.id && item.client_id == rs.client.id) {
                    isCheckedin = true;
                    return false;
                }
            });
            rs.prd_selected = 'r_daycare';
            if (isCheckedin) {
                rs.alertMsg('Already checked in the pet for today, you can modify if necesary');
            } else {
                var is_set = 0,
                    daycare_group_id = null;
                if (rs.isEmpty(rs.pet.records_daycare)) {
                    if (!rs.daycare_settings.se_prefered_group) {
                        rs.alertMsg('First set daycare records for pet or set default settings in "Reservations" - "daycare settings"!');
                        $('#recordsDaycareModal').foundation('reveal', 'open');
                    } else {
                        daycare_group_id = rs.daycare_settings.se_prefered_group;
                        is_set = 1;
                    }
                } else {
                    daycare_group_id = rs.pet.records_daycare.daycare_group_id;
                    is_set = 1;
                }
                if (is_set) {
                    s.r_daycare_mod = {
                        client_id: rs.client.id,
                        pet_id: rs.pet.id,
                        daycare_group_id: daycare_group_id,
                        in_out: 'in',
                        is_halfday: 1,
                        date_in: rs.getCurrentDate(),
                        time_in: rs.getCurrentTime(),
                        date_out: rs.getCurrentDate(),
                        time_out: rs.getCurrentTime()
                    };
                    api.post('r_daycare', '', s.r_daycare_mod).then(function(r){
                        s.r_daycare_mod = r.data;
                        rsv.afterSubmit(s, 'r_daycare', 'r_daycare_mod');
                        crud.setTableAfterSubmit(crud.tbl_arr.pets, rs.pet);
                        crud.setTableAfterSubmit(crud.tbl_arr.r_daycare, s.r_daycare_mod);
                    });
                }
            }
        }, 200);
    };

    s.checkInGrooms = function() {
        $timeout(function(){
            var isCheckedin = false,
                today = rs.getCurrentDate();
            a.forEach(rs.r_grooms, function(item, id){
                if ((item.date_in == today || item.date_out == today) && item.in_out == 'in' &&
                    item.pet_id == rs.pet.id && item.client_id == rs.client.id) {
                    isCheckedin = true;
                    return false;
                }
            });
            rs.prd_selected = 'r_grooms';
            if (isCheckedin) {
                rs.alertMsg('Already checked in the pet for today, you can modify if necesary');
            } else {
                var is_set = 0;
                if (rs.isEmpty(rs.pet.records_grooming)) {
                    rs.alertMsg('First set grooms records for pet');
                    $('#recordsGroomingModal').foundation('reveal', 'open');
                } else {
                    is_set = 1;
                    var groomer_id = rs.pet.records_grooming.g_id,
                        base_type_id = rs.pet.records_grooming.base_type_id,
                        grooming_rate_id = rs.pet.records_grooming.gr_id,
                        multiplier = rs.grooming_rates[rs.pet.records_grooming.gr_id].multiplier,
                        gs_array = (rs.pet.records_grooming.gs_ids && rs.pet.records_grooming.gs_ids.length > 0 ? JSON.stringify(rs.pet.records_grooming.gs_ids) : ""),
                        is_hcp = rs.pet.records_grooming.is_hcp;
                }
                if (is_set) {
                    s.r_grooms_mod = {
                        client_id: rs.client.id,
                        pet_id: rs.pet.id,
                        groomer_id: groomer_id,
                        base_type_id: base_type_id,
                        grooming_rate_id: grooming_rate_id,
                        multiplier: multiplier,
                        gs_array: gs_array,
                        is_hcp: is_hcp,
                        in_out: 'in',
                        date_in: rs.getCurrentDate(),
                        time_in: rs.getCurrentTime(),
                        date_out: rs.getCurrentDate(),
                        time_out: rs.getCurrentTime()
                    };
                    api.post('r_grooms', '', s.r_grooms_mod).then(function(r){
                        s.r_grooms_mod = r.data;
                        s.r_grooms_mod.gs_array = JSON.parse(s.r_grooms_mod.gs_array);
                        rsv.afterSubmit(s, 'r_grooms', 'r_grooms_mod');
                        crud.setTableAfterSubmit(crud.tbl_arr.pets, rs.pet);
                        crud.setTableAfterSubmit(crud.tbl_arr.r_grooms, s.r_grooms_mod);
                    });
                }
            }
        }, 200);
    };

    s.checkInTraining = function() {
        $timeout(function(){
            var isCheckedin = false,
                today = rs.getCurrentDate();
            a.forEach(rs.r_training, function(item, id){
                if ((item.date_in == today || item.date_out == today) && item.in_out == 'in' &&
                        item.pet_id == rs.pet.id && item.client_id == rs.client.id) {
                    isCheckedin = true;
                    return false;
                }
            });
            rs.prd_selected = 'r_training';
            if (isCheckedin) {
                rs.alertMsg('Already checked in the pet for today, you can modify if necesary');
            } else {
                var is_set = 0;
                if (rs.isEmpty(rs.pet.records_training)) {
                    rs.alertMsg('First set training records for pet');
                    $('#recordsTrainingModal').foundation('reveal', 'open');
                } else {
                    is_set = 1;
                    var t_id = rs.pet.records_training.trainer_id,
                        instructions = rs.pet.records_training.trainer_notepad;
                }
                if (is_set) {
                    s.r_training_mod = {
                        client_id: rs.client.id,
                        pet_id: rs.pet.id,
                        t_id: t_id,
                        instructions: instructions,
                        in_out: 'in',
                        date_in: rs.getCurrentDate(),
                        time_in: rs.getCurrentTime(),
                        date_out: rs.getCurrentDate(),
                        time_out: rs.getCurrentTime()
                    };
                    api.post('r_training', '', s.r_training_mod).then(function(r){
                        s.r_training_mod = r.data;
                        rsv.afterSubmit(s, 'r_training', 'r_training_mod');
                        crud.setTableAfterSubmit(crud.tbl_arr.pets, rs.pet);
                        crud.setTableAfterSubmit(crud.tbl_arr.r_training, s.r_training_mod);
                    });
                }
            }
        }, 200);
    };


};