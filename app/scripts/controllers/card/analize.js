'use strict';

/**
 * @ngdoc function
 * @name cardsortApp.controller:CardAnalizeCtrl
 * @description
 * # CardAnalizeCtrl
 * Controller of the cardsortApp
 */
angular.module('cardsortApp')
  .controller('CardAnalizeCtrl', function ($scope,$stateParams,cardsortingService) {
    var themeId = $stateParams['themeId'];
    
    cardsortingService.getAnalize(themeId)
      .success(function(data){
        $scope.data = data;
      });

  });
