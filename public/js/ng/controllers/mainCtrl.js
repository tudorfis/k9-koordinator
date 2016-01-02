/**
 * MainCtrl
 * @param $scope
 * @constructor
 */
var mainCtrl = function($scope){
    var s = $scope;

    rs.parseStyle =  function(f, from, to) {
        if (s[f]) {
            var eval_html = s.$eval('\'' + $(from).html() + '\'');
            $(to).html(eval_html);
        }
    };
};