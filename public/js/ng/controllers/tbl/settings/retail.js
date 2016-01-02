var retailCtrl = function ($scope, api, crud) {
    var s = $scope;
    s.retailClasses = {
        array: [
            {t: 'ID', c: 'id'},
            {t: 'Class name', c: 'class_name', is_p: 1},
            {t: 'Margin', c: 'margin', f: ' | number', is_p: 1, tt: "INFO: set only 'margin' or 'markup', not both", p: '%'},
            {t: 'Markup', c: 'markup', f: ' | number', is_p: 1, tt: "INFO: set only 'margin' or 'markup', not both", pp: '$'},
            {t: 'Sale', c: 'sale', f: ' | number', is_p: 1, tt: "INFO: sale product - level discount percentage", p: '%'},
            {t: 'Damage', c: 'damage', f: ' | number', is_p: 1, tt: "INFO: damage product - level discount percentage", p: '%'},
            {t: 'Whole', c: 'whole', f: ' | number', is_p: 1, tt: "INFO: Wholesale - level discount percentage", p: '%'},
            {t: 'Comp', c: 'comp', f: ' | number', is_p: 1, tt: "INFO: complementary - level discount percentage", p: '%'},
            {t: 'Employee', c: 'employee', f: ' | number', is_p: 1, p: '%'},
            {t: 'In use', c: 'status_id', is_c: 1, is_p: 0}
        ],
        tbl:         'retail_classes',
        t:           'retail_classes',
        predicate:   'predicate_rc',
        reverse:     'reverse_rc',
        all_have_predicate: 0,
        show: {},
        tables_arr: crud.tbl_arr.retail_classes
    };
    s.retailInventory = {
        array: [
            {t: 'ID', c: 'id'},
            {t: 'Product code', c: 'product_code', is_p: 1, tt: "INFO: for barcodes to print 'product codes' they need to be all numbers"},
            {t: 'Product name', c: 'product_name', is_p: 1},
            {t: 'Price', c: 'price', p: '$', f: ' | number:2', is_p: 1},
            {t: 'Qty', c: 'quantity', is_p: 1, tt: "Quantity"},
            {t: 'At', c: 'at', is_p: 1, tt: "Reorder"},
            {t: 'To', c: 'to', is_p: 1, tt: "Reorder"},
            {t: 'Tax', c: 'tax', is_s: 1, w_e: 1, d: '1', v: 'n', o: "taxable_array", is_p: 1, tt: "Is this item taxable ?"},
            {t: 'Class', c: 'class_id', is_s: 1, v: 'class_name', o: "retail_classes", is_p: 1}
        ],
        tbl:           'retail_inventory',
        t:             'retail_inventory',
        predicate:     'predicate_ri',
        reverse:       'reverse_ri',
        all_have_predicate: 0,
        show: {},
        tables_arr: crud.tbl_arr.retail_inventory,
        with_default_filter: {
            n: 'class_id',
            v: '',
            m: 'class_id'
        }
    };
    s.retailVi = {
        array: [
            {t: 'Vendor name', c: 'retail_vendor_id', is_s: 1, v: 'name', o: "retail_vendors", is_p: 1},
            {t: 'Product', c: 'retail_inventory_id', is_s: 1, v: 'product_name', o: "retail_inventory", is_p: 1},
            {t: 'Our cost', c: 'our_cost', p: '$', f: ' | number:2', is_p: 1},
            {t: 'Reorder number', c: 'reorder_number', is_p: 1},
        ],
        tbl:         'retail_vi',
        t:           'retail_vi',
        predicate:   'predicate_rvi',
        reverse:     'reverse_rvi',
        all_have_predicate: 0,
        show: {},
        tables_arr: crud.tbl_arr.retail_vi
    };

    s.rvi = {our_cost: 0};
    s.retail_vendor_mod = {status_id: 1};

    s.getRv = function(rv) {
        s.retail_vendor_mod = rv;
    };
    s.setRv = function(rv) {
        s.rvi.rv = rv;
        s.rvi.retail_vendor_id = rv.id;
    };
    s.setRi = function(ri) {
        s.rvi.ri = ri;
        s.rvi.retail_inventory_id = ri.id;
    };
    var retailViForm = $('#retailViForm');
    retailViForm.on('submit', function(){ return false });
    retailViForm.on('valid', function(){
        if (!s.rvi.rv || !s.rvi.ri) {
            rs.alertMsg('Please select vendor and product');
        } else {
            api.post('retail_vi', '', s.rvi).then(function(r){
                s.rvi.id = r.data.id;
                crud.setTableAfterSubmit(crud.tbl_arr.retail_vi, s.rvi);
                s.rvi = {
                    our_cost: 0
                };
                s.search_rv = '';
                s.search_ri = '';
            });
        }
    });
};
var importRetailDirective =
    function($compile, api, crud, $timeout){
        return {
            restrict: "E",
            compile: function(el, atts) {
                return function (scope, el, atts) {
                scope.addFile = function(t, e) {
                    var files = files || [],
                        reader = new FileReader;
                    files[t] = e.target.files;
                    if (files[t][0].name.indexOf('.csv') != -1) {
                        reader.onload = (function(theFile) {
                            return function(e) {
                                scope[t] = e.target.result;
                            }
                        })(files[t][0]);
                        reader.readAsDataURL(files[t][0]);
                    }
                };
                $timeout(function(){
                    $('#'+ atts.table +'_file').on('change', function(e){
                        scope.addFile(atts.table+'_file', e);
                    });
                }, 500);
                scope.uploadFile = function(tbl) {
                    var target = tbl+'_file';
                    if (scope[target]) {
                        rs.hs('#'+ tbl + '_btn', '#'+ tbl + '_al');
                        api.get(tbl, '', '', {file: scope[target]}, '/import-csv').then(function(r){
                            if (r.data) {
                                a.forEach(r.data, function(item){
                                    crud.setTableAfterSubmit(crud.tbl_arr[tbl], item);
                                });
                            } else {
                                rs.alertMsg('There is something wrong with your .CSV file, please check for right formatting');
                            }
                            scope[target] = '';
                            $('#'+ target).val('');
                            rs.sh('#'+ tbl + '_btn', '#'+ tbl + '_al');
                        });
                    } else {
                        rs.alertMsg("Please select .CSV file");
                    }
                };
                var template =
                    '<fieldset class="small-12">' +
                        '<legend><i class="'+ atts.icon +'"></i> '+ atts.title +'</legend>' +
                            '<div class="small-10 column"> ' +
                                '<input type="file" id="'+ atts.table +'_file" ng-model="'+ atts.table +'_file" /> ' +
                            '</div>' +
                        '<div class="small-2 column"> ' +
                            '<a class="button tiny radius" ' +
                                ' id="'+ atts.table +'_btn" ' +
                                ' onclick="a.element(this).scope().uploadFile(\''+ atts.table +'\')"> ' +
                            '<i class="fi-check">&nbsp;</i> ' +
                        '</a> ' +
                        '<img id="'+ atts.table +'_al" ' +
                            ' style="display: none;" ' +
                            ' ng-src="{{\'img/ajax.gif\' | baseUrl}}" /> ' +
                        '</div> ' +
                        '<hr /> ' +
                        '<p style="font-size: 12px;"> '+ atts.pValues +'</p> ' +
                    '</fieldset>';

                el.replaceWith($compile(template)(scope));
            }
        }
    }
};