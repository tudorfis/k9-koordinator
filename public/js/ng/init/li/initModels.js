/**
 *
 * @param $http
 * @param models
 * @param cFunc
 * @param crud
 * @param cp
 * @param settings
 * @param access
 * @param $cookies
 * @param $location
 * @param $state
 * @param $urlRouter
 * @param pdf
 * @param $timeout
 * @param language
 */
var initModels = function($http, models, cFunc, crud, cp, settings, access, $cookies, $location, $state, $urlRouter, pdf, rsv, $timeout, language) {

    /** default settings **/
    rs.access = access;
    rs.cookies = $cookies;
    rs.location = $location;
    rs.cFunc = cFunc;
    rs.crud = crud;
    rs.pdf = pdf;
    rs.l = language;
    rs.post = {};

    rs.$on('$stateChangeStart', function(e, to, toParams, fromState, fromParams) {

        /** check if settings loaded **/
        if (!rs.settings) {

            /** prevent state from loading partial **/
            e.preventDefault();

            /** load settings and models **/
            var extra_json = {filter: {order: 'id desc'}, get_with: 'id'};
            rs.init_done = false;
            models.getModels(settings_tables_arr, null, 'multiple_login', extra_json).then(function(r_s){
                models.getModels(general_tables_arr, null, '', extra_json).then(function(r_g){

                    /** settings builds **/
                    settings.doAll();

                    /** cp builds **/
                    cp.doAll();

                    /** rsv builds **/
                    rsv.doAll();

                    /** pdf image builds **/
                    pdf.initImages();

                    /** set layout **/
                    rs.parseStyle('settings', '#fromStyle', '#toStyle');

                    /** set values for init **/
                    rs.init_done = true;
                    cps = $('#CpCtrl').scope();


                    /** TESTING **/
                    /** #################### **/
                    //rs.client = rs.clients[1];
                    //rs.pet = rs.client.pet;
                    //rs.prd_selected = 'r_training';
                    //var rbc = $('#rTrainingCtrl').scope();
                    //rbc.r_grooms_mod = rs.r_grooms[1];
                    //rs.section = 'check_in_out';
                    //rs.revealModal('#rGroomsModal');
                    //rbc.o = {
                    //    language: 'en',
                    //    print_type: 'screen'
                    //};

                    /** load state after everything is loaded **/
                    $state.go(to.name, toParams);
                    $urlRouter.sync();

                });
            });
        } else {
            rs.done = 1;
        }
    });
    rs.$on('$stateChangeSuccess', function(event, toState, toParams, fromState, fromParams) {
        if (toState.name == 'main') {
            $('#mainPage').show();
            $('#uiView').hide();
        } else {
            $('#ajaxLoaderHuge').hide();
            $('#mainPage').hide();
            $('#uiView').show();
        }
    });
};
