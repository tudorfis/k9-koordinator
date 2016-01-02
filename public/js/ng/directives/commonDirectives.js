
/**
 * @desc: object for reusable directives
 * @auth: Todorescu Tudor
 * @date: 2014-06-20
 * @type {ngKm|*|{}}
 */
var commonDirectives = commonDirectives || {};
commonDirectives.Bootstrap = {};

/**
 * Datepicker
 * @param el
 * @param type
 * @param $compile
 * @param cFunc
 */
var renderDatepicker = function(el, type, $compile, cFunc) {
    if (!el.attr('id')) {
        el.attr('id', rs.uid());
    }
    var iconTemplate =
        '<a ng-click="focusOnId(\''+el.attr('id')+'\')">' +
            ' <img src="img/calendar.png" class="calendar" /> ' +
        '</a>' +
        '<div class="clearfix">&nbsp;</div>';
    el.after($compile(iconTemplate)(rs));
    if (type == 'us') {
        el.fdatepicker();
    } else {
        el.fdatepicker({format: 'yyyy-mm-dd'});
    }
};
commonDirectives.Bootstrap.Datepicker = function($compile, cFunc){
    return {
        restrict: 'AEC',
        link: function(s, el, atts) {
            if (el[0].tagName.toLowerCase() == 'input') {
                renderDatepicker(el, '', $compile, cFunc);
            }
        }
    }
};
commonDirectives.Bootstrap.DatepickerUs = function($compile, cFunc){
    return {
        restrict: 'AEC',
        link: function(s, el, atts) {
            if (el[0].tagName.toLowerCase() == 'input') {
                renderDatepicker(el, 'us', $compile, cFunc);
            }
        }
    }
};

/**
 * Timepicker
 * @param el
 * @param $compile
 * @param cFunc
 */
var renderTimepicker = function(el, $compile, cFunc) {
    if (!el.attr('id')) {
        el.attr('id', rs.uid());
    }
    var iconTemplate =
        '<a ng-click="focusOnId(\''+el.attr('id')+'\')">' +
            ' <img src="img/clock.png" class="clock" />' +
        '</a>' +
        '<div class="clearfix">&nbsp;</div>';

    el.after($compile(iconTemplate)(rs));
    el.timepicker({showCloseButton: true});
};
commonDirectives.Bootstrap.Timepicker = function($compile, cFunc){
    return {
        restrict: 'AEC',
        link: function(s, el, atts) {
            if (el[0].tagName.toLowerCase() == 'input') {
                renderTimepicker(el, $compile, cFunc, rs);
            }
        }
    }
};

/**
 * Colorpicker
 * @returns {{restrict: string, link: link}}
 * @constructor
 */
commonDirectives.Bootstrap.Colorpicker = function($timeout){
    return {
        restrict: 'AEC',
        link: function(s, el, atts) {
            $timeout(function(){
                el.spectrum({
                    showInitial: true,
                    showInput: true,
                    preferredFormat: 3
                });
            }, 1);
        }
    }
};

/**
 * Fancybox
 * @returns {{restrict: string, link: link}}
 * @constructor
 */
commonDirectives.Bootstrap.Fancybox = function($timeout){
    return {
        restrict: 'AEC',
        link: function(s, el, atts) {
            $timeout(function(){
                el.fancybox({helpers:{overlay:{locked:false}}});
            }, 1);
        }
    }
};

/**
 * Clearable
 * @returns {{restrict: string, link: link}}
 * @constructor
 */
commonDirectives.Bootstrap.Clearable = function(){
    function tog(v){return v?'addClass':'removeClass';}
    $(document).on('input', '.clearable', function(){
        var self = $(this);
        self[tog(this.value)]('onX');
    }).on('change', '.clearable', function(){
        var self = $(this);
        if (self.val() == '') {
            self.removeClass('onX');
        } else {
            self.addClass('onX');
        }
    });
    return {
        restrict: 'AEC',
        link: function(s, el, atts) {
            $('#MainCtrl').on('click','.onX', function() {
                $(this).removeClass('x onX').val('');
                var model = $(this).attr('ng-model'),
                    arr = model.split(".");
                if (arr.length > 1) {
                    model = arr[1];
                }
                s[model] = '';
                s.$digest();
                s.$apply();
                s.$broadcast(model);

                if (rs[model]) {
                    rs[model] = '';
                    rs.$digest();
                    rs.$apply();
                    rs.$broadcast(model);
                }
            });
        }
    }
};

/**
 * Scroll load
 * @returns {{restrict: string, link: link}}
 * @constructor
 */
