/**
 * Models service
 * @param api
 * @param rs
 * @param $q
 */
var modelsService = function(api, $q) {

    /**
     *  get models **
     * @param tables_arr
     * @param id
     * @param method
     * @param extra_json
     */
    this.getModels = function(tables_arr, id, method, extra_json)
    {
        var self = this,
            deffered = $q.defer();
            rs.is_models = true;
        var tables = '';
        for (var i in tables_arr) {
            var table = tables_arr[i];
            tables += table+',';
        }
        tables = tables.substring(0, tables.length - 1);
        if (tables) {
            api.get(tables, id, method, extra_json).then(function(r){
                for (var i in tables_arr) {
                    var table = tables_arr[i],
                        data = (r.multiple) ? r.multiple[table].data : r.data;

                    /** set values **/
                    data = self.makeIntegerFloatValue(table, data);
                    rs[table] = data;
                }
                deffered.resolve(r.multiple);
            });
        }
        return deffered.promise;
    };

    /**
     *
     * @param table
     * @param data
     * @returns {*}
     */
    this.makeIntegerFloatValue = function(table, data) {
        var checkValues = function(value) {
            if (value == 'true') {
                return true;
            } else if (value == 'false') {
                return false;
            } else if ((value !== false && value !== true) && rs.isInteger(value, 1)) {
                return parseInt(value);
            } else if ((value !== false && value !== true) && rs.isFloat(value, 1)) {
                return parseFloat(value);
            } else {
                return value;
            }
        };
        if (table.indexOf('settings') != '-1') {
            a.forEach(data, function(v, n){
                data[n] = checkValues(v);
            });
        } else {
            a.forEach(data, function(item, id){
                if (item.id) {
                    item.id = parseInt(item.id);
                }
                a.forEach(item, function(column, key){
                    item[key] = checkValues(column);
                });
            });
        }
        return data;
    }

};