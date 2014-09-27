'use strict';

/**
 * @ngdoc overview
 * @name cardsortApp
 * @description
 * # cardsortApp
 *
 * Main module of the application.
 */
angular
  .module('cardsortApp', [
    'ngAnimate',
    'ngCookies',
    'ngResource',
    'ngSanitize',
    'ngTouch',
    'ui.bootstrap',
    'ui.router',
    'ngDragDrop',
    'xeditable',
    'scrollable-table'
  ])
  .run(function(editableOptions) {
    editableOptions.theme = 'bs3'; // bootstrap3 theme. Can be also 'bs2', 'default'
  })
  .config(function ($stateProvider,$urlRouterProvider) {
    $urlRouterProvider.otherwise('/card');

    $stateProvider
      .state('main', {
        url:'',
        abstract:true,
        templateUrl: 'views/main.html',
        controller: 'MainCtrl',
        controllerAs:'mainCtrl'
      })
      .state('main.edit_card',{
        url:'/card/edit/:themeId',
        templateUrl:'views/card/edit_card.html',
        controller:'CardEditCardCtrl'
      })
      .state('main.card_list',{
        url:'/card',
        templateUrl:'views/card/card_list.html',
        controller:'CardCardListCtrl'
      }).
      state('main.card_sorting',{
        url:'/card/sorting/:themeId/:id',
        templateUrl:'views/card/card_sorting.html',
        controller:'CardCardSortingCtrl'
      })
      .state('main.analize',{
        url:'/card/analize/:themeId',
        templateUrl:'views/card/analize.html',
        controller:'CardAnalizeCtrl'
      })
      ;

  });
