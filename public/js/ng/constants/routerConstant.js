var crudCtrlSettings = function(settings) {
    mainApp.controller('CrudCtrl', CrudCtrl);
    mainApp.run(foundationRun);
    settings.buildFoundationPatterns();
};
var routerConstant = function($stateProvider, $urlRouterProvider){
    mainApp.stateProvider = $stateProvider;
    $urlRouterProvider.otherwise("/");
    $stateProvider
        .state('main', {
            url: '/',
            controller: function($rootScope) {
                $('#mainPage').show();
                document.getElementById('mainContent').scrollTop = 0;
            }
        })
        .state('general-settings', {
            url: "/tbl/settings/general-settings",
            templateUrl: "partials?t=tbl/settings/general-settings",
            controller: generalSettingsCtrl
        })
        .state('basic-information', {
            url: "/tbl/settings/basic-information",
            templateUrl: "partials?t=tbl/settings/basic-information",
            controller: 'BasicInformationCtrl'
        })
        .state('tax-settings', {
            url: "/tbl/extra/tax-settings",
            templateUrl: "partials?t=tbl/extra/tax-settings",
            controller: taxSettingsCtrl
        })
        .state('reservations_daycare_groups', {
            url: "/tbl/reservations/daycare/groups-and-day",
            templateUrl: "partials?t=tbl/reservations/daycare/groups-and-day",
            controller: daycareGroupsCtrl
        })
        .state('commissions', {
            url: "/tbl/settings/commissions",
            templateUrl: "partials?t=tbl/settings/commissions",
            controller: commissionsCtrl
        })
        .state('holiday_and_season', {
            url: "/tbl/settings/holiday-and-season",
            templateUrl: "partials?t=tbl/settings/holiday-and-season",
            controller: holidayAndSeasonCtrl
        })
        .state('my_account', {
            url: "/tbl/settings/my-account",
            templateUrl: "partials?t=tbl/settings/my-account",
            controller: 'myAccountCtrl'
        })
        .state('rewards_program', {
            url: "/tbl/settings/rewards-program",
            templateUrl: "partials?t=tbl/settings/rewards-program",
            controller: rewardsProgramCtrl
        })
        .state('user_interface', {
            url: "/tbl/settings/user-interface",
            templateUrl: "partials?t=tbl/settings/user-interface",
            controller: userInterfaceCtrl
        })
        .state('layout', {
            url: "/tbl/settings/layout",
            templateUrl: "partials?t=tbl/settings/layout",
            controller: layoutSettingsCtrl
        })
        .state('discounts_boarding', {
            url: "/tbl/settings/discounts/boarding",
            templateUrl: "partials?t=tbl/settings/discounts/boarding",
            controller: discountsBoardingCtrl
        })
        .state('password_management', {
            url: "/tbl/settings/security/password-management",
            templateUrl: "partials?t=tbl/settings/security/password-management",
            controller: passwordManagementCtrl
        })
        .state('security_center', {
            url: "/tbl/settings/security/security-center",
            templateUrl: "partials?t=tbl/settings/security/security-center",
            controller: securityCenterCtrl
        })
        .state('security_levels', {
            url: "/tbl/settings/security/security-levels",
            templateUrl: "partials?t=tbl/settings/security/security-levels",
            controller: securityLevelsCtrl
        })
        .state('general_features', {
            url: "/tbl/settings/general-features",
            templateUrl: "partials?t=tbl/settings/general-features",
            controller: generalFeaturesCtrl
        })
        .state('retail', {
            url: "/tbl/settings/retail",
            templateUrl: "partials?t=tbl/settings/retail",
            controller: 'RetailCtrl'
        })
        .state('languages', {
            url: "/tbl/settings/languages",
            templateUrl: "partials?t=tbl/settings/languages",
            controller: 'LanguageCtrl'
        })
        .state('users', {
            url: "/crud/users",
            templateUrl: "crud?t=users",
            controller: crudCtrlSettings
        })
        .state('groomers', {
            url: "/crud/groomers",
            templateUrl: "crud?t=groomers",
            controller: crudCtrlSettings
        })
        .state('trainers', {
            url: "/crud/trainers",
            templateUrl: "crud?t=trainers",
            controller: crudCtrlSettings
        })
        .state('stay_reasons', {
            url: "/crud/stay_reasons",
            templateUrl: "crud?t=stay_reasons",
            controller: crudCtrlSettings
        })
        .state('reservations_boarding_settings', {
            url: "/tbl/reservations/boarding/boarding-settings",
            templateUrl: "partials?t=tbl/reservations/boarding/boarding-settings",
            controller: boardingSettings
        })
        .state('reservations_grooming_general', {
            url: "/tbl/reservations/grooming/grooming-general",
            templateUrl: "partials?t=tbl/reservations/grooming/grooming-general",
            controller: groomingGeneralCtrl
        })
        .state('reservations_grooming_rates', {
            url: "/tbl/reservations/grooming/grooming-rates",
            templateUrl: "partials?t=tbl/reservations/grooming/grooming-rates",
            controller: groomingRatesCtrl
        })
        .state('reservations_grooming_services', {
            url: "/tbl/reservations/grooming/grooming-services",
            templateUrl: "partials?t=tbl/reservations/grooming/grooming-services",
            controller: groomingServicesCtrl
        })
        .state('reservation_training_groups', {
            url: "/tbl/reservations/training/training-groups",
            templateUrl: "partials?t=tbl/reservations/training/training-groups",
            controller: trainingGroupsCtrl
        })
        .state('reservation_training_schedule', {
            url: "/tbl/reservations/training/training-schedule",
            templateUrl: "partials?t=tbl/reservations/training/training-schedule",
            controller: trainingScheduleCtrl
        })
        .state('schedule_services', {
            url: "/crud/schedule_services",
            templateUrl: "crud?t=schedule_services",
            controller: crudCtrlSettings
        })
        .state('meds', {
            url: "/crud/meds",
            templateUrl: "crud?t=meds",
            controller: crudCtrlSettings
        })
        .state('meds_type', {
            url: "/crud/meds_type",
            templateUrl: "crud?t=meds_type",
            controller: crudCtrlSettings
        })
        .state('diets', {
            url: "/crud/diets",
            templateUrl: "crud?t=diets",
            controller: crudCtrlSettings
        })
        .state('diets_type', {
            url: "/crud/diets_type",
            templateUrl: "crud?t=diets_type",
            controller: crudCtrlSettings
        })
        .state('md_dosage', {
            url: "/crud/md_dosage",
            templateUrl: "crud?t=md_dosage",
            controller: crudCtrlSettings
        })
        .state('md_dose_type', {
            url: "/crud/md_dose_type",
            templateUrl: "crud?t=md_dose_type",
            controller: crudCtrlSettings
        })
        .state('pet_color', {
            url: "/crud/pet_color",
            templateUrl: "crud?t=pet_color",
            controller: crudCtrlSettings
        })
        .state('pet_type', {
            url: "/crud/pet_type",
            templateUrl: "crud?t=pet_type",
            controller: crudCtrlSettings
        })
        .state('pet_breed', {
            url: "/crud/pet_breed",
            templateUrl: "crud?t=pet_breed",
            controller: crudCtrlSettings
        })
        .state('pet_status', {
            url: "/crud/pet_status",
            templateUrl: "crud?t=pet_status",
            controller: crudCtrlSettings
        })
        .state('time_clock', {
            url: "/tbl/tools/time-clock",
            templateUrl: "partials?t=tbl/tools/time-clock",
            controller: timeClockCtrl
        })
        .state('client_status', {
            url: "/crud/client_status",
            templateUrl: "crud?t=client_status",
            controller: crudCtrlSettings
        })
        .state('payment_types', {
            url: "/crud/payment_types",
            templateUrl: "crud?t=payment_types",
            controller: crudCtrlSettings
        })
        .state('client_survey_findout', {
            url: "/crud/client_survey_findout",
            templateUrl: "crud?t=client_survey_findout",
            controller: crudCtrlSettings
        })
        .state('client_survey_income', {
            url: "/crud/client_survey_income",
            templateUrl: "crud?t=client_survey_income",
            controller: crudCtrlSettings
        })
        .state('vets', {
            url: "/crud/vets",
            templateUrl: "crud?t=vets",
            controller: crudCtrlSettings
        })
        .state('help', {
            url: "/help/",
            templateUrl: "partials?t=help",
            controller: 'HelpCtrl'
        })
        .state('select-kennel', {
            url: "/select-kennel/",
            templateUrl: "partials?t=select-kennel",
            controller: function() {

            }
        })
        .state('pet_ownership', {
            url: "/tbl/tools/pet-ownership/",
            templateUrl: "partials?t=tbl/tools/pet-ownership",
            controller: petOwnershipCtrl
        })
};