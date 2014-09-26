'use strict';

/**
 * @ngdoc function
 * @name cardsortApp.controller:CardCardListCtrl
 * @description
 * # CardCardListCtrl
 * Controller of the cardsortApp
 */
angular.module('cardsortApp')
  .controller('CardCardListCtrl', function ($scope,$log,themeService,$state) {

    function init(){    
      themeService.findAll()
      .success(function(data){
        $log.info("ThemeList",data);
        $scope.themeList = data;
        $scope.init = true;
      });
    }
    init();

    $scope.playCardSorting = function(theme){
      $state.go('main.card_sorting',{
          themeId:theme.id
      });
    };

    $scope.selectTheme = function(theme){
      $state.go('main.edit_card',{
          themeId:theme.id
      });
    };

    $scope.createNewTheme = function(){
      themeService.create()
      .success(function(newTheme){
        // $scope.theme = newTheme;
        $log.info(newTheme);
        $state.go('main.edit_card',{
          themeId:newTheme.id
        });
      });
    };

    $scope.deleteTheme = function(selectedTheme){
          var themeId = selectedTheme.id;
          themeService.delete(themeId)
          .success(function(){
            init();
          });
    };

  });
