
/**
 * @desc: object for reusable filters
 * @auth: Todorescu Tudor
 * @date: 2014-06-20
 * @type {ngKm|*|{}}
 */
var commonFilters = commonFilters || {};
commonFilters.Bootstrap = {};

/**
 * Array
 * @returns {Function}
 * @constructor
 */
commonFilters.Bootstrap.Array = function(){
    return function(items) {
        var filtered = [];
        a.forEach(items, function(item, item_id) {
            filtered.push(item);
        });
        return filtered;
    };
};

/**
 * Example filter
 * @returns {Function}
 * @constructor
 * @usage:
 *  <a href="{{item | mongolink:'name'}}">{{item.name}}</a>
    <a href="{{item | mongolink:'id'}}">{{item.name}}</a>
 */
commonFilters.Bootstrap.MongoLink = function() {
    return function(item, arg) {
        var currentLocation = location.href;
        if (currentLocation[currentLocation.length-1] !== "/") currentLocation += "/";
        return currentLocation + item[arg];
    }
};

/**
 * Get remote resource
 * @param config
 * @returns {Function}
 * @constructor
 */
commonFilters.Bootstrap.L = function(config) {
    return function(input) {
        if (input === undefined || input === null || input === '') {
            return '';
        }
        return config.api_r + ((input.charAt(0) == '/') ? input : '/'+input);
    }
};

/**
 * Get local resource
 * @param config
 * @returns {Function}
 * @constructor
 */
commonFilters.Bootstrap.BaseUrl = function(config) {
    return function(input) {
        if (input === undefined || input === null || input === '') {
            return '';
        }
        return config.api_l + ((input.charAt(0) == '/') ? input : '/'+input);
    }
};

/**
 * Convert date of birth to string, nr of days, months
 * @returns {Function}
 * @constructor
 */
commonFilters.Bootstrap.DobString = function() {
    return function(date, extra_str) {

        if (date !== undefined) {
            var str = '';

            if (date.match(/[0-9]{1,2}\/[0-9]{1,2}\/[0-9]{4}/)) {

                var today = new Date(),
                    newDate = new Date(date),
                    d_timestamp = newDate.getTime(),
                    t_timestamp = today.getTime(),
                    timestamp = t_timestamp - d_timestamp,

                    days = pI(timestamp / 86400000),
                    months = pI(timestamp / 2592000000),
                    years = 0;

                if (months > 12) {
                    years = pI(months / 12);
                }
                months = pI(months - 12*years);
                if (years == 0) {
                    str = '';
                } else {
                    if (years != 0) {
                        if (years == 1) {
                            str = years+' yr, ';
                        } else {
                            str = years+' yrs, ';
                        }
                    }
                }
                if (years == 0 && months == 0) {
                    str += days+' days old';
                } else if (months == 0) {
                    str += 'old';
                } else {
                    if (months == 1) {
                        str += ' '+months+' mon. old';
                    } else {
                        str += ' '+months+' mon. old';
                    }
                }
            }

            if (extra_str !== undefined && str != '') {
                str = extra_str+' '+str;
            }
            return str;
        }
        return '';

    }
};

commonFilters.Bootstrap.DobStringYear = function(access) {
    return function(date, extra_str) {
        if (date && date.match(/[0-9]{1,2}\/[0-9]{1,2}\/[0-9]{4}/)) {
            var today = new Date(),
                newDate = new Date(date),
                d_timestamp = newDate.getTime(),
                t_timestamp = today.getTime(),
                timestamp = t_timestamp - d_timestamp,

                days = pI(timestamp / 86400000),
                months = pI(timestamp / 2592000000),
                years = 0;

            if (months > 12) {
                years = pI(months / 12);
            }

            if (pI(years) > 0 && years >= pI(access.alarmPetAgeValue())) {
                return true
            }
        }
        return false;
    }
};

/**
 * get current date
 * @returns {Function}
 */
commonFilters.Bootstrap.GetDate = function() {
    return function(input) {
        var d = new Date();
        return d.getFullYear()+'-'+(d.getMonth()+1)+'-'+d.getDate();
    }
};

