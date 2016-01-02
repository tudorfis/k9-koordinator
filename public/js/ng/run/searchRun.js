/**
 * Search advanced stuff
 */
var searchRun = function() {

    /**
     * Search each table for certain value
     * then associate them with its ids, then
     * filter excluded ids with "filterExcludeObjIds"
     * @param scope_id
     * @param target
     * @param result
     * @param tables
     */
    rs.searchAdvancedObj = function(scope_id, target, result, tables) {
        var scope = $(scope_id).scope(),
            matching = {};
        scope[result] = {};
        a.forEach(tables, function(t){
            matching[t.id] = [];
            a.forEach(scope[t.tbl], function(item){
                a.forEach(t.v, function(m){
                    var str = item[m].toString().toLowerCase(),
                        match = scope[target].toString().toLowerCase();
                    if (str.match(match)) {
                        matching[t.id].push(item.id);
                    }
                });
            });
        });
        scope[result] = matching;

    }
};
