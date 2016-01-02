/**
 * Input form manipulation directives
 * @type {inputFormDirectives|*|{}}
 */
var inputFormDirectives = inputFormDirectives || {};
inputFormDirectives.Bootstrap = {};

var renderAttsTitle = function(atts, id) {
    return (!atts.noLabel ? '<label for="'+ id +'">'+ (atts.title || '&nbsp;') +'</label>' : '');
};

var renderAttsInputs = function(atts, id, without_ngModel) {
    var ngModel = (atts.ngModel ? atts.ngModel : atts.t +'.'+ atts.n),
        placeholder = (atts.placeholder !== undefined ? atts.placeholder : 'Enter '+ (atts.title ? atts.title.replace('<br />',' ').toLowerCase() : ''));
    return  ' id="'+ (atts.id || id) +'" '+ ((!without_ngModel && !atts.noModel) ? '" ng-model="'+ ngModel +'" '+'name="'+ ngModel +'" ' : '') +
            (atts.ngChange      ? ' ng-change="'+ atts.ngChange +'" ' : '') +
            (atts.ngKeyup       ? ' ng-keyup="'+ atts.ngKeyup +'" ' : '') +
            (atts.ngInit        ? ' ng-init="'+ atts.ngInit +'" ' : '') +
            (atts.ngClick       ? ' ng-click="'+ atts.ngClick +'" ' : '') +
            (atts.ngHide        ? ' ng-hide="'+ atts.ngHide +'" ' : '') +
            (atts.ngShow        ? ' ng-show="'+ atts.ngShow +'" ' : '') +
            (atts.ngClass       ? ' ng-class="'+ atts.ngClass +'" ' : '') +
            (atts.class         ? ' class="'+ atts.class +'" ' : '') +
            (atts.tabindex      ? ' tabindex="'+ atts.tabindex +'" ' : '') +
            (atts.maxlength     ? ' maxlength="'+ atts.maxlength +'" ' : '') +
            (atts.autofocus     ? ' autofocus ' : '') +
            (atts.pattern       ? ' pattern="' + atts.pattern + '" ' : '') +
            (atts.ngRequired    ? ' ng-required="'+ atts.ngRequired +'" ' : '') +
            (atts.required      ? ' required="'+ atts.required +'" ' : '') +
            (atts.ngDisabled    ? ' ng-disabled="'+ atts.ngDisabled +'" ' : '') +
            (atts.disabled      ? ' disabled="'+ atts.disabled +'" ' : '') +
            (atts.ngStyle       ? ' ng-style="'+ atts.ngStyle +'" ' : '') +
            (atts.style         ? ' style="'+ atts.style +'" ' : '') +
            (atts.value         ? ' value="'+ atts.value +'" ' : '') +
            (atts.ngValue       ? ' ng-value="'+ atts.ngValue +'" ' : '') +
            (atts.equalto       ? ' data-equalto="'+ atts.equalto +'" ' : '') +
                ' placeholder="'+ placeholder +'" ';
};

var renderAttsError = function(atts) {
    return (!atts.noError ?
                '<small class="error">' +
                    (atts.errorText ? atts.errorText : 'This field is required') +
                '</small>' : '');
};

var renderAttsTop = function(atts) {
    return (!atts.extraHtml ? '<div'+ (atts.uClass ? ' class="'+ atts.uClass +'"' : '') +'>' : '');
};

var renderAttsBottom = function(atts) {
    return (!atts.extraHtml ? '</div>' : '');
};


/**
 * Input text directive
 * @param $compile
 * @returns {{restrict: string, compile: compile}}
 * @constructor
 */
inputFormDirectives.Bootstrap.InputText =
    function($compile) {
        return {
            restrict: 'E',
            compile: function(el, atts) {
                return function (s, el, atts) {
                    var id = rs.uid(),
                        temp =
                            renderAttsTop(atts) +
                                renderAttsTitle(atts, id) +
                                '<input type="'+ (atts.type || 'text') +'" '+ renderAttsInputs(atts, id, 0) +' />' +
                                    renderAttsError(atts) +
                            renderAttsBottom(atts);
                    el.replaceWith($compile(temp)(s));
                }
            }
        }
    };

