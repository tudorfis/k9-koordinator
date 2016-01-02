var languagesCtrl = function($scope, api, $timeout, crud, settings) {
    var s = $scope;
    s.start = true;
    s.filter = {};
    s.delete_language = '';
    s.add_language = {
        lang: '',
        text: ''
    };
    s.new_lang_keys = [];
    s.isExcludedByFilter = function(lang) {
        return (s.filter[lang]) ? !s.filter[lang] : true;
    };
    s.updateLang = function(id) {
        if (s.start) {
            s.start = false;
            $timeout(function(){
                $('.al_main').show();
                var data = rs.languages[id];
                api.post('languages', id, data).then(function(r){
                    s.start = true;
                    $('.al_main').fadeOut('medium');
                    settings.buildLanguages(1);
                });
            }, 1500);
        }
    };
    s.addLanguage = function() {
        if (!s.add_language.lang || !s.add_language.text) {
            rs.alertMsg('Please fill the language code and title');
        } else {
            rs.hs('.btn_add', '.al_add');
            s.new_lang_keys = [];
            rs.lang_keys.push(s.add_language);
            a.forEach(rs.lang_keys, function(item){
                s.new_lang_keys.push({
                    lang: item.lang,
                    text: item.text
                })
            });
            rs.lang_keys = s.new_lang_keys;
            rs.settings.languages = JSON.stringify(rs.lang_keys);
            var query = 'ALTER TABLE `languages` ADD `'+ s.add_language.lang + '` TEXT NOT NULL;',
                data = {
                languages: rs.settings.languages
            };
            api.post('settings', '', data, 'add_new').then(function(){
                api.query('languages', query, 'multi_query').then(function(){
                    a.forEach(rs.languages, function(item){
                        item[s.add_language.lang] = '';
                    });
                    s.add_language = {
                        lang: '',
                        text: ''
                    };
                    settings.buildLanguages(1);
                    rs.sh('.btn_add', '.al_add');
                });
            });
        }
    };
    s.deleteLanguage = function() {
        if (!s.delete_language) {
            rs.alertMsg('Please select language for deletion');
        } else {
            rs.confirmMsg('Are you sure you want to delete this language ? The process is ireversible', function(){
                rs.hs('.btn_add', '.al_add');
                s.new_lang_keys = [];
                a.forEach(rs.lang_keys, function(item){
                    if (item.lang != s.delete_language) {
                        s.new_lang_keys.push({
                            lang: item.lang,
                            text: item.text
                        })
                    }
                });
                rs.lang_keys = s.new_lang_keys;
                rs.settings.languages = JSON.stringify(rs.lang_keys);
                var query = 'ALTER TABLE `languages` drop `'+ s.delete_language +'`;',
                    data = {
                    languages: rs.settings.languages
                };
                api.post('settings', '', data, 'add_new').then(function(){
                    api.query('languages', query, 'multi_query').then(function(){
                        a.forEach(rs.languages, function(item){
                            delete item[s.delete_language];
                        });
                        settings.buildLanguages(1);
                        rs.sh('.btn_add', '.al_add');
                    });
                });
            });
        }
    };
};
