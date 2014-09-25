'use strict';

/**
 * @ngdoc function
 * @name cardsortApp.controller:CardEditCardCtrl
 * @description
 * # CardEditCardCtrl
 * Controller of the cardsortApp
 */
angular.module('cardsortApp')
  .controller('CardEditCardCtrl', function ($scope,themeService,$log,$stateParams,$state) {

    $scope.cards = [];

    var themeId = $stateParams.themeId;
    console.log(themeId);

    $scope.init = false;

    themeService.find(themeId)
      .success(function(data){
      $log.info("theme",data);
      $scope.theme = data;
      if(data.cards){
        $scope.cards = data.cards;        
      }else{
        $scope.cards = data.cards = [];        
      }
      $scope.init = true;
    });

    $scope.addCard = function(){
      if($scope.cardEntry === null){
        return ;         
      }
      if($scope.cardEntry === ''){
        return ;          
      }
      $scope.cards.push({desc:$scope.cardEntry});
      $scope.cardEntry = '';
    };

    $scope.addCardKeyUp = function($event){

      // $log.info($event.keyCode);
      if($event.shiftKey === false || $event.keyCode !== 13){
        return;
      }
      $scope.addCard();
      $event.preventDefault();
      $event.stopPropagation();
      return false;
    };

    function removeItem(array,item){
      var index = array.indexOf(item);
      if (index > -1) {
          array.splice(index, 1);
      }
    }

    $scope.removeCard = function(card){
      removeItem($scope.cards,card);
    };

    $scope.save = function(){
      themeService.save(themeId,$scope.theme)
      .success(function(data){
        console.log(data);
        $state.go('main.card_list');
      });
    }

  });
