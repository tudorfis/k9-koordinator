// Enter node in console
var compressor = require('C:/Users/todor_000/AppData/Roaming/npm/node_modules/node-minify');
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

