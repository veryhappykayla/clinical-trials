'use strict';

/**
 * @ngdoc overview
 * @name appApp
 * @description
 * # appApp
 *
 * Main module of the application.
 */
angular
  .module('appApp', [
    'ngAnimate',
    'ngCookies',
    'ngResource',
    'ngRoute',
    'ngSanitize',
    'ngTouch',
    'ui.router'
  ])
  .config(function ($urlRouterProvider,$stateProvider) {
    $urlRouterProvider.otherwise('/');
    $stateProvider
      .state('trial',{
        url:'/trial/{trialId}',
        controller:function($scope,trial){
          $scope.trial = trial;
        },
        template:'<trial-detail trial="trial"></trial-detail>',        
        resolve: {
          trial: function(Trial,$stateParams){            
            return Trial.get($stateParams.trialId);
          }
        }
      })
      .state('home',{
        url:'/',
        templateUrl:'views/home.html'
      })
      .state('about',{
        templateUrl:'views/about.html',        
        url: '/about'
      });
      
      // .when('/', {
      //   templateUrl: 'views/main.html',
      //   controller: 'MainCtrl',
      //   controllerAs: 'main'
      // })
      // .when('/about', {
      //   templateUrl: 'views/about.html',
      //   controller: 'AboutCtrl',
      //   controllerAs: 'about'
      // })
      // .otherwise({
      //   redirectTo: '/'
      // });
  });
