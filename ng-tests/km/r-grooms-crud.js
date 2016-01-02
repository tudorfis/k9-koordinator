/**
 * @desc: Add grooming reseration for certain client and pet
 */
$timeout(function(){
    var pidc = $('#PetInfoDetailsCtrl').scope(),
        rgc = $('#RGroomsCtrl').scope(),
        client_id = 28,
        pet_id = 30,
        date_in = '2014-08-25',
        date_out = '2014-08-26';
    $rootScope.client = $rootScope.cp_clients[client_id];
    $rootScope.pet = $rootScope.cp_pets[pet_id];
    $rootScope.getClientPet($rootScope.client, $rootScope.pet);
    pidc.prd_selected = 'grooms';
    pidc.getPetRelatedDetails('grooms');
    rgc.getMod({});
    $rootScope.revealModal('#rGroomsModal');
    rgc.r_grooms_mod.date_in = date_in;
    rgc.r_grooms_mod.date_out = date_out;
}, 100);