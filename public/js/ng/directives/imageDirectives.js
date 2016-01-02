
/**
 * image directives
 * @type {imageDirectives|*|{}}
 */
var imageDirectives = imageDirectives || {};
imageDirectives.Bootstrap = {};

/**
 * Shows image or no image
 * @param $compile
 * @param $filter
 * @param cFunc
 * @param config
 * @param crud
 * @returns {{restrict: string, compile: compile}}
 * @constructor
 */
imageDirectives.Bootstrap.ImageNoImage =
    function($compile, $filter, cFunc, config, crud){
        return {
            restrict: 'E',
            compile: function(el, atts) {
                return function (scope, el, atts) {

                    var t = atts.t,
                        n = atts.n,
                        s = atts.s,
                        st = atts.st,
                        stt = atts.stt,
                        rendered = false;

                    scope.checkImage = function(t, n, s, st, stt) {
                        if (scope[t]) {
                            if (scope[t][n]) {
                                if (scope[s]) {
                                    if (scope[s][scope[t][n]]) {
                                        if (scope[s][scope[t][n]][st]) {
                                            return true;
                                        }
                                    }
                                }
                            }
                        }
                        return false;
                    };

                    scope.noImage = function(t, n, s) {
                        crud.deleteItem(crud.tbl_arr[s], s, scope[t][n]);
                    };

                    var id = rs.uid(),
                        template =
                            '<a ng-show="checkImage(\''+t+'\', \''+n+'\', \''+s+'\', \''+st+'\', \''+stt+'\')" ' +
                              ' ng-href="{{'+s+'['+ t+'.'+n +'].'+ st +' | l}}" ' +
                              ' class="'+ (atts.fancybox ? 'fancybox-'+ t+'_'+n : '') +'"> ' +
                                '<img ng-src="{{'+s+'['+ t+'.'+n +'].'+ stt +' | l}}" alt="" />' +
                            '</a>' +
                            '<a ng-hide="checkImage(\''+t+'\', \''+n+'\', \''+s+'\', \''+st+'\', \''+stt+'\')" ' +
                              ' class="no-img" ' +
                              ' href="javascript:void(0);"> ' +
                                '<img ng-src="{{\'img/'+ (atts.image || 'no_image.png') +'\' | baseUrl}}" alt="" />' +
                            '</a>' +
                            '<img ng-src="{{\'img/ajax-big.gif\' | baseUrl}}" ' +
                                ' style="display: none;" class="loading-img" />' +
                                ((atts.ajax) ?
                                    '<div class="clearfix">&nbsp;</div>' +
                                    '<input type="file" capture="camera" accept="image/*" ' +
                                          ' id="'+ id +'" class="button alert radius tiny" />' +
                                    '<a class="right" style="margin-top: 10px; font-size: 11px;" ' +
                                      ' ng-show="checkImage(\''+t+'\', \''+n+'\', \''+s+'\', \''+st+'\', \''+stt+'\')" '+
                                      ' ng-click="noImage(\''+t+'\', \''+n+'\', \''+s+'\')">' +
                                        '<i class="fa fa-check"></i> no image' +
                                    '</a>'
                                 : '');

                    el.replaceWith($compile(template)(scope));

                    $('#'+ id).off('change').on('change', function(evt) {
                        var w = (atts.w || '200'),
                            h = (atts.h || '150'),
                            files = evt.target.files;
                        if (files[0].type.match('image.*')) {
                            var reader = new FileReader();
                            reader.onload = (function(theFile) {
                                return function(e) {
                                    var el = $('#'+id);
                                    $.ajax({
                                        url: config.api+'/save-image',
                                        method: 'post',
                                        dataType: 'json',
                                        crossDomain: true,
                                        data: {
                                            token: config.token,
                                            env: config.env,
                                            table: 'files',
                                            image_src: e.target.result,
                                            image_type: theFile.type,
                                            w: w,
                                            h: h
                                        },
                                        beforeSend: function(){
                                            el.parent().find('img').hide();
                                            el.parent().find('.loading-img').show();
                                            rs.sh('.al', '.submit');
                                        },
                                        complete: function(r) {
                                            el.parent().find('img').show();
                                            el.parent().find('.loading-img').hide();
                                            rs.hs('.al', '.submit');
                                        },
                                        error: function(r) {},
                                        success: function(r) {
                                            crud.setTableAfterSubmit(crud.tbl_arr[s], r.r.data);
                                            scope[t][n] = r.r.data.id;
                                            scope.$apply();
                                        }
                                    });
                                };
                            })(files[0]);
                            reader.readAsDataURL(files[0]);
                        }
                    });

                    if (atts.fancybox) {
                        $('.fancybox-'+ t+'_'+n).fancybox({helpers:{overlay:{locked:false}}});
                    }

                }
            }
        }
    };