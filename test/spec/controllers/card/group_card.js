'use strict';

describe('Controller: CardGroupCardCtrl', function () {

  // load the controller's module
  beforeEach(module('cardsortApp'));

  var CardGroupCardCtrl,
    scope;

  // Initialize the controller and a mock scope
  beforeEach(inject(function ($controller, $rootScope) {
    scope = $rootScope.$new();
    CardGroupCardCtrl = $controller('CardGroupCardCtrl', {
      $scope: scope
    });
  }));

  it('should attach a list of awesomeThings to the scope', function () {
    expect(scope.awesomeThings.length).toBe(3);
  });
});
