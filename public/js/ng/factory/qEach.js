var qEach = function(q) {
    function qEach(collection, promiseFactory) {
        // ASSERT typeof collection === "object"
        // ASSERT typeof promiseFactory === "function"
        var deferred = q.defer();
        var promises = _.map(collection, function(value) {
            var val = promiseFactory(value);
            if (typeof val === "undefined") val = value;
            return q.when(val);
        });
        q.all(promises).then(function(values) {
            deferred.resolve(values);
        }, function(reason) {
            deferred.reject(reason);
        });
        return deferred.promise;
    }
    return qEach;
};