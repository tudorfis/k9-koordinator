/**
 * Access service
 * @param rs.
 */
var accessService = function($cookies) {

    var self = this;

    this.checkGf = function() {
        return (rs.general_features !== undefined);
    };

    this.checkUis = function() {
        return (rs.user_interface_settings !== undefined);
    };

    this.checkBoarding = function() {
        if (self.checkGf()) {
            return (rs.general_features[1].v == 1);
        }
        return false;
    };

    this.checkGrooming = function() {
        if (self.checkGf()) {
            return (rs.general_features[4].v == 1);
        }
        return false;
    };

    this.checkTraining = function() {
        if (self.checkGf()) {
            return (rs.general_features[5].v == 1);
        }
        return false;
    };

    this.checkDaycare = function() {
        if (self.checkGf()) {
            return (rs.general_features[2].v == 1);
        }
        return false;
    };

    this.checkRsv = function() {
        if (self.checkGf()) {
            var result = false;
            a.forEach([1,2,4,5], function(id){
                if (rs.general_features[id].v != 0) {
                    result = true;
                    return false;
                }
            });
            return result;
        }
        return false;
    };

    this.checkServices = function() {
        if (self.checkGf()) {
            return (rs.general_features[6].v == 1);
        }
        return false;
    };

    this.checkMeds = function() {
        if (self.checkGf()) {
            return (rs.general_features[14].v == 1);
        }
        return false;
    };

    this.checkDiets = function() {
        if (self.checkGf()) {
            return (rs.general_features[15].v == 1);
        }
        return false;
    };

    this.checkRewards = function() {
        if (self.checkGf()) {
            return (rs.general_features[3].v == 1)
        }
        return false;
    };

    this.checkRewardsIsActive = function() {
        if (rs.promotions_settings && !rs.isEmpty(rs.promotions)) {
            return (rs.promotions_settings.rewards_program_is_active == 1)
        }
        return false;
    };



    this.checkSticky = function() {
        if (self.checkGf()) {
            return (rs.general_features[18].v == 1)
        }
        return false;
    };

    this.checkPetRecords = function() {
        if (self.checkGf()) {
            return (rs.general_features[17].v == 1)
        }
        return false;
    };

    this.checkNotepads = function() {
        if (self.checkGf()) {
            return (rs.general_features[19].v == 1)
        }
        return false;
    };

    this.checkVaccinations = function() {
        if (self.checkGf()) {
            return (rs.general_features[16].v == 1)
        }
        return false;
    };

    this.checkSurvey = function() {
        if (self.checkUis()) {
            return (rs.user_interface_settings.show_survey_when_creating_client == 1);
        }
        return false;
    };

    this.checkSurveyIncome = function() {
        if (self.checkUis()) {
            return (rs.user_interface_settings.show_income_survey_when_creating_client == 1);
        }
        return false;
    };

    this.checkMembership = function() {
        if (self.checkUis()) {
            return  (rs.user_interface_settings.enable_membership == 1);
        }
        return false;
    };

    this.checkSearchMembership = function() {
        if (self.checkGf()) {
            return  (rs.general_features[20].v == 1);
        }
        return false;
    };


    this.checkSearchPetId = function() {
        if (self.checkGf()) {
            return  (rs.general_features[21].v == 1)
        }
        return false;
    };

    this.checkSearchPetBreed = function() {
        if (self.checkGf()) {
            return  (rs.general_features[22].v == 1)
        }
        return false;
    };

    this.isKennel = function(){
        return ($cookies.kennel);
    };

    this.isOnSelectKennel = function() {
        return (rs.location.path().indexOf('select-kennel') != -1)
    };

    this.isLoggedIn = function() {
          return (!rs.isEmpty(rs.identity));
    };

    this.checkPointOfSale = function() {
        if (self.checkGf()) {
            return  (rs.general_features[24].v == 1)
        }
        return false;
    };

    this.checkManager = function() {
        if (self.checkGf()) {
            return  (rs.general_features[25].v == 1)
        }
        return false;
    };

    this.checkReports = function() {
        if (self.checkGf()) {
            return  (rs.general_features[26].v == 1)
        }
        return false;
    };

    this.checkVacancies = function() {
        if (self.checkGf()) {
            return  (rs.general_features[27].v == 1)
        }
        return false;
    };

    this.checkDeposits = function() {
        if (self.checkGf()) {
            return  (rs.general_features[28].v == 1)
        }
        return false;
    };

    this.checkLayout = function() {
        if (self.checkGf()) {
            return  (rs.general_features[29].v == 1)
        }
        return false;
    };

    this.checkSideMenu = function() {
        if (self.checkGf()) {
            var result = false;
            a.forEach([24,25,26,27,28,29], function(id){
                if (rs.general_features[id].v != 0) {
                    result = true;
                    return false;
                }
            });
            return result;
        }
        return false;
    };

    this.enableEmail = function() {
        if (self.checkUis()) {
            return  (rs.user_interface_settings.enable_email == 1);
        }
        return false;
    };

    this.requireAddressClient = function() {
        if (self.checkUis()) {
            return  (rs.user_interface_settings.require_address_when_creating_client == 1);
        }
        return false;
    };

    this.requireEmailClient = function() {
        if (self.checkUis() && self.enableEmail()) {
            return  (rs.user_interface_settings.require_email_when_creating_client == 1);
        }
        return false;
    };

    this.alarmPetAge = function() {
        if (self.checkUis()) {
            return (rs.user_interface_settings.alarm_pet_age_when_older_than == 1);
        }
        return false;
    };

    this.alarmPetAgeValue = function() {
        if (self.alarmPetAge()) {
            return (rs.user_interface_settings.alarm_pet_age_when_older_than_value || null);
        }
        return null;
    };

    this.checkCouponsPos = function() {
        if (self.checkGf()) {
            return  (rs.general_features[8].v == 1)
        }
        return false;
    };

    this.checkRefundsPos = function() {
        if (self.checkGf()) {
            return  (rs.general_features[7].v == 1)
        }
        return false;
    }








};
