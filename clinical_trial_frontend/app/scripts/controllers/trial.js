'use strict';

/**
 * @ngdoc function
 * @name appApp.controller:TrialctrlCtrl
 * @description
 * # TrialctrlCtrl
 * Controller of the appApp
 */
angular.module('appApp')
  .controller('TrialCtrl', function ($scope,Trial,$state) {
    // $scope.trial = trial;
    // $scope.trial = Trial.get('soemthe');
    // $scope.trial = {'name':'hello'}
    $scope.similarTrials = Trial.get_similar($scope.trial);
    $scope.select = function (trial){      
      $state.go("trial",{trialId:trial.ntc_number});
    }
  });
