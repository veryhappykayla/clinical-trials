'use strict';

describe('Controller: TrialctrlCtrl', function () {

  // load the controller's module
  beforeEach(module('appApp'));

  var TrialctrlCtrl,
    scope;

  // Initialize the controller and a mock scope
  beforeEach(inject(function ($controller, $rootScope) {
    scope = $rootScope.$new();
    TrialctrlCtrl = $controller('TrialctrlCtrl', {
      $scope: scope
      // place here mocked dependencies
    });
  }));

  it('should attach a list of awesomeThings to the scope', function () {
    expect(TrialctrlCtrl.awesomeThings.length).toBe(3);
  });
});
