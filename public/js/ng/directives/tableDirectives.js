
/**
 * Table directives
 * @type {tableDirectives|*|{}}
 */
var tableDirectives = tableDirectives || {};
tableDirectives.Bootstrap = {};

/**
 * Editable table
 * @param $compile
 * @param $filter
 * @param $timeout
 * @param cFunc
 * @param crud
 * @param api
 * @returns {{restrict: string, compile: compile}}
 * @constructor
 */
tableDirectives.Bootstrap.EditableTable =
    function(api, $compile, $filter, $timeout, cFunc, crud) {
        return {
            restrict: 'E',
            compile: function(el, atts) {
                return function(s, el, atts) {

                    var template = '',
                        r_el = rs.guid(),
                        ts = s[atts.ts] || rs[atts.ts],
                        t = ts.t || '';

                    s.addTbl = function(table, target, ts) {
                        tss = s[atts.ts];
                        s[tss.predicate] = 'id';
                        s[tss.reverse] = true;
                        api.get(table, '', 'last_id').then(function(r){
                            var data = r.data.el;
                                data.id =  (++r.data.max).toString();
                            if (data.status_id !== undefined) {
                                data.status_id = "1";
                            }
                            var wdf = s[ts].with_default_filter;
                            if (wdf) {
                                data[wdf.n] = (s[wdf.m]) ? s[wdf.m] : wdf.v;
                            }
                            a.forEach(s[ts].array, function(ar){
                                if (ar.d) {
                                    data[ar.c] = ar.d
                                }
                                data[ar.c] = (data[ar.c] || '');
                            });
                            if (rs.isObject(s[target])) {
                                s[target][data.id] = data;
                            } else if (rs.isArray(s[target])) {
                                s[target].unshift(data);
                            }
                            $timeout(function(){
                                s.setExtra(data.id, ts);
                                s[ts].show[data.id] = false;
                            }, 10);
                        });
                    };

                    s.deleteTbl = function(table, target, el, ts) {
                        rs.confirmMsg('Are you sure you want to delete this ?', function(){
                            var id = el.id;
                            api.delete(table, id, {}, (atts.deletePermanent?'permanent':null)).then(function(r){
                                a.forEach(s[target], function(item, k){
                                    if (item.id == id) {
                                        if (rs.isObject(s[target])) {
                                            delete s[target][id];
                                        } else if (rs.isArray(s[target])) {
                                            s[target].splice(k, 1);
                                        }
                                        return false;
                                    }
                                });
                                if (s[ts].tables_arr) {
                                    crud.deleteItem(s[ts].tables_arr, '', id, true);
                                }
                            });
                        });
                    };

                    s.updateTbl = function(table, el, ts) {
                        var id = el.id;
                        if (atts.trExtraId) {
                            el[atts.trExtraId] = s[atts.trExtraId];
                        }
                        api.post(table, id, el).then(function(r){
                            el.id = r.data.id;
                            if (s[ts].tables_arr) {
                                crud.setTableAfterSubmit(s[ts].tables_arr, el);
                            }
                        });
                    };

                    s.updateCheckboxTbl = function(table, el, column, ts) {
                        el[column] = (el[column] == 0) ? 1 : 0;
                        var id = el.id;
                        if (id) {
                            api.post(table, id, el);
                        }
                    };

                    s.setExtra = function(id, ts) {
                        a.forEach(s[ts].array, function(item){
                            var el = $('#'+item.c+id);
                            if (item.is_date && !el.hasClass('is_set')) {
                                renderDatepicker(el, '', $compile, cFunc);
                                el.addClass('is_set');
                            } else if (item.is_time && !el.hasClass('is_set')) {
                                renderTimepicker(el, $compile, cFunc);
                                el.addClass('is_set');
                            }
                        });
                    };

                    s.showHideEl = function(id, ts) {
                        s.setExtra(id, ts);
                        s[ts].show[id] =! s[ts].show[id];
                    };

                    if (atts.withAdd && atts.withAdd == 'true') {
                        template +=
                            '<div class="right" style="margin-top: -50px;">' +
                                '<a class="button radius" ng-click="addTbl(\''+ ts.tbl +'\', \''+ ts.t +'\', \''+ atts.ts +'\')">' +
                                    '<i class="fi-plus"></i> ' + (atts.addBtnText || 'Add') +
                                '</a>' +
                            '</div>';
                    }

                    template +=
                        '<h5 ng-hide="$root.ma('+ t +').length > 0" class="panel">'+ (atts.emptyMessage || '') +'</h5>' +
                        '<table ng-init="'+ts.predicate+' = \'id\'; '+ts.reverse+' = true"' +
                              ' ng-show="$root.ma('+ t +').length > 0" class="'+ atts.class +' editable-tbl">';

                    if (ts) {
                        template += '<thead>';
                        a.forEach(ts.array, function(item){
                            var th_span_html = '<span'+ (item.tt ? ' data-tooltip ' +
                                                ' aria-haspopup="true" class="has-tip" ' +
                                                ' title="'+ item.tt +'"' : '') +'>'+ item.t +'</span>';
                            if (item.is_p || ts.all_have_predicate) {
                                template += '<th ng-click="'+ ts.predicate +' = \''+ item.c +'\'; ' + ts.reverse +' =!'+ ts.reverse +'"' +
                                               ' style="cursor: pointer;">' +
                                                '<img src="img/mss_ic1.png" /> ' +
                                                    th_span_html +
                                            '</th>';
                            } else {
                                template += '<th>'+ th_span_html +'</th>';
                            }
                        });
                        template +=
                            ((atts.withDelete && atts.withDelete == 'true') ? '<th>Delete</th>' : '') +
                            '<th></th>' +
                        '</thead>';
                    }
                    
                    template +=
                        '<tbody>' +
                            '<tr ' + (atts.trSelect ? ' style="cursor: pointer;" ' +
                                 ' ng-class="{\'g-active\': '+ atts.trExtraId +' == '+ r_el +'.id}" ' +
                                 ' ng-click="'+ atts.trSelect +'('+ r_el +')" ' : '') +
                                 ' ng-init="'+ atts.ts +'.show['+ r_el +'.id] = true;" ' +
                                 ' ng-repeat="'+ r_el +' in '+
                                     (atts.filteredItems ? ' ('+atts.filteredItems+' = ('  : '') +
                                        t + ' | array '+ (atts.filter || '') +
                                        ((ts) ? ' | orderBy:'+ ts.predicate +':'+ ts.reverse : '') +
                                     (atts.filteredItems ? '))' : '') +'">';

                    a.forEach(ts.array, function(item, key){
                        if (item.is_c) {
                            template +=
                                '<td>' +
                                    '<label> ' +
                                    '<input type="checkbox" ' +
                                            'ng-click="updateCheckboxTbl(\''+ ts.tbl +'\', '+ r_el +', \''+ item.c +'\', \''+ atts.ts +'\')" ' +
                                            'ng-model="'+ r_el +'.'+ item.c +'" ' +
                                            'ng-checked="'+ r_el +'.'+ item.c +' == 1" />' +
                                    '</label>' +
                                '</td>';

                        } else if (item.is_s) {
                            var c_el = rs.guid(),
                                ngOptions = (!item.w_e ?
                                    c_el +'.id as '+ c_el +'.'+ item.v +' for '+ c_el +' in '+ item.o +
                                        ' | array ' + ((!item.we) ? ' | filter:{status_id:\'1\'} ' : '') :
                                    c_el +'_id as '+ c_el +'.'+ item.v +' for ('+ c_el +'_id,'+ c_el +') in '+ item.o),
                                value_s = '{{('+ item.o +'['+ r_el +'.'+ item.c +'].'+ item.v +' '+ (item.f || '') +') || \'-\'}}';
                            template +=
                                '<td>' +
                                    '<div style="cursor: pointer; width: 100%; height: 100%;" ' +
                                          ' ng-show="'+ atts.ts +'.show['+ r_el +'.id]" ' +
                                          ' ng-click="showHideEl('+ r_el +'.id, \''+ atts.ts +'\')">' +

                                                value_s +
                                    '</div>' +
                                    '<div ng-show="!'+ atts.ts +'.show['+ r_el +'.id]">' +
                                        '<select ng-model="'+ r_el +'.'+ item.c +'" ' +
                                               ' ng-options="'+ ngOptions +'"> ' +
                                        '</select>' +
                                    '</div>' +
                                '</td>';

                        } else if (item.is_t) {
                            var value_s = '{{('+ item.o +'['+ r_el +'.'+ item.c +'].'+ item.v +' '+ (item.f || '') +') || \'-\'}}';
                            template +=
                                '<td>' +
                                    '<div style="width: 100%; height: 100%;">'+
                                        (item.p ? item.p+' ':'') +
                                            value_s +
                                        (item.pp ? ' '+item.pp:'') +
                                    '</div>' +
                                '</td>';
                        } else {
                            var value_el = '{{('+ r_el +'.'+ item.c + (item.f || '') +') || \'-\'}}';
                            template +=
                                '<td>' +
                                    '<div style="cursor: pointer; width: 100%; height: 100%;" ' +
                                        ' ng-show="'+ atts.ts +'.show['+ r_el +'.id]" ' +
                                        ' ng-click="showHideEl('+ r_el +'.id, \''+ atts.ts +'\')">' +
                                            (item.p ? item.p+' ':'') +
                                                value_el +
                                            (item.pp ? ' '+item.pp:'') +
                                    '</div>' +
                                    '<div ng-show="!'+ atts.ts +'.show['+ r_el +'.id]">' +
                                        ((item.is_date || item.is_time)
                                            ? '<input type="text" ' +
                                                    ' ng-model="'+ r_el +'.'+ item.c +'" ' +
                                                    ' id="'+item.c+'{{'+r_el+'.id}}" ' +
                                                    ' class="'+ (item.i_class || '') +'" />'
                                            : '<textarea ng-model="'+ r_el +'.'+ item.c +'" ' +
                                                     ' style="text-align: center;"' +
                                                     ' class="'+ (item.i_class || '') +'"></textarea>') +
                                    '</div>' +
                                '</td>';
                        }
                    });

                    template +=
                        ((atts.withDelete && atts.withDelete == 'true') ?
                                '<td>' +
                                    '<i class="fa fa-2x fa-trash" style="cursor: pointer" ' +
                                        'ng-click="deleteTbl(\''+ ts.tbl +'\', \''+ ts.t +'\', '+ r_el +', \''+ atts.ts +'\')"></i>' +
                                '</td>' : '') +
                                '<td>' +
                                    '<sup style="cursor: pointer;" ' +
                                        ' ng-show="!'+ atts.ts +'.show['+ r_el +'.id]" ' +
                                        ' ng-click="'+ atts.ts +'.show['+ r_el +'.id] =! '+ atts.ts +'.show['+ r_el +'.id]"> ' +
                                           '<i class="fa fa-close"></i> ' +
                                    '</sup>' +
                                    '<a class="button tiny radius mr10" ' +
                                        'ng-show="!'+ atts.ts +'.show['+ r_el +'.id]" ' +
                                        'ng-click="'+ atts.ts +'.show['+ r_el +'.id] =! '+ atts.ts +'.show['+ r_el +'.id]; ' +
                                        'updateTbl(\''+ ts.tbl +'\', '+ r_el +', \''+ atts.ts +'\')">' +
                                        '<i class="fi-check"></i>' +
                                    '</a>' +
                                '</td>' +
                            '</tr>' +
                        '</tbody>' +
                    '</table>';

                    el.replaceWith($compile(template)(s));

                }
            }
        }
    };