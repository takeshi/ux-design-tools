'use strict';

describe('Controller: CardCardSortingCtrl', function () {

  // load the controller's module
  beforeEach(module('cardsortApp'));

  var CardCardSortingCtrl,
    scope;

  // Initialize the controller and a mock scope
  beforeEach(inject(function ($controller, $rootScope) {
    scope = $rootScope.$new();
    CardCardSortingCtrl = $controller('CardCardSortingCtrl', {
      $scope: scope
    });
  }));

  it('should attach a list of awesomeThings to the scope', function () {
    expect(scope.awesomeThings.length).toBe(3);
  });
});
