
/**
 * Common functions service
 */
var cFuncService = function(api) {

    /**
     * Check if is null,
     * empty or undefined
     */
    this.isNEU = function(in_var) {
        return ((in_var === null) || (in_var === '') || (in_var === undefined));
    };

    /**
     * Generate random uid
     * @returns {Function}
     */
    this.guid = function() {
        return 'a'+Math.floor((1 + Math.random()) * 0x10000).toString(16).substring(1);
    };
	
	this.guid_long = function() {
		return 'l'+Math.random()+Math.random()+Math.random()+Math.random();
	};

    this.uid = function() {
        function s4() {
            return Math.floor((1 + Math.random()) * 0x10000)
                .toString(16)
                .substring(1);
        }
        return s4() + s4() + '-' + s4() + '-' + s4() + '-' + s4() + '-' + s4() + s4() + s4();
    };

    /**
     * Check if empty object
     * @param obj
     * @returns {boolean}
     */
    this.isEmpty = function(obj) {

        // null and undefined are "empty"
        if (obj == null) return true;

        // Assume if it has a length property with a non-zero value
        // that that property is correct.
        if (obj.length > 0)    return false;
        if (obj.length === 0)  return true;

        // Otherwise, does it have any properties of its own?
        // Note that this doesn't handle
        // toString and valueOf enumeration bugs in IE < 9
        for (var key in obj) {
            if (hasOwnProperty.call(obj, key)) return false;
        }

        return true;
    };

    /** first element **/
    this.fe = function(obj) {
        if (obj) {
            return obj[Object.keys(obj)[0]] ;
        } else {
            return null;
        }
    };

    this.generateNumber = function(nr) {
        nr = nr || 10;
        var x = 1;
        for (i = 1; i <= nr; i++) {
            x = x*10;
        }
        return Math.floor(Math.random() * x);
    }

};