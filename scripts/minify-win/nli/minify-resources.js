// Enter node in console
var compressor = require('C:/Users/todor_000/AppData/Roaming/npm/node_modules/node-minify');
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