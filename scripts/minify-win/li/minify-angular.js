// Enter node in console
var compressor = require('C:/Users/todor_000/AppData/Roaming/npm/node_modules/node-minify');
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

