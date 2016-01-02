/**
 *
 * @param $scope
 * @param crud
 * @param $timeout
 * @param cp
 * @param rsv
 */
var rTrainingCtrl = function($scope, api, cFunc, crud, $timeout, cp, rsv) {

    var s = $scope;

    s.o = {};
    rs.partial_show = 0;
    s.r_training_mod = {};
    s.d_dates = {
        target_date: ['date_in', 'date_out', 'date_checkout']
    };

    s.getMod = function(r_training, type) {
        rs.section = 'check_in_out';
        rs.partial_show = (r_training.in_out == 'out' ? 1 : 0);
        s.r_training_mod = a.extend(r_training, {
            in_out: (r_training.in_out || 'in'),
            pet_id: rs.pet.id,
            client_id: rs.client.id
        });
        if (type == 'new') {
            s.r_training_mod = a.extend(s.r_training_mod, {
                date_in: rs.getCurrentDate(),
                time_in: rs.getCurrentTime(),
                date_out: rs.getCurrentDate()
            });
            if (rs.pet.records_training) {
                var pt = rs.pet.records_training;
                s.r_training_mod = a.extend(s.r_training_mod, {
                    t_id: pt.trainer_id,
                    instructions: pt.trainer_notepad
                });
            }
            rs.setRo(s, 'r_training', null);
        } else {
            rs.setRo(s, 'r_training', r_training.id);
        }
    };

    rs.post.r_training_mod = {
        beforeSubmit: function() {
            rs.post.r_training_mod.break_submit = 0;
            if (!s.r_training_mod.id) {
                rs.checkDatesExists(s, 'r_training', 'r_training_mod', 'date_in', 'date_out', rs.post.r_training_mod);
                rs.checkDatesBigger(s, 'r_training_mod', 'date_in', 'date_out', rs.post.r_training_mod);
                rs.checkDatesToday(s, 'r_training_mod', 'date_in', rs.post.r_training_mod);
                rs.setRo(s, 'r_training', null);
            } else {
                rs.setRo(s, 'r_training', s.r_training_mod.id);
            }
            if (!rs.post.r_training_mod.break_submit) {
                if (!s.r_training_mod.ts_id || !s.r_training_mod.tg_id || !s.r_training_mod.t_id) {
                    rs.alertMsg("Please select a training schedule !");
                    rs.post.r_training_mod.break_submit = 1;
                }
            }
        },
        afterSubmit: function(){
            rsv.afterSubmit(s, 'r_training', 'r_training_mod');
            var rb = s.r_training_mod;
            if (!rs.pet.records_training) {
                var records_data = {
                    client_id: rb.client_id,
                    pet_id: rb.pet_id,
                    trainer_id: rb.t_id,
                    trainer_notepad: rb.instructions
                };
                api.post('records_training', '', records_data).then(function(r){
                    crud.setTableAfterSubmit(crud.tbl_arr.records_training, r.data);
                    rs.pet.records_training = r.data;
                });
            }
        }
    };

    s.delete = function (id) {
        rs.confirmMsg('Are you sure you want to delete this training ?', function(){
            rsv.afterDelete(id, 'r_training', 'r_training_mod');
        });
    };

    rs.post.training_payments = {
        beforeSubmit: function() {
            var training_report = rs.rsvReport(s.o, rs.r_training[s.r_training_mod.id], s.r_training_mod.id, 'r_training', 1),
                required = training_report.total,
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
                r_training_id: s.r_training_mod.id,
                payment_status_id: ((required - paid) > 0 ? 2 : 1),
                required: required,
                paid: paid,
                change: change,
                unpaid: unpaid,
                information: JSON.stringify(s.r_training_mod),
                date_created: (s.o.date_created || rs.getCDT()),
                date_modified: rs.getCDT(),
                created_user_id: (s.o.created_user_id || rs.identity.id),
                modified_user_id: rs.identity.id
            });
        },
        afterSubmit: function() {
            rs.r_training[s.o.r_training_id].o = s.o;
            crud.setTableAfterSubmit(crud.tbl_arr.training_payments, s.o);
            crud.setTableAfterSubmit(crud.tbl_arr.r_training, rs.r_training[s.o.r_training_id]);
            cp.buildClientsTrainingBills();
        }
    };


    s.r_training_mod = {
        ts_id: 0,
        tg_id: 0,
        t_id: 0
    };
    s.training_filter = {
        date: rs.getCurrentDate(),
        date_filter: 'from_date'
    };

    s.selectTs = function (ts) {
        s.r_training_mod = a.extend(s.r_training_mod, {
            ts_id: ts.id,
            tg_id: ts.tg_id,
            t_id: ts.t_id,
            time_in: ts.time_in,
            time_out: ts.time_out
        });
    }

};

var filterTraining = function(){
    return function(trainingSchedule, trainingFilter) {
        var filteredTs = [],
            date_timestamp = new Date(trainingFilter.date).getTime()/1000;
        if (!trainingFilter.show_all) {
            a.forEach(trainingSchedule, function(ts){
                if (ts.date_in){
                    var date_in_timestamp = new Date(ts.date_in).getTime()/1000,
                        date_out_timestamp = new Date(ts.date_out).getTime()/1000;
                    if (date_in_timestamp <= date_timestamp && date_timestamp <= date_out_timestamp) {
                        filteredTs.push(ts);
                    }
                }
            });
            return filteredTs;
        } else {
            return trainingSchedule;
        }
    };
};

