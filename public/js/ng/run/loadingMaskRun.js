/**
 * Loading mask run
 */
var loadingMaskRun = function(){
    var loadingMaskModels = document.getElementById('loading-mask-models');
    rs.is_models = false;
    rs.$on('loading:progress', function(){
        if (rs.is_models) {
            loadingMaskModels.style.display = 'block';
            rs.is_models = false;
        }
    });
    rs.$on('loading:finished', function(){
        loadingMaskModels.style.display = 'none';
        rs.is_models = false;
    });
    window.onload = function() {
        document.getElementById('loading-mask-resources').style.display = 'none';
    }
};