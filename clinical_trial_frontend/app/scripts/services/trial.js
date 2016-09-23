'use strict';

/**
 * @ngdoc service
 * @name appApp.Trial
 * @description
 * # Trial
 * Factory in the appApp.
 */
angular.module('appApp')
  .factory('Trial', function ($http,$q) {
    
    var queryDeferred;
    
    function get_trial(name){
       return {'name':name};
    }    
    function get_list_of_trials(){
        return [get_trial("a1"),get_trial("b2"),get_trial("c3"),get_trial("d4")];              
    }
    var mockService = {
      query: get_list_of_trials,
      get: get_trial,
      get_similar: get_list_of_trials
    };
    
    var baseUrl = "http://127.0.0.1:8000/trials/api/trials/";
    var realService = {
      query: get_list_of_trials,
      get: function (nct){
        return $http.get(baseUrl+'individual/'+nct+"/?format=json").then(function(response) {
           return response.data;
        });
      },
      get_similar: get_list_of_trials
    };
    // Public API here
    return realService;
  });
