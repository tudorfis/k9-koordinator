// Enter node in console
var compressor = require('C:/Users/todor_000/AppData/Roaming/npm/node_modules/node-minify');
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