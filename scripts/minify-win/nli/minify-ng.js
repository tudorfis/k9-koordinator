// Enter node in console
var compressor = require('C:/Users/todor_000/AppData/Roaming/npm/node_modules/node-minify');
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