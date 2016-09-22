'use strict';

/**
 * @ngdoc function
 * @name appApp.controller:MainCtrl
 * @description
 * # MainCtrl
 * Controller of the appApp
 */
angular.module('appApp')
  .controller('MainCtrl', function ($scope,Trial) {
    // $scope.trials = Trial.query();
    
    // $scope.trials = ["123","asdf","abc"];
    $scope.selectedTrial = null;
    $scope.submit = function(txt){      
      $scope.selectedTrial = Trial.get(txt);
      $scope.similarTrials = Trial.get_similar($scope.selectedTrial);
    };
  });