/**
 * get current time
 * @returns {Function}
 */
commonFilters.Bootstrap.GetTime = function() {
    return function(input) {
        var d = new Date();
        return d.getHours()+':'+d.getMinutes()+':'+d.getSeconds();
    }
};

/**
 * get current date tiem
 * @returns {Function}
 */
commonFilters.Bootstrap.GetDateTime = function() {
    return function(input) {
       return commonFilters.Bootstrap.getDate()+' '+commonFilters.Bootstrap.getTime();
    }
};


/**
 * filter exclude object ids
 * @returns {Function}
 */
commonFilters.Bootstrap.FilterExcludeObjIds = function(){
    return function (inputArray, excludedObjectIds) {
        var filteredArray = [];
        a.forEach(excludedObjectIds, function(ids, input_id){
            a.forEach(inputArray, function(item){
                if (ids.indexOf(item[input_id]) != -1) {
                    if (filteredArray.indexOf(item) == -1) {
                        filteredArray.push(item);
                    }
                }
            });
        });
        return (filteredArray.length > 0) ? filteredArray : inputArray;
    }
};

/**
 * filter relationship
 * @returns {Function}
 */
//filterRelationship:{table:'retail_rvi', cn_id:'retail_vendor_id', ev_id:vendor_id, an_id:'retail_inventory_id', at: 'retail_inventory'}
commonFilters.Bootstrap.FilterRelationship = function(){
    return function (inputArray, st) {
        var filteredArray = [];
        if (inputArray.length > 0) {
            a.forEach(rs[st.table], function(item, id){
                if (item[st.cn_id] == rs[st.ev_id]) {
                    filteredArray.push(rs[st.at][item[st.an_id]]);
                }
            });
        }
        return (filteredArray.length > 0) ? filteredArray : inputArray;
    }
};



/**
 * Slice array
 * @returns {Function}
 * @constructor
 */
commonFilters.Bootstrap.Slice = function(){
    return function(arr, start, end) {
        return (arr || []).slice(start, end);
    };
};

/**
 * isEmpty
 * @returns {Function}
 * @constructor
 */
commonFilters.Bootstrap.IsEmpty = function(){
    var bar;
    return function (obj) {
        for (bar in obj) {
            if (obj.hasOwnProperty(bar)) {
                return false;
            }
        }
        return true;
    };
};

/**
 * last element
 * @returns {Function}
 * @constructor
 */
commonFilters.Bootstrap.LastEl = function($filter){
    return function (array) {
        if (array.length != 0) {
            return array[array.length-1];
        } else {
            return null;
        }
    };
};

/**
 * capitalize
 * @returns {Function}
 * @constructor
 */
commonFilters.Bootstrap.Capitalize = function() {
    return function(input, all) {
        return (!!input) ? input.replace(/([^\W_]+[^\s-]*) */g, function(txt){
            if (txt && txt.charAt(0)) {
                return txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase();
            }
            return '';
        }) : '';
    }
};

/**
 * html escape
 * @returns {Function}
 * @constructor
 */
commonFilters.Bootstrap.HtmlEscape = function() {
    return function(input) {
        if (!input) { return ''; }
        input = input.toString();
        return input.
            replace(/&/g, '&amp;').
            replace(/</g, '&lt;').
            replace(/>/g, '&gt;').
            replace(/'/g, '&#39;').
            replace(/"/g, '&quot;');
    };
};

/**
 * text to html
 * @param $sce
 * @param htmlEscapeFilter
 * @returns {Function}
 * @constructor
 */
commonFilters.Bootstrap.TextToHtml = function($sce, htmlEscapeFilter) {
    return function(input) {
        if (!input) { return '';}
        input = input.toString();
        input = htmlEscapeFilter(input);
        var output = '';
        $.each(input.split("\n\n"), function(key, paragraph) {
            output += '<p>' + paragraph + '</p>';
        });
        return $sce.trustAsHtml(output);
    };
};