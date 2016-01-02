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