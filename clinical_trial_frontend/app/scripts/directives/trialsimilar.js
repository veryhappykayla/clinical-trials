'use strict';

/**
 * @ngdoc directive
 * @name appApp.directive:trialSimilar
 * @description
 * # trialSimilar
 */
angular.module('appApp')
  .directive('trialSimilar', function () {
    return {
      templateUrl: 'views/trialSimilar.html',
      restrict: 'E',
      scope:{
        trial:'='
      }   
    };
  });