commonDirectives.Bootstrap.ScrollLoad = function(){
    return {
        restrict: 'AEC',
        link: function(s, el, atts) {

            /** make scrollable **/
            if (!($('html, body').get(0).scrollHeight > $('html, body').height())) {
                var offsetHeight = document.documentElement.offsetHeight,
                    height = parseFloat(offsetHeight)+100+'px';
                $('html, body').css({height: height});
            }

            $(document).scroll(function(e) {
                if ($(window).scrollTop() >= ($(document).height() - $(window).height())*0.9) {
                    if (el.is(':visible') || s.show) {
                        if (!s[atts.processing]
                            && s[atts.newContent]
                                && !s[atts.backup].done) {
                            if (atts.params) {
                                s[atts.action](JSON.parse(atts.params));
                            } else {
                                s[atts.action]();
                            }
                        }
                    }
                }
            });
        }
    }
};


/**
 * Scroll limit
 * @returns {{restrict: string, link: link}}
 * @constructor
 */
commonDirectives.Bootstrap.ScrollLimit = function(){
    return {
        restrict: 'AEC',
        link: function(s, el, atts) {

            s.limitTo = (atts.limitTo) ? parseInt(atts.limitTo) : 10;

            s.makeScrollable = function(){
                var offsetHeight = document.documentElement.offsetHeight,
                    height = parseFloat(offsetHeight)+100+'px';
                $('html, body').css({height: height});
            };

            if (!($('html, body').get(0).scrollHeight > $('html, body').height())) {
                s.makeScrollable();
            }

            $(document).scroll(function(e) {
                if ($(window).scrollTop() >= ($(document).height() - $(window).height())*0.9) {
                    s.limitTo += ((atts.limit) ? parseInt(atts.limit) : 10);
                    s.$apply();
                    s.makeScrollable();
                }
            });
        }
    }
};

/**
 * Prefix
 * @constructor
 */
commonDirectives.Bootstrap.Prefix =
    function($compile) {
        return {
            restrict: 'E',
            compile: function(el, atts) {
                return function (s, el, atts) {
                    var template =
                        '<div class="small-'+ (atts.pl ? atts.pl : '2') +' left">' +
                            (!atts.wl ? '<label>&nbsp;</label>' : '') +
                            '<span class="prefix left column">' +
                                (atts.t ? atts.t : ('<i class="'+ atts.i +'"></i>')) +
                            '</span>' +
                        '</div>' +
                        '<div class="small-'+ (atts.dl ? atts.dl : '10') +' left">' +
                            el.html() +
                        '</div>';
                    el.replaceWith($compile(template)(s));
                }
            }
        }
    };

/**
 * Postfix
 * @constructor
 */
commonDirectives.Bootstrap.Postfix =
    function($compile) {
        return {
            restrict: 'E',
            compile: function(el, atts) {
                return function (s, el, atts) {
                    var template =
                        '<div class="small-'+ (atts.dl ? atts.dl : '10') +' left">' +
                            el.html() +
                        '</div>' +
                        '<div class="small-'+ (atts.pl ? atts.pl : '2') +' left">' +
                            (!atts.wl ? '<label>&nbsp;</label>' : '') +
                            '<span class="postfix left column">' +
                                (atts.t ? atts.t : ('<i class="'+ atts.i +'"></i>')) +
                            '</span>' +
                        '</div>';
                    el.replaceWith($compile(template)(s));
                }
            }
        }
    };

/**
 * Save button + image loading
 * @constructor
 */
commonDirectives.Bootstrap.SaveButton =
    function($compile) {
        return {
            restrict: 'E',
            compile: function(el, atts) {
                return function (s, el, atts) {
                    var template =
                            '<'+ (atts.isButton ? 'button type="submit"' : 'a') +' ' +
                                ' class="button radius right btn_'+ atts.name +
                                    (atts.class ? ' '+atts.class : '') +'" '+
                              ' ng-click="'+ atts.function +'()"> '+
                                '<i class="'+ atts.iconClass +'"></i> '+ atts.title +
                            '</'+ (atts.isButton ? 'button' : 'a') +'>' +
                            '<img ng-src="{{\'img/ajax.gif\' | baseUrl}}" ' +
                                ' class="al_'+ atts.name +' right" style="display: none;" />';
                    el.replaceWith($compile(template)(s));
                }
            }
        }
    };

/**
 * order arrow
 * @constructor
 */
commonDirectives.Bootstrap.ThOrder =
    function($compile) {
        return {
            restrict: 'A',
            compile: function(el, atts) {
                return function (s, el, atts) {
                    var template = '<th ng-click="pr = \''+ atts.t +'\'; rv=!rv" style="cursor: pointer;"'+
                                            (atts.ngShow ? ' ng-show="'+atts.ngShow+'"' : '') +'>' +
                                        '<img ng-src="{{\'img/mss_ic1.png\' | baseUrl}}" alt="" /> ' +
                                        (atts.title || '&nbsp;') +'</th>';
                    el.replaceWith($compile(template)(s));
                }
            }
        }
    };

