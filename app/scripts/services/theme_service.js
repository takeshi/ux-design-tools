'use strict';

/**
 * @ngdoc service
 * @name cardsortApp.theme
 * @description
 * # theme
 * Service in the cardsortApp.
 */
angular.module('cardsortApp')
  .service('themeService', function theme($http,$log) {
    var Theme = function(){      
    };

    Theme.prototype.create = function(){
      return $http.put('/app/theme');
    };
    
    Theme.prototype.findAll = function(){
      return $http.get('/app/theme');
    };

    Theme.prototype.find = function(id){
      return $http.get('/app/theme/' + id);
    };

    Theme.prototype.save = function(id,theme){
      theme = JSON.stringify(theme);
      $log.info('Theme.save',theme);
      return $http.post('/app/theme/' + id,theme,{        
      });
    };

    Theme.prototype.delete = function(id){
      return $http.delete('/app/theme/' + id);
    };

    return new Theme();
  });
