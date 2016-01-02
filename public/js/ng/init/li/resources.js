
    /** filters **/
    mainApp.filter('array',                 commonFilters.Bootstrap.Array);
    mainApp.filter('l',                     commonFilters.Bootstrap.L);
    mainApp.filter('baseUrl',               commonFilters.Bootstrap.BaseUrl);
    mainApp.filter('dobString',             commonFilters.Bootstrap.DobString);
    mainApp.filter('dobStringYear',         commonFilters.Bootstrap.DobStringYear);
    mainApp.filter('getDate',               commonFilters.Bootstrap.GetDate);
    mainApp.filter('getTime',               commonFilters.Bootstrap.GetTime);
    mainApp.filter('getDateTime',           commonFilters.Bootstrap.GetDateTime);
    mainApp.filter('filterExcludeObjIds',   commonFilters.Bootstrap.FilterExcludeObjIds);
    mainApp.filter('filterRelationship',    commonFilters.Bootstrap.FilterRelationship);
    mainApp.filter('slice',                 commonFilters.Bootstrap.Slice);
    mainApp.filter('isEmpty',               commonFilters.Bootstrap.IsEmpty);
    mainApp.filter('lastEl',                commonFilters.Bootstrap.LastEl);
    mainApp.filter('capitalize',            commonFilters.Bootstrap.Capitalize);
    mainApp.filter('htmlEscape',            commonFilters.Bootstrap.HtmlEscape);
    mainApp.filter('textToHtml',            commonFilters.Bootstrap.TextToHtml);
    mainApp.filter('filterDates',           dateFilters.Bootstrap.FilterDates);

    /** services **/
    mainApp.service('api',      apiService);
    mainApp.service('models',   modelsService);
    mainApp.service('cFunc',    cFuncService);
    mainApp.service('language', languageService);
    mainApp.service('crud',     crudService);
    mainApp.service('calc',     calcService);
    mainApp.service('cp',       cpService);
    mainApp.service('rsv',      rsvService);
    mainApp.service('dt',       dateTimeService);
    mainApp.service('pdf',      pdfService);
    mainApp.service('access',   accessService);
    mainApp.service('settings', settingsService);

    /** factory **/
    mainApp.factory('qEach', qEach);

    /** directives **/
    mainApp.directive('inputText',     inputFormDirectives.Bootstrap.InputText);
    mainApp.directive('inputTextarea', inputFormDirectives.Bootstrap.InputTextarea);
    mainApp.directive('inputSelect',   inputFormDirectives.Bootstrap.InputSelect);
    mainApp.directive('inputRadio',    inputFormDirectives.Bootstrap.InputRadio);
    mainApp.directive('inputCheckbox', inputFormDirectives.Bootstrap.InputCheckbox);
    mainApp.directive('formSubmit',    inputFormDirectives.Bootstrap.FormSubmit);
    mainApp.directive('editableTable', tableDirectives.Bootstrap.EditableTable);
    mainApp.directive('imageNoImage',  imageDirectives.Bootstrap.ImageNoImage);
    mainApp.directive('datepicker',    commonDirectives.Bootstrap.Datepicker);
    mainApp.directive('datepickerUs',  commonDirectives.Bootstrap.DatepickerUs);
    mainApp.directive('timepicker',    commonDirectives.Bootstrap.Timepicker);
    mainApp.directive('colorpicker',   commonDirectives.Bootstrap.Colorpicker);
    mainApp.directive('fancybox',      commonDirectives.Bootstrap.Fancybox);
    mainApp.directive('clearable',     commonDirectives.Bootstrap.Clearable);
    mainApp.directive('scrollLoad',    commonDirectives.Bootstrap.ScrollLoad);
    mainApp.directive('scrollLimit',   commonDirectives.Bootstrap.ScrollLimit);
    mainApp.directive('prefix',        commonDirectives.Bootstrap.Prefix);
    mainApp.directive('postfix',       commonDirectives.Bootstrap.Postfix);
    mainApp.directive('saveButton',    commonDirectives.Bootstrap.SaveButton);
    mainApp.directive('thOrder',       commonDirectives.Bootstrap.ThOrder);
    mainApp.directive('printButtons',  commonDirectives.Bootstrap.PrintButtons);
    mainApp.directive('menuLink',      commonDirectives.Bootstrap.MenuLink);
    mainApp.directive('contentLink',   commonDirectives.Bootstrap.ContentLink);
    mainApp.directive('alertConfirmMessages', commonDirectives.Bootstrap.AlertConfirmMessages);

    /** constant **/
    mainApp.constant('config', configConstant);
    mainApp.config(routerConstant);

    /** runs **/
    mainApp.run(viewsRun);
    mainApp.run(searchRun);
    mainApp.run(convertsRun);
    mainApp.run(reportsRun);
    mainApp.run(scrollUpRun);
    mainApp.run(loadingMaskRun);
    mainApp.run(foundationRun);
    mainApp.run(validatorsRun);

    /** controllers **/
    mainApp.controller('MainCtrl',      mainCtrl);
    mainApp.controller('CpCtrl',        cpCtrl);
    mainApp.controller('rBoardingCtrl', rBoardingCtrl);
    mainApp.controller('rTrainingCtrl', rTrainingCtrl);
    mainApp.controller('rDaycareCtrl',  rDaycareCtrl);
    mainApp.controller('rGroomsCtrl',   rGroomsCtrl);
    mainApp.controller('rServicesCtrl', rServicesCtrl);
    mainApp.controller('rMedsCtrl',     rMedsCtrl);
    mainApp.controller('rDietsCtrl',    rDietsCtrl);
    mainApp.controller('rRecordsCtrl',  rRecordsCtrl);

    /** rsv filters / directives **/
    mainApp.filter('filterDaycare', filterDaycare);
    mainApp.filter('filterDaycareColor', filterDaycareColor);
    mainApp.filter('filterDaycareNr', filterDaycareNr);
    mainApp.directive('weekdaysDaycare', weekdaysDaycare);
    mainApp.filter('filterTraining', filterTraining);
    mainApp.directive('servicesTable', servicesTableDirective);
    mainApp.directive('medsTable', medsTableDirective);
    mainApp.directive('dietsTable', dietsTableDirective);
    mainApp.directive('addRecordsServicesBtn', addRecordsServicesBtnDirective);
    mainApp.directive('addRecordsMedsBtn', addRecordsMedsBtnDirective);
    mainApp.directive('addRecordsDietsBtn', addRecordsDietsBtnDirective);

    /** tbl/settings/security/security-levels **/
    mainApp.filter('asterixRg',         asterixRgFilter);
    mainApp.directive('cuFieldset',     cuFieldsetDirective);

    /** tbl/settings/retail **/
    mainApp.directive('importRetail',   importRetailDirective);
    mainApp.controller('RetailCtrl',    retailCtrl);

    /** tbl/settings/my-account **/
    mainApp.controller('MyAccountCtrl',    myAccountCtrl);

    /** tbl/settings/basic-information **/
    mainApp.controller('BasicInformationCtrl',       basicInformationCtrl);

    /** tbl/settings/languages **/
    mainApp.controller('LanguageCtrl',       languagesCtrl);

    /** crud/users - trainers - groomers **/
    mainApp.directive('usersExtraCrud',   usersExtraCrudDirective);

    /** index/help **/
    mainApp.controller('HelpCtrl', helpCtrl);

    /** side **/
    mainApp.controller('PosCtrl', posCtrl);
    mainApp.controller('PendingCtrl', pendingCtrl);
    mainApp.controller('DepositsCtrl', depositsCtrl);
    mainApp.controller('ReportsCtrl', reportsCtrl);
    mainApp.controller('MessagesCtrl', messagesCtrl);
    mainApp.controller('VaccanciesCtrl', vaccanciesCtrl);
    mainApp.controller('LayoutCtrl', layoutCtrl);
    mainApp.controller('ManagerCtrl', managerCtrl);

    /** tpl ctrl **/
    mainApp.controller('clientPhone', function(){});
    mainApp.controller('clientCell',  function(){});
    mainApp.controller('clientWork',  function(){});
    mainApp.controller('clientEmerg',  function(){});
    mainApp.controller('crudPhone', function(){});
    mainApp.controller('crudCell',  function(){});
    mainApp.controller('basicInformationPhone',  function(){});
    mainApp.controller('basicInformationCell',  function(){});
    mainApp.controller('basicInformationFax',  function(){});
    mainApp.controller('myAccountPhone',  function(){});
    mainApp.controller('myAccountCell',  function(){});
    mainApp.controller('rBoardingServices',  function(){});
    mainApp.controller('rBoardingMeds',  function(){});
    mainApp.controller('rBoardingDiets',  function(){});
    mainApp.controller('rDaycareServices',  function(){});
    mainApp.controller('rDaycareMeds',  function(){});
    mainApp.controller('rDaycareDiets',  function(){});
    mainApp.controller('rTrainingServices',  function(){});
    mainApp.controller('rTrainingMeds',  function(){});
    mainApp.controller('rTrainingDiets',  function(){});
    mainApp.controller('rGroomsServices',  function(){});
    mainApp.controller('rGroomsMeds',  function(){});
    mainApp.controller('rGroomsDiets',  function(){});
    mainApp.controller('rBoardingTop',  function(){});
    mainApp.controller('rDaycareTop',  function(){});
    mainApp.controller('rTrainingTop',  function(){});
    mainApp.controller('rGroomsTop',  function(){});
    mainApp.controller('rBoardingPanel',  function(){});
    mainApp.controller('rDaycarePanel',  function(){});
    mainApp.controller('rTrainingPanel',  function(){});
    mainApp.controller('rGroomsPanel',  function(){});