/**
 * Print buttons
 * @constructor
 */
commonDirectives.Bootstrap.PrintButtons =
    function($compile) {
        return {
            restrict: 'E',
            compile: function(el, atts) {
                return function(s, el, atts) {
                    var template =
                        '<a data-dropdown="print_drop" class="button success radius" '+
                          ' aria-controls="print_drop" aria-expanded="false"> '+
                                ' <i class="fa fa-print"></i> Print '+
                        '</a> '+
                        '<ul id="print_drop" class="f-dropdown" data-dropdown-content aria-hidden="true" tabindex="-1"> '+
                            '<li><a ng-click="makePdf(\'screen\')" class="button tiny secondary m10"><i class="fa fa-windows"></i> On screen</a></li> '+
                            '<li><a ng-click="makePdf(\'print\')" class="button tiny secondary m10"><i class="fa fa-file-o"></i> Print</a></li> '+
                            '<li><a ng-click="makePdf(\'download\')" class="button tiny secondary m10"><i class="fa fa-arrow-down"></i> Download</a></li> '+
                        '</ul>';
                    el.replaceWith($compile(template)(s));
                    $(document).foundation('dropdown');
                }
            }
        }
    };

/**
 * Menu link
 * @constructor
 */
commonDirectives.Bootstrap.MenuLink =
    function($compile, $location) {
        return {
            restrict: 'E',
            compile: function(el, atts) {
                return function(s, el, atts) {
                    rs.isCurrentLink = function(link) {
                        return ($location.absUrl().indexOf(link) != -1);
                    };
                    rs.doLoading = function(state, link) {
                        rs.closeCurrentModal();
                        rs.hideElement('.alertMsg');
                        rs.hideElement('.confirmMsg');
                        if (state == 'main') {
                            $('#mainPage').show();
                            $('#uiView').hide();
                        } else if ($location.path().indexOf(link) == -1) {
                            $('#ajaxLoaderHuge').show();
                            $('#uiView').hide();
                            $('#mainPage').hide();
                        }
                    };
                    var template =
                        '<li ng-class="{\'active\': isCurrentLink(\''+atts.link+'\')}" '+
                                (atts.show ? ' ng-show="'+atts.show+'"' : '') + (atts.extra || '') +
                                    (atts.uiSref ? ' ui-sref="'+atts.uiSref+'" ng-click="doLoading(\''+atts.uiSref+'\', \''+ atts.link +'\')"' : '') +'>' +
                                '<a href="'+(atts.link)+'">'+ (atts.iconClass ? '<i class="'+ atts.iconClass +'"></i>' : '') +' '+ atts.title +'</a>' +
                        '</li>';
                    el.replaceWith($compile(template)(s));
                }
            }
        }
    };

/**
 * Content link
 * @constructor
 */
commonDirectives.Bootstrap.ContentLink =
    function($compile, $location) {
        return {
            restrict: 'E',
            compile: function (el, atts) {
                return function (s, el, atts) {
                    var template =
                        '<a '+ (atts.show ? ' ng-show="'+atts.show+'"' : '') + (atts.extra || '') +
                            (atts.uiSref ? ' ui-sref="'+atts.uiSref+'" ng-click="doLoading(\''+atts.uiSref+'\', \''+ atts.link +'\')"' : '') +'>' +
                                (atts.iconClass ? '<i class="'+ atts.iconClass +'"></i>' : '') +' '+ atts.title +
                        '</a>';
                    el.replaceWith($compile(template)(s));
                }
            }
        }
    };

commonDirectives.Bootstrap.AlertConfirmMessages =
    function($compile) {
        return {
            restrict: 'E',
            compile: function (el, atts) {
                return function(s, el, atts) {
                    var template =
                        '<div data-alert class="alert-box alert alertMsg" style="display: none;">'+
                            '<a class="right closeMsg" ng-click="fadeOutElement(\'.alertMsg\', \'medium\')">&times;</a> ' +
                            ' {{$root.alert_message}} '+
                        '</div>'+
                        '<div data-alert class="alert-box success confirmMsg" style="display: none;">'+
                            '{{$root.confirm_message}} '+
                            '<a class="button tiny radius" ng-click="$root.confirmFunc(); hideElement(\'.confirmMsg\')">Yes</a> '+
                            '<a class="button tiny radius" ng-click="hideElement(\'.confirmMsg\')">No</a>'+
                        '</div>';
                    el.replaceWith($compile(template)(s));
                }
            }
        }
    };














