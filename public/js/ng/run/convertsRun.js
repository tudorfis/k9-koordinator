/**
 * Convert stuff
 * @param $filter
 */
var convertsRun = function($filter) {

    /** convert us number **/
    rs.convertTelNumber = function(scope_id, t, n, t_id) {
        var scope = $(scope_id).scope(),
            val = scope[t][n],
            p_id = rs.user_interface_settings[t_id];

        var part1 = '',
            part2 = '',
            part3 = '';
        if (p_id == 1) {
            if (val && val.match(/[0-9]{10}/g) && val.length == 10) {
                part1 = val.substring(0,3);
                part2 = val.substring(3,6);
                part3 = val.substring(6,10);
                scope[t][n] = '('+part1+') '+part2+'-'+part3;
            }
        } else if (p_id == 2) {
            if (val && val.match(/07[0-9]{8}/g) && val.length == 10) {
                part1 = val.substring(0,4);
                part2 = val.substring(4,10);
                scope[t][n] = part1+' '+part2;
            }
        }
    };
    rs.getTelErrorText = function(n) {
        var fid = {};
        if (rs.user_interface_settings) {
            if (rs.user_interface_settings[n]) {
                if (rs.tel_formats) {
                    if (rs.tel_formats[rs.user_interface_settings[n]]) {
                        return (rs.tel_formats[rs.user_interface_settings[n]].error_text || '');
                    }
                }
            }
        }
        return '';
    };

    /** convert to uppercase **/
    rs.convertToUpperCase = function(scope_id, t, n) {
        var scope = $(scope_id).scope(),
            val = scope[t][n];
        if (val) {
            scope[t][n] = val.toUpperCase();
        }
    };

    /** convert to maxlength **/
    rs.convertToMaxlength = function(scope_id, t, n, maxlength) {
        var scope = $(scope_id).scope(),
            val = scope[t][n];
        if (val) {
            scope[t][n] = val.substring(0, maxlength);
        }
    };

    /** focus on id **/
    rs.focusOnId = function(id) {
        $('#'+id).focus();
    };

    /** get current date **/
    rs.getCurrentDate = function(date) {
        var today = {};
        if (date) {
            today = date;
        } else {
            today = new Date();
        }
        var dd = today.getDate(),
            mm = today.getMonth()+ 1,
            yyyy = today.getFullYear();
        if (dd<10) dd='0'+dd;
        if (mm<10) mm='0'+mm;
        today = yyyy+'-'+mm+'-'+dd;
        return today;
    };

    rs.getYear = function() {
        var date = new Date();
        return date.getFullYear();
    };

    /** get current time **/
    rs.getCurrentTime = function() {
        var today = new Date(),
            hh = today.getHours(),
            mm = today.getMinutes(),
            ss = today.getSeconds();
        if (parseInt(mm) <= 9) mm = '0'+mm;
        if (parseInt(ss) <= 9) ss = '0'+ss;
        return hh+':'+mm+':'+ss;
    };

    /** get current date / time **/
    rs.getCDT = function() {
        return rs.getCurrentDate()+' '+rs.getCurrentTime();
    };

    /** get time of date **/
    rs.getTime = function(date) {
        return new Date(date).getTime();
    };

    /** check if array **/
    rs.isArray = function(item) {
        return (Object.prototype.toString.call(item) == '[object Array]');
    };

    /** check if object **/
    rs.isObject = function(item) {
        return (Object.prototype.toString.call(item) == '[object Object]');
    };

    /** check if empty **/
    rs.isEmpty = function(item) {
        for(var prop in item) {
            if(item.hasOwnProperty(prop))
                return false;
        }
        return true;
    };

    /** is float **/
    rs.isFloat = function(n, is_string) {
        if (is_string) {
            return (!isNaN(n) && n !== null && n !== '' && n.toString().indexOf('.') != -1);
        } else {
            return n === +n && n !== (n|0);
        }
    };

    /** is integer **/
    rs.isInteger = function(n, is_string) {
        if (is_string) {
            return (!isNaN(n) && n !== null && n !== '' && n.toString().indexOf('.') == -1);
        } else {
            return n === +n && n === (n|0);
        }
    };

    /** is numeric **/
    rs.isNumberic = function(n) {
        if (rs.isInteger(n) || rs.isFloat(n)) {
            return true;
        };
        return false
    };

    /** return number times **/
    rs.rnt = function(nr) {
        var array_o = {};
        for ($i = 1; $i <= nr; $i++) {
            array_o[$i] = {
                id: $i,
                v: $i
            };
        }
        return array_o;
    };

    /** return number array **/
    rs.rna = function(nr, from) {
        var array = [];
        for ($i = (from || 1); $i <= nr; $i++) {
            array.push($i);
        }
        return array;
    };

    /** order by keys **/
    rs.orderByKeys = function(obj, type) {
        var return_obj = {},
            keys = Object.keys(obj),
            i, len = keys.length;
        if (type == 'reverse') {
            keys.reverse();
        } else {
            keys.sort();
        }
        for (i = 0; i < len; i++) {
            k = keys[i];
            return_obj[k] = obj[k];
        }
        return return_obj;
    };

    /** check list of array, if all have a value then don't show **/
    rs.checkArr = function(in_object, id_array, key, check_value) {
        var result = false;
        a.forEach(id_array, function(id){
            if (in_object[id][key] != check_value) {
                result = true;
                return false;
            }
        });
        return result;
    };

    /** make watch collections **/
    rs.makeWatchTables = function(obj_in) {
        if (!rs.isEmpty(obj_in)) {
            var watch_collection = '[';
            a.forEach(obj_in, function(item){
                watch_collection += item+', ';
            });
            watch_collection = watch_collection.substring(0, watch_collection.length - 2);
            watch_collection += ']';
            return watch_collection;
        } else {
            return '';
        }
    };

    /** refresh current page **/
    rs.refreshPage = function() {
        location.reload();
    };

    /** to array **/
    rs.ma = function(in_obj) {
        if (rs.isObject(in_obj)) {
            return $filter('array')(in_obj);
        } else if (in_obj) {
            return in_obj;
        } else {
            return [];
        }
    };

    rs.lastEl = function(in_obj) {
        if (in_obj) {
            if (rs.isObject(in_obj)) {
                in_obj = $filter('array')(in_obj);
            }
            return in_obj[in_obj.length-1];
        }
    };

    rs.openTab = function(hide_tabs, open_tab, open_tab_active) {
        $(hide_tabs).find('.content').hide();
        $(hide_tabs).find('dd').removeClass('active');
        $(open_tab).fadeIn('medium');
        $(open_tab_active).addClass('active');
    };

    rs.setOneYear = function(scope, t, n) {
        oneYr = new Date();
        oneYr.setYear(oneYr.getFullYear() + 1);
        var one_year = rs.getCurrentDate(oneYr);
        if (scope && t && n) {
            scope = $(scope).scope();
            scope[t][n] = one_year;
        } else {
            return one_year;
        }
    };

    rs.unbind = function(obj) {
        return JSON.parse(JSON.stringify(obj));
    };

    rs.guid = function() {
        return 'a'+Math.floor((1 + Math.random()) * 0x10000).toString(16).substring(1);
    };

    rs.guid_long = function() {
        return 'l'+Math.random()+Math.random()+Math.random()+Math.random();
    };

    rs.uid = function() {
        function s4() {
            return Math.floor((1 + Math.random()) * 0x10000)
                .toString(16)
                .substring(1);
        }
        return s4() + s4() + '-' + s4() + '-' + s4() + '-' + s4() + '-' + s4() + s4() + s4();
    };

    rs.lowercaseUnderscore = function(value) {
        if (!value) {
            return '';
        }
        value = value.toString();
        value = value.toLowerCase();
        value = value.replace(/  /g, " ");
        value = value.replace(/ /g, "_");
        return value;
    };

    rs.getTimeTimestamp = function(value) {
        if (!value) {
            return '';
        }
        var arr = value.split(":"),
            h = arr[0],
            m = arr[1],
            s = (arr[2] || 0),
            r = (pF(h) * 60 * 60) + (pF(m) * 60) + pF(s);
        return r;
    }
};

