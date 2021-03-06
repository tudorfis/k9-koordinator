module.exports = function(config) {
    config.set({
        basePath: '',
        frameworks: ['ng-scenario'],
        files: [
            'e2e/testScenario.js'
        ],
        exclude: [],
        port: 8080,
        logLevel: config.LOG_INFO,
        autoWatch: false,
        browsers: ['Chrome'],
        singleRun: false,
        urlRoot: '/_karma_/',
        proxies: {
            '/': 'http://localhost/k9'
        }
    });
};