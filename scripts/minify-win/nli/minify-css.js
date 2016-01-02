// Enter node in console
var compressor = require('C:/Users/todor_000/AppData/Roaming/npm/node_modules/node-minify');
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