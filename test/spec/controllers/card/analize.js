'use strict';

describe('Controller: CardAnalizeCtrl', function () {

  // load the controller's module
  beforeEach(module('cardsortApp'));

  var CardAnalizeCtrl,
    scope;

  // Initialize the controller and a mock scope
  beforeEach(inject(function ($controller, $rootScope) {
    scope = $rootScope.$new();
    CardAnalizeCtrl = $controller('CardAnalizeCtrl', {
      $scope: scope
    });
  }));

  it('should attach a list of awesomeThings to the scope', function () {
    expect(scope.awesomeThings.length).toBe(3);
  });
});
