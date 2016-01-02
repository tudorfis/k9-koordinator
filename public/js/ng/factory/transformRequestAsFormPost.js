/**
 * Transform http post request
 * @returns {transformRequest}
 */
var transformRequestAsFormPost = function(){
    /**
     * Transform http request
     * @param data
     * @param getHeaders
     * @returns {*}
     */
    function transformRequest(data, getHeaders) {
        var headers = getHeaders();
        headers[ "Content-type" ] = "application/x-www-form-urlencoded; charset=utf-8";
        return serializeData(data);
    }
    /**
     * Serialize data
     * @param data
     * @returns {string}
     */
    function serializeData(data) {
        if (!a.isObject(data)) {
            return( ( data == null ) ? "" : data.toString() );
        }
        var buffer = [];
        for (var name in data) {
            if (!data.hasOwnProperty(name)) {
                continue;
            }
            var value = data[name];
            if (typeof value == 'object') {
                value = JSON.stringify(value);
            }
            buffer.push(
                encodeURIComponent(name) +"="+
                encodeURIComponent((value == null) ? "" : value)
            );
        }
        var source = buffer.join( "&" ).replace( /%20/g, "+" );
        return source;
    }
    return transformRequest;
};