/**
 * Input textarea directive
 * @param $compile
 * @returns {{restrict: string, compile: compile}}
 * @constructor
 */
inputFormDirectives.Bootstrap.InputTextarea =
    function($compile) {
        return {
            restrict: 'E',
            compile: function(el, atts) {
                return function (s, el, atts) {
                    var id = rs.uid(),
                        temp =
                            renderAttsTop(atts) +
                                renderAttsTitle(atts, id) +
                                '<textarea '+ renderAttsInputs(atts, id, 0) +'></textarea>' +
                                renderAttsError(atts) +
                            renderAttsBottom(atts);
                    el.replaceWith($compile(temp)(s));

                }
            }
        }
    };



/**
 * Input select directive
 * @param $compile
 * @returns {{restrict: string, compile: compile}}
 * @constructor
 */
inputFormDirectives.Bootstrap.InputSelect =
    function($compile) {
        return {
            restrict: 'E',
            compile: function(el, atts) {
                return function (s, el, atts) {

                    var id = rs.uid(),
                        guid = rs.guid(),
                        ngOptions = '',
                        ngId = (atts.ngId || 'id'),
                        ngV = (atts.ngV) || 'v',
                        ngSelected = 0;

                   //(atts.customSelect) ?  ngOptions = guid +'_'+ngId+' as '+ guid +'.'+ ngV +' for ('+ guid +'_'+ngId+','+ guid +') in '+ atts.s;

                    if (atts.ngOptions) {
                        ngOptions = atts.ngOptions;
                    } else {
                        ngOptions = guid + '.'+ngId+' as ' + guid + '.' + ngV + ' for ' + guid + ' in ' + atts.s +
                                        ' | array '+ (atts.filterSelect ? ' | '+ atts.filterSelect : '');
                    }

                    rs.$watch('done', function(){
                        if (rs.done) {
                            var sl = (atts.s ? (atts.s).replace('$root.', '') : '');
                            if (rs[sl] && rs.ma(rs[sl])[0] && rs.ma(rs[sl])[0].status_id) {
                                ngOptions += ' | filter:{status_id:1} ';
                            }
                            var temp =
                                renderAttsTop(atts) +
                                    renderAttsTitle(atts, id) +
                                        '<select ng-options="'+ ngOptions +'" ' +
                                            ' ng-selected="'+ ngSelected +'" '+
                                            renderAttsInputs(atts, id, 0) +'>'+
                                            '<option value="">'+ (atts.lineValue || '-') +'</option>' +
                                        '</select>' +
                                    renderAttsError(atts) +
                                renderAttsBottom(atts);
                            el.replaceWith($compile(temp)(s));
                        }
                    });
                }
            }
        }
    };

/**
 * Input radio
 * @param $compile
 * @returns {{restrict: string, compile: compile}}
 * @constructor
 */
inputFormDirectives.Bootstrap.InputRadio =
    function($compile){
        return {
            restrict: 'E',
            compile: function(el, atts) {
                return function (s, el, atts) {
                    var id = rs.uid(),
                        temp =
                            renderAttsTop(atts) +
                                '<label> ' +
                                    '<input type="radio" value="'+ atts.v +'" '+
                                         renderAttsInputs(atts, id, 0) + ' /> '  +
                                    (atts.title || '$nbsp;') +
                                '</label>' +
                            renderAttsBottom(atts);
                    el.replaceWith($compile(temp)(s));
                }
            }
        }
    };

/**
 * Input checkbox
 * @param $compile
 * @returns {{restrict: string, compile: compile}}
 * @constructor
 */
