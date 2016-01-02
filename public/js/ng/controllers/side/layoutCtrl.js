/**
 * Layout ctrl
 * @param $scope
 * @param api
 * @param $timeout
 * @param crud
 * @param calc
 * @param cFunc
 * @param webStorage
 * @param dt
 */
var layoutCtrl = function($scope, api, $timeout, crud, calc, cFunc, webStorage, dt) {
    var s = $scope;
    s.days_nr_pets = {};
    s.lr_selected = {};
    s.l_fi = {
        date: rs.getCurrentDate(),
        section_id: null,
        charge_type: null,
        charge_type_id: null,
        run_number: null,
        nr_dates: 7
    };
    rs.initLayout = function(){

    };
    s.setLr = function(lr) {
        s.lr_selected = lr;
    };
    s.getDaysNrPets = function() {
        return dt.getLastDatesBeforeNrDays(s.l_fi.date, s.l_fi.nr_dates);
    };
    s.$watch('l_fi.date', function(new_value, old_value){
        s.days_nr_pets = s.getDaysNrPets();
    });
    s.$watch('l_fi.nr_dates', function(new_value, old_value){
        s.days_nr_pets = s.getDaysNrPets();
    });
};