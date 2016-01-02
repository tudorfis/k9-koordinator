
/**
 * reservation service
 */
var rsvService = function(crud, cp) {

    var self = this;

    this.doAll = function() {
        self.buildRGrooms();
    };

    this.buildRGrooms = function() {
        a.forEach(rs.r_grooms, function(item){
            rs.r_grooms[item.id].gs_array = JSON.parse(rs.r_grooms[item.id].gs_array);
        });
    };

    /** set rsv after submit **/
    this.afterSubmit = function(s, tbl, t) {
        var not_found = 1;
        if (!rs.pet[tbl]) {
            rs.pet[tbl] = {};
        }
            a.forEach(rs.pet[tbl], function(item){
            if (item.id == s[t].id) {
                not_found = 0;
                return false;
            }
        });
        if (not_found) {
            rs.pet[tbl][s[t].id] = s[t];
        }
        cp.calculatePetNoVisits(rs.pet);
        crud.setTableAfterSubmit(crud.tbl_arr.pets, rs.pet);
        crud.setTableAfterSubmit(crud.tbl_arr[tbl], s[t]);
    };

    /** set rsv afetr delete **/
    this.afterDelete = function(id, tbl, t) {
        a.forEach(rs.pet[tbl], function(item, k){
            if (item.id == id) {
                delete rs.pet[tbl][id];
                return false;
            }
        });
        cp.calculatePetNoVisits(rs.pet);
        crud.setTableAfterSubmit(crud.tbl_arr.pets, rs.pet);
        crud.deleteItem(crud.tbl_arr[tbl], tbl, id);
    };

};