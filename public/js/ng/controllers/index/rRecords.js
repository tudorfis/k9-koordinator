/**
 *
 * @param $scope
 * @param api
 * @param crud
 * @param $timeout
 */
var rRecordsCtrl = function($scope, api, crud, $timeout) {

    //[^rgde]s[\.\[]

    var s = $scope;

    /** RECORDS **/
    /** ##################################### **/
    rs.getRecords = function(table, target, modal) {
        rs[target] = (rs.pet[table] || {});
        $(modal).foundation('reveal', 'open');
    };

    /**
     * RECORDS BOARDING / DAYCARE
     * ###############################################################################################
     */
    rs.post.records_boarding_mod = {
        beforeSubmit: function(){
            console.log(rs.records_boarding_mod);
            rs.records_boarding_mod = a.extend(rs.records_boarding_mod, {
                client_id: rs.client.id,
                pet_id: rs.pet.id,
                charge_type: rs.boarding_settings.charge_type
            });
        },
        afterSubmit: function() {
            rs.pet.records_boarding = rs.records_boarding_mod;
            crud.setTableAfterSubmit(crud.tbl_arr.pets, rs.pet);
        }
    };
    rs.post.records_daycare_mod = {
        beforeSubmit: function() {
            rs.records_boarding_mod = a.extend(rs.records_boarding_mod, {
                client_id: rs.client.id,
                pet_id: rs.pet.id
            });
        },
        afterSubmit: function() {
            rs.pet.records_daycare = rs.records_daycare_mod;
            crud.setTableAfterSubmit(crud.tbl_arr.pets, rs.pet);
        }
    };

    /**
     * RECORDS GROOMING
     * ###############################################################################################
     */
    rs.getRecordsGrooming = function() {
        rs.current_rg = (rs.pet.records_grooming || {});
        $('#recordsGroomingModal').foundation('reveal', 'open');
    };
    rs.post.current_rg = {
        beforeSubmit: function() {
            rs.post.current_rg.break_submit = 0;
            rs.current_rg = a.extend(rs.current_rg, {
                client_id: rs.client.id,
                pet_id: rs.pet.id,
                gs_ids: JSON.stringify(rs.current_rg.gs_ids)
            });
        },
        afterSubmit: function() {
            rs.current_rg.gs_ids = (rs.current_rg.gs_ids ? JSON.parse(rs.current_rg.gs_ids) : []);
            rs.pet.records_grooming = rs.current_rg;
            crud.setTableAfterSubmit(crud.tbl_arr.pets, rs.pet);
        }
    };
    rs.addGs = function() {
        if (!rs.gs_id) {
            rs.alertMsg("Please select a reccurring service");
        } else {
            rs.current_rg.gs_ids = (rs.current_rg.gs_ids || []);
            if (rs.current_rg.gs_ids.indexOf((rs.gs_id).toString()) != -1) {
                rs.alertMsg("This service is already added !")
            } else {
                rs.current_rg.gs_ids.push(rs.gs_id);
            }
        }
    };
    rs.deleteGs = function(id) {
        rs.confirmMsg("Are you sure you want to delete this service ?", function(){
            rs.current_rg.gs_ids.splice(rs.current_rg.gs_ids.indexOf(id), 1);
        });
    };

    /**
     * RECORDS MEDS / DIETS
     * ###############################################################################################
     */
    rs.getRecordsMedsDiets = function(type) {
        rs.r_m_mod = {
            md_id: null,
            type: type
        };
        rs.r_d_mod = {
            md_id: null,
            type: type
        };
        $('#recordsMedsDietsModal').foundation('reveal', 'open');
    };
    rs.deleteMd = function(table, id) {
        rs.confirmMsg('Are you sure you want to delete ?', function(){
            crud.deleteItem(crud.tbl_arr[table], table, id)
        })
    };
    rs.deleteMdRecords = function(table, id) {
        rs.confirmMsg('Are you sure you want to delete this record ?', function(){
            crud.deleteItem(crud.tbl_arr.records_meds_diets, 'records_meds_diets', id).then(function (r) {
                delete rs.pet['records_'+table][id];
            });
        });
    };
    rs.refreshMd = function(type) {
        rs.search_md = '';
        rs.r_m_mod = {
            md_id: null,
            type: type
        };
        rs.r_d_mod = {
            md_id: null,
            type: type
        };

    };

    rs.not_add = 1;
    rs.md_med_mod = {};
    rs.md_diet_mod = {};
    rs.post.md_med_mod = {
        afterSubmit: function() {
            $timeout(function(){
                rs.md_med_mod = {};
            }, 100);

        }
    };
    rs.post.md_diet_mod = {
        afterSubmit: function() {
            $timeout(function(){
                rs.md_diet_mod = {};
            }, 100);

        }
    };
    rs.post.r_m_mod = {
        beforeSubmit: function(){
            rs.post.r_m_mod.break_submit = 1;
            if (!rs.r_m_mod.md_id) {
                rs.alertMsg('Please select medication');
            } else {
                rs.addMd('meds');
            }
        }
    };
    rs.post.r_d_mod = {
        beforeSubmit: function(){
            rs.post.r_d_mod.break_submit = 1;
            if (!rs.r_d_mod.md_id) {
                rs.alertMsg('Please select diet');
            } else {
                rs.addMd('diets');
            }
        }
    };

    rs.addMd = function(table) {
        rs.hs('.submit', '.al');
        var t = (table == 'meds' ? 'r_m_mod' : 'r_d_mod');
        var data = a.extend(rs[t], {
            client_id: rs.client.id,
            pet_id: rs.pet.id
        });
        api.post('records_meds_diets', '', data).then(function(r){
            crud.setTableAfterSubmit(crud.tbl_arr.records_meds_diets, r.data);
            rs[t].id = r.data.id;
            var type = rs[t].type,
                md_id = rs[t].md_id;
            if (rs[t].type == 1) {
                rs.pet.records_meds = (rs.pet.records_meds || {});
                rs.pet.records_meds[rs[t].id] = rs[t];
            } else if (rs[t].type == 2) {
                rs.pet.records_diets = (rs.pet.records_diets || {});
                rs.pet.records_diets[rs[t].id] = rs[t];
            }
            crud.setTableAfterSubmit(crud.tbl_arr.pets, rs.pet);
            $timeout(function(){
                rs[t] = {
                    type: type,
                    md_id: null
                };
            }, 100);
            rs.sh('.submit', '.al');
        });
    };

    /**
     * RECORDS SERVICES
     * ###############################################################################################
     */
    rs.setRs = function(record_service) {
        rs.current_rs = record_service;
    };
    rs.getRecordsServices = function() {
        rs.current_rs = (rs.pet.records_services || {});
        $('#recordsServicesModal').foundation('reveal', 'open');
    };
    rs.addRs = function() {
        if (!rs.ss_id) {
            rs.alertMsg('Please select a service then click add');
        } else {
            var valid = 1;
            a.forEach(rs.pet.records_services, function(item){
                if (item.ss_id == rs.ss_id) {
                    rs.alertMsg("Please select different service, or delete existent");
                    valid = 0;
                    return false;
                }
            });
            if (valid) {
                rs.hs('.btn_rs', '.al_rs');
                var data = a.extend(rs.current_rs, {
                    client_id: rs.client.id,
                    pet_id: rs.pet.id,
                    ss_id: rs.ss_id,
                    no_charges: 1,
                    schedule: 'schedule_always'
                });
                api.post('records_services', data.id, data).then(function (r) {
                    rs.current_rs = r.data;
                    crud.setTableAfterSubmit(crud.tbl_arr.records_services, r.data);
                    rs.pet.records_services = (rs.pet.records_services || {});
                    rs.pet.records_services[r.data.id] = r.data;
                    crud.setTableAfterSubmit(crud.tbl_arr.pets, rs.pet);
                    rs.sh('.btn_rs', '.al_rs');
                });
            }
        }
    };
    rs.deleteRs = function(id) {
        rs.confirmMsg('Are you sure you want to delete this service ?', function(){
            crud.deleteItem(crud.tbl_arr.records_services, 'records_services', id).then(function(r){
                delete rs.pet.records_services[id];
                rs.setRs({});
            });
        });
    };

    /**
     * RECORDS TRAINING
     * ###############################################################################################
     */
    rs.getRecordsTraining = function() {
        rs.current_rt = (rs.pet.records_training || {});
        $('#recordsTrainingModal').foundation('reveal', 'open');
    };
    rs.post.current_rt = {
        beforeSubmit: function(){
            rs.current_rt.client_id = rs.client.id;
            rs.current_rt.pet_id = rs.pet.id;
        }
    };

};