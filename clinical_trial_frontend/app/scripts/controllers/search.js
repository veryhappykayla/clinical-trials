'use strict';

/**
 * @ngdoc function
 * @name appApp.controller:SearchCtrl
 * @description
 * # SearchCtrl
 * Controller of the appApp
 */
angular.module('appApp')
  .controller('SearchCtrl', function ($scope,$state) {
    $scope.submit = function(txt){
      $state.go('trial',{'trialId':txt});
      // $scope.selectedTrial = Trial.get(txt);
      // $scope.similarTrials = Trial.get_similar($scope.selectedTrial);
    };
  });
