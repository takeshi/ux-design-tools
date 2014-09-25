'use strict';

describe('Service: theme', function () {

  // load the service's module
  beforeEach(module('cardsortApp'));

  // instantiate service
  var theme;
  beforeEach(inject(function (_theme_) {
    theme = _theme_;
  }));

  it('should do something', function () {
    expect(!!theme).toBe(true);
  });

});
