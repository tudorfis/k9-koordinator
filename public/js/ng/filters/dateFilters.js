
/**
 * @desc: object for reusable date filters
 * @auth: Todorescu Tudor
 * @date: 2014-12-20
 * @type {ngKm|*|{}}
 */
var dateFilters = dateFilters || {};
dateFilters.Bootstrap = {};

/**
 * Filter dates, must set target-date on data
 * @returns {Function}
 * @constructor
 */
dateFilters.Bootstrap.FilterDates = function(){
    return function(array, data) {

        var new_array = {},
            item = {},
            date = '',
            date_in = ((data && data.date_in) ? (new Date(data.date_in).getTime()/1000) : ''),
            date_out = ((data && data.date_out) ? (new Date(data.date_out).getTime()/1000) : '');

        var hasId = function(new_array, item) {
            if (item.id) {
                new_array[item.id] = item;
            } else {
                if (a.isObject(new_array)) {
                    new_array = [];
                }
                new_array.push(item);
            }
        };

        var checkDates = function(date, date_in, date_out, item) {
            if (date && !isNaN(date)) {
                if (date_in && date_out) {
                    if ((date_in == date) && (date == date_out)) {
                        hasId(new_array, item);
                    } else if ((date_in <= date) && (date <= date_out)) {
                        hasId(new_array, item);
                    }
                } else if (date_in) {
                    if (date_in <= date) {
                        hasId(new_array, item);
                    }
                } else if (date_out) {
                    if (date <= date_out) {
                        hasId(new_array, item);
                    }
                }
            }
        };

        if (date_in || date_out) {
            a.forEach(array, function(item){
                if (rs.isArray(data.target_date)) {
                    a.forEach(data.target_date, function(t_date){
                        if (item[t_date]) {
                            var date = new Date(item[t_date].substring(0,10)).getTime()/1000;
                            checkDates(date, date_in, date_out, item);
                        }
                    })
                } else {
                    if (item[data.target_date]) {
                        var date = new Date(item[data.target_date].substring(0,10)).getTime()/1000;
                        checkDates(date, date_in, date_out, item);
                    }
                }
            });
            return new_array;
        }
        return array;
    }
};