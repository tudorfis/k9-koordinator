var petOwnershipCtrl = function(api, $scope, $timeout) {
    var s = $scope;
    s.po = {
        pet_id: null,
        client_id: null,
        is_error: null,
        message: null
    };
    s.verifyPet = function(without_alert) {
        s.po.is_error = true;
        if (!s.po.pet_id) {
            if (!without_alert) s.po.message = 'Please enter pet ID';
        } else {
            if (rs.cp_cp[s.po.pet_id]) {
                s.po.is_error = false;
                if (!without_alert) s.po.message = "The pet ID is valid";
            } else {
                if (!without_alert) s.po.message = "Not a valid pet ID";
            }
        }
        return s.po.is_error;
    };
    s.verifyClient = function(without_alert) {
        s.po.is_error = true;
        if (!s.po.client_id) {
            if (!without_alert) s.po.message = 'Please enter client ID';
        } else {
            if (rs.cp[s.po.client_id]) {
                if (!without_alert) s.po.message = "The client ID is valid";
                s.po.is_error = false;
            } else {
                if (!without_alert) s.po.message = "Not a valid client ID";
            }
        }
        return s.po.is_error;
    };
    s.savePo = function() {
        var client_id = parseInt(s.po.client_id),
            pet_id = parseInt(s.po.pet_id),
            cp_data = {
                client_id: client_id,
                pet_id: pet_id
            };
        if (s.verifyPet(1) || s.verifyClient(1)) {
            s.po.message = "Please enter valid client and pet IDs";
            s.po.is_error = true;
        } else {
            rs.hs('.btn_po', '.al_po');
            var d_client_id = null;
            a.forEach(rs.cp, function(item, k){
                if (item.indexOf(pet_id) != -1) {
                    d_client_id = k;
                }
            });
            var d_cp_data = {
                filter: {
                    client_id: d_client_id,
                    pet_id: pet_id,
                }
            };
            api.delete('cp', '', d_cp_data, 'permanent').then(function(r){
                api.post('cp', '', cp_data, 'taxonomy').then(function(r) {
                    s.po = {};
                    s.po.is_error = false;
                    s.po.message = 'Pet ownership successfully transfered ! The browser ' +
                                    ' will refresh in aprox. 3 seconds for the new changes to take effect';
                    rs.sh('.btn_po', '.al_po');
                    $timeout(function(){
                        location.reload();
                    }, 3000);
                });
            });
        }
    }
};