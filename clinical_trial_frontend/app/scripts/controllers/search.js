'use strict';

/**
 * @ngdoc function
 * @name appApp.controller:SearchCtrl
 * @description
 * # SearchCtrl
 * Controller of the appApp
 */
angular.module('appApp')
  .controller('SearchCtrl', function ($scope,$rootScope,$state) {    
    $scope.submit = function(txt){
      $scope.failedToLoad = false;
      $state.go('trial',{'trialId':txt});      
    };
    $rootScope.$on('$stateChangeError', function (event, toState, toParams, fromState, fromParams, error) {
      // console.error(toState);
      if(toState.name == "trial"){
        $scope.failedToLoad = true;        
      }            
    });
  });
