'use strict';

describe('Controller: CardCardListCtrl', function () {

  // load the controller's module
  beforeEach(module('cardsortApp'));

  var CardCardListCtrl,
    scope;

  // Initialize the controller and a mock scope
  beforeEach(inject(function ($controller, $rootScope) {
    scope = $rootScope.$new();
    CardCardListCtrl = $controller('CardCardListCtrl', {
      $scope: scope
    });
  }));

  it('should attach a list of awesomeThings to the scope', function () {
    expect(scope.awesomeThings.length).toBe(3);
  });
});
