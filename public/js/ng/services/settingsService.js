
/**
 * settings service
 */
var settingsService = function(api, cFunc, access, $filter) {

    var self = this;

    this.doAll = function() {
        self.buildSettings();
        self.buildSiteLogo();
        self.buildUsersRoles();
        self.buildIdentityMessages();
        self.buildSecurityLevels();
        self.buildExtra();
        self.buildPromotions();
        self.buildLanguages();
        self.buildDso();
        self.buildFoundationPatterns();
    };
    
    /**
     * build settings
     */
    this.buildSettings = function() {
        rs.status = {
            1: {id: 1, v: 'active'},
            2: {id: 2, v: 'inactive'}
        };
        rs.countries = {
            1: {id: 1, v: 'United states'},
            2: {id: 2, v: 'Australia'}
        };
        rs.modifiers = {
            1: {id: 1, v: '- %'},
            2: {id: 2, v: '- $'}
        };
        rs.hours_rounding_nr = {
            1: {id: 1, v: 'Round UP to the nearest hour'},
            2: {id: 2,v: 'Round DOWN to the nearest hour'},
            3: {id: 3,v: "Don't round. Use fractions"},
            4: {id: 4,v: "Don't round. Use fractions"},
            5: {id: 5,v: "Round UP to the nearest half hour"},
            6: {id: 6,v: "Round DOWN to the nearest half hour"}
        };
        rs.check_groups_limit_nr = {
            1: {id: 1,v: "Don't check (fastest)"},
            2: {id: 2,v: "Check and ask to confirm if overbooking"},
            3: {id: 3,v: "Check and never allow overbooking"}
        };
        rs.seasons = {
            1: {id: 1, v: 'Low season'},
            2: {id: 2, v: 'High season'},
            3: {id: 3, v: 'Christmas season'}
        };
        rs.default_search_options = {
            1: {id: 1, v: 'Membership'},
            2: {id: 2, v: 'Phone'},
            3: {id: 3, v: 'Pet name'},
            4: {id: 4, v: 'Pet ID'},
            5: {id: 5, v: 'Pet Breed'},
            6: {id: 6, v: 'Client name'},
        };
        rs.yes_no = {
            0: {id: 0, v: 'No'},
            1: {id: 1, v: 'Yes'},
            true: {v: 'Yes'},
            false: {v: 'No'},
        };
        rs.payment_status = {
            1: {id: 1, v: 'Processed'},
            2: {id: 2, v: 'Pending'},
            3: {id: 3, v: 'Refunded'}
        };
        rs.days = ['mon', 'tue', 'wed', 'thu', 'fri', 'sat', 'sun'];
        rs.classes_discounts = ['sale', 'damage', 'whole', 'comp', 'employee'];
        rs.preffered_phone = {
            1: {id: 1, v: 'Home'},
            2: {id: 2, v: 'Cell'},
            3: {id: 3, v: 'Emergency'},
            4: {id: 4, v: 'Work'}
        };
        rs.tel_formats = {
            1: {
                id: 1,
                v: '(123) 456-7890',
                error_text: 'Please enter this format "(123) 456-7890"',
                r: (new RegExp("\\([0-9]{3}\\)\\s[0-9]{3}\\-[0-9]{4}"))
            },
            2: {
                id: 2,
                v: '0740 815174',
                error_text: 'Please enter this format "0740 815174"',
                r: (new RegExp("0+7+[0-9]{2}\\s[0-9]{6}"))
            }
        };
        rs.md_select = {
            1: {id: 1, v: 'Medications'},
            2: {id: 2, v: 'Diets'}
        };
        rs.rs_schedule = [
            {n: 'Schedule always', v:'schedule_always'},
            {n: 'Only boarding', v:'only_boarding'},
            {n: 'Only daycare', v:'only_daycare'}
        ];
        rs.taxable_array = {
            0: {id: 0, n:'Non-Taxable'},
            1: {id: 1, n:'Taxable'}
        };
        rs.default_retail_level = {
            1: {id: 1, v: 'Sale'},
            2: {id: 2, v: 'Damage'},
            3: {id: 3, v: 'Whole'},
            4: {id: 4, v: 'Comp'},
        };
        rs.cc_types = {
            1: {id: 1, v: 'Visa'},
            2: {id: 2, v: 'Master Card'},
            3: {id: 3, v: 'Discover Card'},
            4: {id: 4, v: 'American Express'},
        };
        rs.cc_exp_month = {
            1: {id: 1, v: '01 Jan'},
            2: {id: 2, v: '02 Feb'},
            3: {id: 3, v: '03 Mar'},
            4: {id: 4, v: '04 Apr'},
            5: {id: 5, v: '05 May'},
            6: {id: 6, v: '06 Jun'},
            7: {id: 7, v: '07 Jul'},
            8: {id: 8, v: '08 Aug'},
            9: {id: 9, v: '09 Sep'},
            10: {id: 10, v: '10 Oct'},
            11: {id: 11, v: '11 Nov'},
            12: {id: 12, v: '12 Dec'},
        };
        rs.cc_exp_year = [];
        var c_year = rs.getYear();
            f_year = pF(c_year) - 7;
            t_year = pF(c_year) + 10;
        for (i = f_year; i <= t_year; i++) {
            rs.cc_exp_year.push(i);
        }
        rs.boarding_charges = [
            {n: 'Charge by runtype', v:'charge_by_runtype'},
            {n: 'Charge by petsizes', v:'charge_by_petsizes'}
        ];
    };

    this.buildSiteLogo = function() {
        rs.site_logo = (rs.files[rs.settings.image_logo_id] ?
            $filter('l')(rs.files[rs.settings.image_logo_id].path_thumb) : $filter('baseUrl')('img/paw.png'));
    };

    this.buildDso = function() {
        if (rs.general_features[20].v) {
            rs.default_search_options[1] = {id: 1, v: 'Membership'};
        } else {
            delete rs.default_search_options[1];
        }
        if (rs.general_features[21].v) {
            rs.default_search_options[4] = {id: 4, v: 'Pet ID'};
        } else {
            delete rs.default_search_options[4];
        }
        if (rs.general_features[22].v) {
            rs.default_search_options[5] = {id: 5, v: 'Pet Breed'};
        } else {
            delete rs.default_search_options[5];
        }
    };

    /**
     * build languages
     */
    this.buildLanguages = function(without_lang_keys) {
        rs.l_keys = {};
        var l_array = rs.unbind(rs.languages);
        a.forEach(l_array, function(i){
            rs.l_keys[i.k] = i;
        });
        if (!without_lang_keys) {
            rs.lang_keys = JSON.parse(rs.settings.languages);
        }
    };

    /**
     * build users
     */
    this.buildUsersRoles = function() {
        var role_ids = [];
        a.forEach(rs.role, function(item, id){
            rs[item.n+'s'] = {};
            role_ids.push(id);
        });
        a.forEach(rs.users, function(item, id){
            item.v = item.first_name+' '+item.last_name;
            if (role_ids.indexOf((item.role_id).toString()) !== -1) {
                var role_item = rs.role[item.role_id];
                rs[role_item.n+'s'][id] = item;
            }
        });
    };

    /**
     * build messages
     */
    this.buildIdentityMessages = function() {
        rs.identity.messages = {
            inbox: [],
            sent: [],
            deleted: [],
            unread: 0
        };
        a.forEach(rs.messages, function(item, id){
            if (item.sent_user_id == rs.identity.id && !item.is_deleted) {
                rs.identity.messages.sent.push(item);
            } else if (item.sent_user_id == rs.identity.id && item.is_deleted) {
                rs.identity.messages.deleted.push(item);
            }
            if (item.inbox_user_id == rs.identity.id && !item.is_deleted) {
                rs.identity.messages.inbox.push(item);
            } else if (item.inbox_user_id == rs.identity.id && item.is_deleted) {
                rs.identity.messages.deleted.push(item);
            }
            if (item.inbox_user_id == rs.identity.id && !item.is_read && !item.is_deleted) {
                rs.identity.messages.unread += 1;
            }
        });
    };

    /**
     * build security levels
     */
    this.buildSecurityLevels = function() {
        var security_levels = {};
        a.forEach(rs.sl_cp, function(sl_cp, sl_cp_id){
            if (!security_levels[sl_cp.role_id]) {
                security_levels[sl_cp.role_id] = {};
            }
            var sl_type = rs.security_levels[sl_cp.sl_id].t;
            if (!security_levels[sl_cp.role_id][sl_type]) {
                security_levels[sl_cp.role_id][sl_type] = {};
            }
            var sl_n = rs.security_levels[sl_cp.sl_id].n,
                sl_data = {
                    id: sl_cp_id,
                    n: sl_n,
                    v: sl_cp.v,
                    title: rs.security_levels[sl_cp.sl_id].title
                };
            security_levels[sl_cp.role_id][sl_type][sl_n] = {};
            security_levels[sl_cp.role_id][sl_type][sl_n] = sl_data;
        });
        rs.security_levels_cp = security_levels;
    };

    /** build extra **/
    this.buildExtra = function() {
        rs.base_type_filter = [
            {n: rs.grooming_options[5].v, v: 1},
            {n: rs.grooming_options[6].v, v: 2}
        ];
        rs.base_type_array = {
            1: {n: rs.grooming_options[5].v, v: 1},
            2: {n: rs.grooming_options[6].v, v: 2},
        };
    };

    this.buildPromotions = function() {
        var cdt_time = new Date().getTime();
        a.forEach(rs.promotions, function(item, k){
            var p_time = new Date(item.expiration_date).getTime();
            if (p_time <= cdt_time) {
                delete rs.promotions[k];
            } else {
                if (item.promotion_name.indexOf('pts') == -1) {
                    item.promotion_name += ' ['+item.points+' pts.]';
                }
            }
        })
    };

    this.buildFoundationPatterns = function() {
        var patterns = {
                us_date: /[0-9]{2}\/[0-9]{2}\/[0-9]{4}/
            },
            pfid = rs.user_interface_settings.phone_format_id,
            cfid = rs.user_interface_settings.cell_format_id,
            ffid = rs.user_interface_settings.fax_format_id;
        if (pfid && rs.tel_formats[pfid]) {
            patterns = a.extend(patterns, {
                phone_number: rs.tel_formats[pfid].r
            });
        }
        if (pfid && rs.tel_formats[cfid]) {
            patterns = a.extend(patterns, {
                cell_number: rs.tel_formats[cfid].r
            });
        }
        if (ffid && rs.tel_formats[ffid]) {
            patterns = a.extend(patterns, {
                fax_number: rs.tel_formats[ffid].r
            });
        }
        $(document).foundation({
            abide: {
                patterns: patterns
            }
        });
    }

};
