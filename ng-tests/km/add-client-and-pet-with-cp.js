/**
 * @source: cp/cp-ctrl.phtml
 * @dependencies: $scope, $rootScope, $http, config, $timeout
 * @extra_files: ng/run/viewsRun.js
 * @desc: Ater loading of clients, pets, cp and setting them up
 *        will reveal cpMod modal with form, and it will submit with predefined values
 */
$timeout(function(){
    var data = {
        env: config.env,
        token: config.token,
        table: 'query',
        query: 'truncate table clients;'
    };
    $http({method: 'get', url: config.api+'/query', params: data}).
        success(function(r) {

            var data = {
                env: config.env,
                token: config.token,
                table: 'query',
                query: 'truncate table pets;'
            };
            $http({method: 'get', url: config.api+'/query', params: data}).
                success(function(r) {

                    var data = {
                        env: config.env,
                        token: config.token,
                        table: 'query',
                        query: 'truncate table cp;'
                    };
                    $http({method: 'get', url: config.api+'/query', params: data}).
                        success(function(r) {

                            $scope.getPetInfoDetails({}, 'edit');
                            $rootScope.revealModal('#cpModal');
                            $scope.client_mod = {
                                first_name: 'Todorescu',
                                last_name: 'Tudor',
                                contact_phone: '(123) 456-7890'
                            };
                            $scope.pet_mod = {
                                pet_name: 'Rocky',
                                pet_type_id: '1',
                                pet_color_id: '1',
                                pet_size_id: '1',
                                pet_sex_id: '1',
                                pet_breed_id: '5',
                                pet_weight: '50',
                                dob: '08/07/2014'
                            };

                            $('#cpForm').trigger('valid');

                            console.log($rootScope.cp);
                            console.log($rootScope.cp_cp);
                            console.log($rootScope.cp_clients);
                            console.log($rootScope.clients);
                            console.log($rootScope.cp_pets);
                            console.log($rootScope.pets);
                            console.log($scope.client_mod);
                            console.log($scope.pet_mod);

                            $timeout(function(){
                                console.log($rootScope.client);
                                console.log($rootScope.pet);
                            }, 1000);

                        });
                });
        });
}, 100);