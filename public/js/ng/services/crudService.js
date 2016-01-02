
/**
 * Common functions service
 */
var crudService = function(webStorage, api, cFunc, access, models, $q) {

    var self = this;
    this.tbl_arr = {};

    this.returnModelsStandard = function(tbl){
        return [{tbl: tbl,    t: 'rs', with_id: 1}]
    };

    this.models_tbl_arr = general_tables_arr;

    a.forEach(this.models_tbl_arr, function(table){
        self.tbl_arr[table] = self.returnModelsStandard(table);
    });

    /**
     * set the table after the submit
     * @param tables_arr
     * @param mod
     * @param json_extra
     * @param with_req
     * @param table
     */
    this.setTableAfterSubmit = function(tables_arr, mod, json_extra, with_req, table) {
        var deffered = $q.defer();
        if (with_req) {
            api.get(table, mod.id, '').then(function(r){
                deffered.resolve(r);
                mod = self.doSetModTableAfterSubmit(mod, r.data[0], json_extra);
                self.doSetTableAfterSubmit(tables_arr, mod);
            });
        } else {
            mod = self.doSetModTableAfterSubmit(mod, mod, json_extra);
            self.doSetTableAfterSubmit(tables_arr, mod);
        }
        return deffered.promise;
    };

    /**
     * Set modified json
     * @param mod
     * @param new_mod
     * @param json_extra
     * @returns {{}}
     */
    this.doSetModTableAfterSubmit = function(mod, new_mod, json_extra) {
        if (json_extra && !cFunc.isEmpty(json_extra)) {
            mod = a.extend(new_mod, json_extra);
        } else {
            mod = new_mod;
        }
        //mod = self.makePostValuesTrueFalse(mod);
        return mod;
    };

    this.doSetTableAfterSubmit = function(tables_arr, mod){
        a.forEach(tables_arr, function(scope_tbl){
            var scope_table = null;
            switch (scope_tbl.t) {
                case 'rs':
                    scope_table = rs[scope_tbl.tbl];
                    break;
                case 'ws':
                    scope_table = webStorage.local.get(scope_tbl.tbl);
                    break;
                default:
                    var o_scope = $(scope_tbl.t).scope();
                    scope_table = (o_scope) ? o_scope[scope_tbl.tbl] : null;
            }
            if (scope_table) {
                mod = models.makeIntegerFloatValue(scope_tbl.t, [mod])[0];
                if (scope_tbl.with_id) {
                    scope_table = rs.isArray(scope_table) ? {} : scope_table;
                    var elem = {};
                    elem[mod.id] = mod;
                    a.extend(scope_table, elem);
                } else {
                    var modified = false;
                    a.forEach(scope_table, function(item,item_id){
                        if (item.id == mod.id) {
                            scope_table[item_id] = mod;
                            modified = true;
                            return false;
                        }
                    });
                    if (!modified) {
                        scope_table.unshift(mod);
                    }
                }
                if (scope_tbl.t == 'ws') {
                    webStorage.local.remove(scope_tbl.tbl);
                    webStorage.local.add(scope_tbl.tbl, scope_table);
                } else if (scope_tbl.t == 'rs') {
                    rs[scope_tbl.tbl] = scope_table;
                }
            }
        });
    };

    /**
     * delete item
     * @param tables_arr
     * @param table
     * @param id
     * @param without_req
     * @param method
     */
    this.deleteItem = function(tables_arr, table, id, without_req, method) {
        var deffered = $q.defer();
        if (without_req) {
            self.doDeleteItem(tables_arr, id);
        } else {
            api.delete(table, id, {}, method).then(function(r){
                deffered.resolve(r);
                self.doDeleteItem(tables_arr, id);
            });
        }
        return deffered.promise;
    };

    this.doDeleteItem = function(tables_arr, id) {
        a.forEach(tables_arr, function(scope_tbl){
            var scope_table = null;
            switch (scope_tbl.t) {
                case 'rs':
                    scope_table = rs[scope_tbl.tbl];
                    break;
                case 'ws':
                    scope_table = webStorage.local.get(scope_tbl.tbl);
                    break;
                default:
                    var o_scope = $(scope_tbl.t).scope();
                    scope_table = o_scope[scope_tbl.tbl];
                    break;
            }
            if (scope_table) {
                a.forEach(scope_table, function(item,k){
                    if (item.id == id) {
                        if (scope_tbl.with_id) {
                            delete scope_table[id];
                        }
                        else {
                            scope_table.splice(k, 1);
                        }
                        return false;
                    }
                });
                if (scope_tbl.t == 'ws') {
                    webStorage.local.remove(scope_tbl.tbl);
                    webStorage.local.add(scope_tbl.tbl, scope_table);
                }
            }
        });
    };

};