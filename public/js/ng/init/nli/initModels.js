/**
 *
 * @param models
 * @param $cookies
 */
var initModels = function(models, $cookies) {
    rs.cookies = $cookies;
    models.getModels(settings_tables_arr, null, 'multiple_login', {
        filter: {order: 'id desc'},
        get_with: 'id'
    }).then(function(){
        rs.parseStyle('settings', '#fromStyle', '#toStyle');
    });
};