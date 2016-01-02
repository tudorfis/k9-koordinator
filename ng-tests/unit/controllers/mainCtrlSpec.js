'use strict';

/** specs **/
describe('Unit: MainCtrl', function(){

    var mainCtrl,
        scope;

    beforeEach(module('mainApp'));

    beforeEach(inject(function ($controller, $rootScope) {
        scope = $rootScope.$new();
        mainCtrl = $controller('MainCtrl', {
            $scope : scope
        });
    }));

    var count = 0;
    afterEach(function(){
        count = 0;
    });

    it('should add one to count', function(){
        count += 1;
        expect(count).toEqual(1);
    });

    it('should check for the reset value', function(){
        expect(count).toEqual(0);
    });



    var message;
    beforeEach(function() {
        message = "hello ";
    });

    it('should say hello world', function(){
        expect(message + "world").toEqual('hello world');
    });

    it('contains passing specs', function(){
        var value = 10,
            another_value = value,
            value_str = "<h2>Header element: welcome</h2>";

        expect(value).toBe(another_value);
        expect(value).not.toBe(null);
        expect(value).toEqual(10);
        expect(value).toBeDefined();
        expect(value).toBeTruthy();
        expect(value).not.toBeFalsy();

        expect(undefined).not.toBeDefined();
        expect(undefined).toBeUndefined();
        expect(null).toBeNull();

        expect(value_str).toMatch(/welcome/);
        expect(value_str).toMatch('welcome');
        expect(value_str).not.toMatch('goodbye');
        expect([1,2,3,4]).toContain(4);
        expect([1,2,3,4]).not.toContain(12);

        expect(10).toBeLessThan(20);
        expect(10).toBeGreaterThan(2);
        expect(30.02).toBeCloseTo(30, 0);

        expect(function(){
            return a + 10;
        }).toThrow();

        expect(function(){
            return 2 + 10;
        }).not.toThrow();

        this.addMatchers({
            toBeLessThanOrEqual: function(expected){
                return this.actual <= expected;
            }
        });

        expect(2).toBeLessThanOrEqual(2);
        expect(2).toBeLessThanOrEqual(3);

    });

});