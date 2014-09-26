'use strict';

/**
 * @ngdoc service
 * @name cardsortApp.cardsortingService
 * @description
 * # cardsortingService
 * Service in the cardsortApp.
 */
angular.module('cardsortApp')
  .service('cardsortingService', function cardsortingService($http) {

    var CardsortingService = function(){
    };

    CardsortingService.prototype.find = function(themeId,cardsortingId){
      return $http.get('/app/cardsorting/' +
       themeId + '/' + cardsortingId );
    };

    CardsortingService.prototype.save = function(themeId,cardsortingId,cardsorting){
      return $http.post('/app/cardsorting/' + themeId +'/'+ cardsortingId,JSON.stringify(cardsorting));
    };

    CardsortingService.prototype.create = function(themeId){
      return $http.put('/app/cardsorting/'+themeId);
    };

    return new CardsortingService();
  });
