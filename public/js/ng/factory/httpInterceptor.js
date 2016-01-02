/**
 * HttpInterceptor
 * @param $q
 * @param $log
 * @returns {{request: request, response: response, responseError: responseError}}
 */
var httpInterceptor = function ($q, $log) {

    var loadingCount = 0;

    return {
        request: function (config) {
            if(++loadingCount === 1) rs.$broadcast('loading:progress');
            return config || $q.when(config);
        },

        response: function (response) {
            if(--loadingCount === 0) rs.$broadcast('loading:finished');
            return response || $q.when(response);
        },

        responseError: function (response) {
            if(--loadingCount === 0) rs.$broadcast('loading:error');
            return $q.reject(response);
        }
    };

}