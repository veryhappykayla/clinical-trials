'use strict';

/**
 * @ngdoc directive
 * @name appApp.directive:trialDetails
 * @description
 * # trialDetails
 */
angular.module('appApp')
  .directive('trialDetail', function () {
    return {
      templateUrl:'views/trialDetail.html',
      restrict: 'E',
      scope:{
        trial:'='
      },
      controller:'TrialCtrl'
    };
  });
