module.exports = function(config){
  config.set({

    basePath: '',
    files: [
      '../public/js/vendor/jquery.min.js',

      '../public/js/vendor/angular.js',
      '../public/js/angular/angular-mocks.js',
      '../public/js/angular/angular-animate.min.js',
      '../public/js/angular/angular-cookies.js',
      '../public/js/angular/angular-route.min.js',
      '../public/js/angular/angular-resource.min.js',

      '../public/js/ng/constants/*.js',
      '../public/js/ng/controllers/*.js',
      '../public/js/ng/directives/*.js',
      '../public/js/ng/factory/*.js',
      '../public/js/ng/filters/*.js',
      '../public/js/ng/helpers/*.js',
      '../public/js/ng/run/*.js',
      '../public/js/ng/services/*.js',
      '../public/js/ng/init.js',

      'unit/controllers/mainCtrlSpec.js'

    ],

    urlRoot: '/__karma/',
    proxies: {
        '/' : 'http://localhost:3000/'
    },

    reporters: ['progress'],
    logLevel: config.LOG_INFO,
    singleRun: false,
    autoWatch : true,
    frameworks: ['ng-scenario', 'jasmine'],
    browsers: ['Chrome'],
    plugins: ['karma-chrome-launcher',
              'karma-jasmine']

  });
};
