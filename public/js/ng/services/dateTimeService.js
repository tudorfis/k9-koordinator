
/**
 * date service
 */
var dateTimeService = function(cFunc) {

    var self = this;


    /** get last dates before a number of days **/
    this.getLastDatesBeforeNrDays = function (date, nr_days) {

        if (date) {
            date_obj = new Date(date);
        } else {
            date_obj = new Date();
        }
        var result_arr = [],
            a_day_back = date_obj;

        for (i=0; i <= nr_days; i++) {
            var day_obj = {
                text: a_day_back.toString().substring(0, 3)+' '+(a_day_back.getMonth()+1)+'/'+a_day_back.getDate(),
                date: rs.getCurrentDate(a_day_back),
                time: a_day_back.getTime(),
                date_obj: a_day_back
            };
            a_day_back.setDate(a_day_back.getDate()-1);
            result_arr.push(day_obj);
        }
        result_arr.sort();

        return result_arr;

    }

};
