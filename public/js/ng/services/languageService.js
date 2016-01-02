
/**
 * languages service
 */
var languageService = function(api, $q) {

    var self = this;

    this.language = 'en';

    this.setLanguage = function(language) {
        self.language = language;
    };

    this.l = function(n) {
        if (rs.l_keys && rs.l_keys[n] && rs.l_keys[n][self.language]) {
            return rs.l_keys[n][self.language];
        }
        return n;
    };

    this.l_text = function(n) {
        var text = n;
        a.forEach(rs.lang_keys, function(item){
            if (item.lang == n) {
                text = item.text;
            }
        });
        return text;
    };

};