'use strict';

/**
 * @ngdoc function
 * @name cardsortApp.controller:CardCardSortingCtrl
 * @description
 * # CardCardSortingCtrl
 * Controller of the cardsortApp
 */
angular.module('cardsortApp')
  .controller('CardCardSortingCtrl', function ($scope,$stateParams,$timeout,cardsortingService,$state) {
    var themeId = $stateParams.themeId;
    var id = $stateParams.id;
    cardsortingService.find(themeId,id)
    .success(function(data){
      $scope.userId = data.userId;
      $scope.theme = data.theme;
      $scope.unselectedCards = data.unselectedCards;
      $scope.groups = data.groups;
    });
    $scope.dropItems = [];

    $scope.groups = [];
    $scope.unselectedCards = [];

    function removeCard(card){
      var array = $scope.unselectedCards;
      var index = -1;
      array.forEach(function(item,i){
        if(item.id == card.id){
          index = i;
        }
      });
      if (index > -1) {
          array.splice(index, 1);
      }
    }

    $scope.dropCard = function($event,addCard){
      // dropGroup = false;      
        // if(dropGroup === false)
        // var cardIndex = $($event.toElement).attr('data-card');
        // var groupIndex = $($event.target).attr('data-group');
        console.log($event,addCard);

        var newGroup = {
            title:null,
            cards:[addCard]
            };
        newGroup.index = $scope.groups.length;
        $scope.groups.push(newGroup);        
    };

    $scope.dropSccess = function(array,index){
      array.splice(index,1);
    };
    $scope.deleteGroup = function(groups,index){
      var group = groups[index];

      group.cards.forEach(function(card){
        $scope.unselectedCards.push(card);
      });

      groups.splice(index,1);

    }

    $scope.dropCardToGroup = function($event,group,card){
      console.log($event,group,card);
      group.cards.push(card);
    };

    $scope.addCard = function(){
      if($scope.newCard == null){
        return;
      }
      if($scope.newCard == ''){
        return;
      }

      $scope.unselectedCards.push({
        desc:$scope.newCard
      });
      $scope.newCard = '';
    };

    $scope.doNothing = function(){
    };

    $scope.sendResult = function(){
      var groups = $scope.groups;
      cardsortingService.save(
        themeId,
        id,{
        userId:$scope.userId,
        theme:$scope.theme,
        groups:$scope.groups,
        unselectedCards:$scope.unselectedCards
      }).success(function(){
        $state.go('main.card_list');
      });
    };
    
  });