inputFormDirectives.Bootstrap.InputCheckbox =
    function($compile){
        return {
            restrict: 'E',
            compile: function(el, atts) {
                return function (s, el, atts) {
                    var id = rs.uid(),
                        ngModel = (atts.ngModel ? atts.ngModel : atts.t +'.'+ atts.n),
                        temp =
                            renderAttsTop(atts) +
                                '<label> ' +
                                    '<input type="checkbox" ' +
                                           ' ng-model="'+ ngModel +'" ' +
                                           ' name="'+ ngModel +'" ' +
                                           ' ng-checked="('+ngModel+' === true) || ('+ngModel+' === \'true\') ' +
                                                        ' || ('+ngModel +' === 1) || ('+ngModel +' === \'1\')" ' +
                                            renderAttsInputs(atts, id, 1) +' /> ' +
                                        (atts.title || '&nbsp;') +
                                '</label>' +
                            renderAttsBottom(atts);
                    el.replaceWith($compile(temp)(s));
                }
            }
        }
    };


/**
 * Form submission directive
 * @param api
 * @param $compile
 * @param $filter
 * @param crud
 * @returns {{restrict: string, compile: compile}}
 * @constructor
 */
inputFormDirectives.Bootstrap.FormSubmit =
    function(api, $compile, $filter, crud) {
        return {
            restrict: 'AEC',
            compile: function(el, atts) {
                return function(s, el, atts) {

                    s[atts.t] = s[atts.t] || {};

                    var id = (atts.id || rs.uid());
                    el.attr('id', id);
                    var jEl = $('#'+ id);

                    if (atts.submitBtn) {
                        var submitBtn =
                                '<div class="right">' +
                                    '<button type="submit" class="submit button radius" style="font-weight: bold;">' +
                                        '<i class="fa fa-check-square"> '+ (atts.submitBtnText ? atts.submitBtnText : '') +'</i>' +
                                    '</button>' +
                                    '<img class="al" src="'+ $filter('baseUrl')('img/ajax.gif') +'" style="display: none;" />' +
                                '</div>',
                            fieldset = jEl.find('fieldset:last').last();
                        if (fieldset.length > 0) {
                            fieldset.append(submitBtn);
                        } else {
                            jEl.append(submitBtn);
                        }
                    }

                    if (atts.hideShowAlContent) {
                        var al_form_html =
                                '<div class="al_form small-12" style="display: none;">' +
                                    '<img src="' + $filter('baseUrl')('img/ajax-big.gif') + '" alt="" />' +
                                '</div>';
                        jEl.before(al_form_html);
                    }

                    var submitFunc = function(){
                        var post = {};
                        if (rs.post[atts.tPost]) {
                            post = rs.post[atts.tPost];
                        }
                        else if (rs.post[atts.t]) {
                            post = rs.post[atts.t];
                        }
                        else if (rs.post[atts.table]) {
                            post = rs.post[atts.table];
                        }
                        else if (rs.post) {
                            post = rs.post;
                        }

                        if (post.beforeSubmit) {
                            post.beforeSubmit();
                        }

                        if (!post.break_submit) {

                            if (atts.hideShowAlSubmit) {
                                jEl.find('.al').show();
                                jEl.find('.submit').hide();
                            } else if (atts.hideShowAlContent) {
                                jEl.parent().find('.al_form').show();
                                jEl.hide();
                            }

                            var data = (!rs.isEmpty(s[atts.t]) ? s[atts.t] : rs[atts.t]),
                                table = (atts.table || atts.t),
                                id = (data.id || null),
                                method = post.method || '';

                            api.post(table, id, data, method).then(function (r) {
                                s[atts.t].id = r.data.id;
                                if (post.afterSubmit) {
                                    post.afterSubmit();
                                }
                                if (atts.setTableAfterSubmit) {
                                    crud.setTableAfterSubmit(crud.tbl_arr[table], data);
                                }
                                if (atts.hideShowAlSubmit) {
                                    jEl.find('.al').hide();
                                    jEl.find('.submit').show();
                                } else if (atts.hideShowAlContent) {
                                    jEl.parent().find('.al_form').hide();
                                    jEl.show();
                                }
                            });
                        }
                    };

                    /** make validation **/
                    if (atts.abide) {
                        $(document).foundation('abide');
                        jEl.on('submit', function(){ return false });
                        jEl.on('valid', submitFunc);
                    } else {
                        jEl.on('submit', submitFunc);
                    }

                }
            }
        };
    };
