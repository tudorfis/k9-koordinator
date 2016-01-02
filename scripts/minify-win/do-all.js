// Enter node in console
var compressor = require('C:/Users/todor_000/AppData/Roaming/npm/node_modules/node-minify');
new compressor.minify({
    type: 'yui-css',
    fileIn: [
        'css/foundation.min.css',
        'css/foundation-icons.min.css',
        'css/font-awesome.min.css',
        'bower_components/animate.css/animate.min.css',
        'bower_components/angular-rangeslider/angular.rangeSlider.css',
        'css/jquery-ui.min.css',
        'css/jquery.ui.timepicker.min.css',
        'css/jquery.fancybox.min.css',
        'css/spectrum.min.css',
        'css/styles.css'
    ],
    fileOut: 'css/minified.li.css',
    callback: function(err, min){
        console.log(err);
    }
});
new compressor.minify({
    type: 'uglifyjs',
    fileIn: [
        'js/vendor/angular.min.js',
        'js/angular/angular-cookies.min.js',
        'js/angular/angular-animate.min.js',
        'js/angular/angular-webstorage.min.js',
        'js/angular/angular-ui-router.min.js',
        'bower_components/angular-rangeslider/angular.rangeSlider.js'
    ],
    fileOut: 'js/minified/li/minified-angular.js',
    callback: function(err, min){
        console.log(err);
//        console.log(min);
    }
});
new compressor.minify({
    type: 'uglifyjs',
    fileIn: [
        'js/ng/run/viewsRun.js',
        'js/ng/run/searchRun.js',
        'js/ng/run/convertsRun.js',
        'js/ng/run/reportsRun.js',
        'js/ng/run/scrollUpRun.js',
        'js/ng/run/loadingMaskRun.js',
        'js/ng/run/foundationRun.js',
        'js/ng/run/validatorsRun.js',
        'js/ng/controllers/mainCtrl.js',
        'js/ng/controllers/tbl/extra/taxSettings.js',
        'js/ng/controllers/tbl/reservations/boarding/boardingSettings.js',
        'js/ng/controllers/tbl/reservations/daycare/daycareGroups.js',
        'js/ng/controllers/tbl/reservations/grooming/groomingGeneral.js',
        'js/ng/controllers/tbl/reservations/grooming/groomingRates.js',
        'js/ng/controllers/tbl/reservations/grooming/groomingServices.js',
        'js/ng/controllers/tbl/reservations/training/trainingGroups.js',
        'js/ng/controllers/tbl/reservations/training/trainingSchedule.js',
        'js/ng/controllers/tbl/settings/basicInformation.js',
        'js/ng/controllers/tbl/settings/generalSettings.js',
        'js/ng/controllers/tbl/settings/commissions.js',
        'js/ng/controllers/tbl/settings/holidayAndSeason.js',
        'js/ng/controllers/tbl/settings/myAccount.js',
        'js/ng/controllers/tbl/settings/rewardsProgram.js',
        'js/ng/controllers/tbl/settings/userInterface.js',
        'js/ng/controllers/tbl/settings/layout.js',
        'js/ng/controllers/tbl/settings/discounts/boarding.js',
        'js/ng/controllers/tbl/settings/security/passwordManagement.js',
        'js/ng/controllers/tbl/settings/security/securityCenter.js',
        'js/ng/controllers/tbl/settings/security/securityLevels.js',
        'js/ng/controllers/tbl/settings/generalFeatures.js',
        'js/ng/controllers/tbl/settings/retail.js',
        'js/ng/controllers/tbl/settings/languages.js',
        'js/ng/controllers/crud/users.js',
        'js/ng/controllers/tools/timeClock.js',
        'js/ng/controllers/tools/petOwnership.js',
        'js/ng/controllers/index/help.js',
        'js/ng/controllers/index/cp.js',
        'js/ng/controllers/index/rBoarding.js',
        'js/ng/controllers/index/rTraining.js',
        'js/ng/controllers/index/rDaycare.js',
        'js/ng/controllers/index/rGrooms.js',
        'js/ng/controllers/index/rServices.js',
        'js/ng/controllers/index/rMeds.js',
        'js/ng/controllers/index/rDiets.js',
        'js/ng/controllers/index/rRecords.js',
        'js/ng/controllers/side/posCtrl.js',
        'js/ng/controllers/side/pendingCtrl.js',
        'js/ng/controllers/side/depositsCtrl.js',
        'js/ng/controllers/side/reportsCtrl.js',
        'js/ng/controllers/side/messagesCtrl.js',
        'js/ng/controllers/side/vaccanciesCtrl.js',
        'js/ng/controllers/side/layoutCtrl.js',
        'js/ng/controllers/side/managerCtrl.js',
        'js/ng/directives/inputFormDirectives.js',
        'js/ng/directives/imageDirectives.js',
        'js/ng/directives/commonDirectives.js',
        'js/ng/directives/tableDirectives.js',
        'js/ng/factory/transformRequestAsFormPost.js',
        'js/ng/factory/httpInterceptor.js',
        'js/ng/factory/qEach.js',
        'js/ng/services/apiService.js',
        'js/ng/services/modelsService.js',
        'js/ng/services/cFuncService.js',
        'js/ng/services/languageService.js',
        'js/ng/services/crudService.js',
        'js/ng/services/calcService.js',
        'js/ng/services/cpService.js',
        'js/ng/services/rsvService.js',
        'js/ng/services/dateTimeService.js',
        'js/ng/services/pdfService.js',
        'js/ng/services/accessService.js',
        'js/ng/services/settingsService.js',
        'js/ng/prototype/array.js',
        'js/ng/prototype/string.js',
        'js/ng/prototype/map.js',
        'js/ng/filters/commonFilters.js',
        'js/ng/filters/dateFilters.js',
        'js/ng/constants/configConstant.js',
        'js/ng/constants/tablesConstant.js',
        'js/ng/constants/routerConstant.js',
        'js/ng/init/li/init.js',
        'js/ng/config.js',
        'js/ng/init/li/resources.js',
        'js/ng/init/li/initModels.js'
    ],
    fileOut: 'js/minified/li/minified-ng.js',
    callback: function(err, min){
        console.log(err);
    }
});
new compressor.minify({
    type: 'uglifyjs',
    fileIn: [
        'js/vendor/modernizr.min.js',
        'js/vendor/underscore-min.js',
        'js/vendor/chance.min.js',
        'js/vendor/jquery.min.js',
        'js/jquery/jquery-ui.min.js',
        'js/jquery/jquery.ui.core.min.js',
        'js/jquery/jquery.ui.timepicker.min.js',
        'js/jquery/jquery.fancybox.min.js',
        'js/jquery/jquery.spectrum.min.js',
        'js/foundation/foundation.datepicker.min.js',
        'bower_components/pdfmake/build/pdfmake.min.js',
        'bower_components/pdfmake/build/vfs_fonts.js',
        'bower_components/jsbarcode/CODE128.js',
        'bower_components/jsbarcode/JsBarcode.js',
        'js/vendor/foundation.min.js'
    ],
    fileOut: 'js/minified/li/minified-resources.js',
    callback: function(err, min){
        console.log(err);
    }
});
new compressor.minify({
    type: 'yui-css',
    fileIn: [
        'css/foundation.min.css',
        'css/foundation-icons.min.css',
        'css/font-awesome.min.css',
        'css/styles.css'
    ],
    fileOut: 'css/minified.nli.css',
    callback: function(err, min){
        console.log(err);
    }
});
new compressor.minify({
    type: 'uglifyjs',
    fileIn: [
        'js/vendor/angular.min.js',
        'js/angular/angular-cookies.min.js',
    ],
    fileOut: 'js/minified/nli/minified-angular.js',
    callback: function(err, min){
        console.log(err);
//        console.log(min);
    }
});
new compressor.minify({
    type: 'uglifyjs',
    fileIn: [
        'js/ng/controllers/mainCtrl.js',
        'js/ng/factory/transformRequestAsFormPost.js',
        'js/ng/factory/httpInterceptor.js',
        'js/ng/services/apiService.js',
        'js/ng/services/modelsService.js',
        'js/ng/directives/commonDirectives.js',
        'js/ng/filters/commonFilters.js',
        'js/ng/run/convertsRun.js',
        'js/ng/run/scrollUpRun.js',
        'js/ng/run/loadingMaskRun.js',
        'js/ng/run/foundationRun.js',
        'js/ng/constants/configConstant.js',
        'js/ng/constants/tablesConstant.js',
        'js/ng/init/nli/init.js',
        'js/ng/config.js',
        'js/ng/init/nli/resources.js',
        'js/ng/init/nli/initModels.js'
    ],
    fileOut: 'js/minified/nli/minified-ng.js',
    callback: function(err, min){
        console.log(err);
    }
});
new compressor.minify({
    type: 'uglifyjs',
    fileIn: [
        'js/vendor/modernizr.min.js',
        'js/vendor/jquery.min.js',
        'js/vendor/foundation.min.js'
    ],
    fileOut: 'js/minified/nli/minified-resources.js',
    callback: function(err, min){
        console.log(err);
    }
});
