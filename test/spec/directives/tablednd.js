'use strict';

describe('Directive: tablednd', function () {

  // load the directive's module
  beforeEach(module('cardsortApp'));

  var element,
    scope;

  beforeEach(inject(function ($rootScope) {
    scope = $rootScope.$new();
  }));

  it('should make hidden element visible', inject(function ($compile) {
    element = angular.element('<tablednd></tablednd>');
    element = $compile(element)(scope);
    expect(element.text()).toBe('this is the tablednd directive');
  }));
});
