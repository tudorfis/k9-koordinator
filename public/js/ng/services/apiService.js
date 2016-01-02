
/**
 * API service
 */
var apiService = function($http, $q, config, transformRequestAsFormPost) {

    var api   = config.api,
        api_r = config.api_r,
        token = config.token,
        env   = config.env;

    /** get API request **/
    this.get = function(table, id, method, extra_json, url_method) {
        var url = (url_method) ? api+url_method : api,
        deffered = $q.defer(),
        result = {};
        data = {
            token:  token,
            env:    env
        };
        if (table) {
            data = a.extend(data, {
                table: table
            });
        }
        if (id) {
            data = a.extend(data, {
                id: id
            });
        }
        if (method) {
            data = a.extend(data, {
                method: method
            });
        }
        if (extra_json) {
            data = a.extend(data, extra_json);
        }
        data = a.extend(data, {cache: true});
        var request = $http.get(url, {params:data});
        request.success(
            function(r) {
                if (r.r) {
                    r.r.is_error = false;
                    deffered.resolve(r.r);
                } else {
                    deffered.resolve(r);
                }

            }
        );
        request.error(
            function(r) {
                r_r = r;
                r = {
                    r: r_r,
                    is_error: true
                };
                deffered.resolve(r);
            }
        );

        return deffered.promise
    };

    /**
     * post API request
     * @param table
     * @param id
     * @param postData
     * @param method
     * @param extra_data
     * @returns {promise}
     */
    this.post = function(table, id, postData, method, extra_data) {
        var deffered = $q.defer(),
            result = {},
            f_data = {};

        a.forEach(postData, function(item, k){
            if (typeof item != 'object' || item == null) {
                f_data[k] = item;
            }
        });
        var data = {
            token:  token,
            env:    env,
            table: table,
            data: f_data
        };
        if (id !== undefined && id !== null && id !== '') {
            data = a.extend(data, {
                id: id
            });
        }
        if (method !== undefined) {
            data = a.extend(data, {
                method: method
            });
        }
        if (extra_data) {
            data = a.extend(data, extra_data);
        }
        var request = $http({
            method: "post",
            url: api+'/post',
            transformRequest: transformRequestAsFormPost,
            data: data
        });
        request.success(
            function(r) {
                r.r.is_error = false;
                deffered.resolve(r.r);
            }
        );
        request.error(
            function(r) {
                r_r = r;
                r = {
                    r: r_r,
                    is_error: true
                };
                deffered.resolve(r);
            }
        );
        return deffered.promise
    };

    /**
     * query API request
     * @param table
     * @param query
     * @param method
     * @returns {promise}
     */
    this.query = function(table, query, method) {
        var deffered = $q.defer(),
            data = {
            token:  token,
            env:    env,
            table: table,
            query: query
        };
        if (method) {
            data = a.extend(data, {
                method: method
            });
        }
        var request = $http({
            method: "get",
            url: api+'/query',
            transformRequest: transformRequestAsFormPost,
            params: data
        });
        request.success(
            function(r) {
                r.is_error = false;
                deffered.resolve(r.r);
            }
        );
        request.error(
            function(r) {
                r_r = r;
                r = {
                    r: r_r,
                    is_error: true
                };
                deffered.resolve(r);
            }
        );
        return deffered.promise
    };

    /**
     * delete API request
     * @param table
     * @param id
     * @param extra_json
     * @param method
     * @returns {promise}
     */
    this.delete = function(table, id, extra_json, method) {
        var deffered = $q.defer(),
            result = {};
        var data = {
            token:  token,
            env:    env,
            table:  table,
            id:     id
        };
        if (extra_json !== undefined) {
            data = a.extend(data, extra_json);
        }
        if (method !== undefined) {
            data = a.extend(data, {
                method: method
            });
        }
        var request = $http({
            method: "get",
            url: api+'/delete',
            params: data
        });
        request.success(
            function(r) {
                r.r.is_error = false;
                deffered.resolve(r.r);
            }
        );
        request.error(
            function(r) {
                r_r = r;
                r = {
                    r: r_r,
                    is_error: true
                };
                deffered.resolve(r);
            }
        );
        return deffered.promise
    };

    /**
     * google geo location
     * @param search
     * @param from_length
     * @param to_length
     * @param country
     * @returns {*}
     */
    this.geoLocation = function(search, from_length, to_length, country) {
        country = (country || 'USA');
        deffered = $q.defer();
        if (rs.isNumberic(pF(search)) &&
            (search.length >= from_length && search.length <= to_length)) {
            var geocoder = new google.maps.Geocoder();
            geocoder.geocode({address: search + ', '+country}, function (results, status) {
                if (status == google.maps.GeocoderStatus.OK) {
                    var street = '',
                        city = '',
                        state = '',
                        zip = '',
                        country = '';
                    a.forEach(results[0].address_components, function (item) {
                        if (item.types[0] == 'route') {
                            street = item.long_name;
                        } else if (item.types[0] == 'locality') {
                            city = item.long_name;
                        } else if (item.types[0] == 'administrative_area_level_1') {
                            state = item.short_name;
                        } else if (item.types[0] == 'postal_code') {
                            zip = item.long_name;
                        } else if (item.types[0] == 'country') {
                            country = item.short_name;
                        }
                    });

                    var data = {
                        street: street,
                        city: city,
                        state: state,
                        zip: zip,
                        country: country
                    };
                    deffered.resolve(data);
                }
            });
        }
        return deffered.promise
    };

};