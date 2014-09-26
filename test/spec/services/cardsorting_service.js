'use strict';

describe('Service: cardsortingService', function () {

  // load the service's module
  beforeEach(module('cardsortApp'));

  // instantiate service
  var cardsortingService;
  beforeEach(inject(function (_cardsortingService_) {
    cardsortingService = _cardsortingService_;
  }));

  it('should do something', function () {
    expect(!!cardsortingService).toBe(true);
  });

});
