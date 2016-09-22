'use strict';

describe('Service: Trial', function () {

  // load the service's module
  beforeEach(module('appApp'));

  // instantiate service
  var Trial;
  beforeEach(inject(function (_Trial_) {
    Trial = _Trial_;
  }));

  it('should do something', function () {
    expect(!!Trial).toBe(true);
  });

});
