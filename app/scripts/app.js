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
    'ui.router'
  ])
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
        controller:'CardEditCardCtrl',
        controllerAs:'cardEditCardCtrl'
      })
      .state('main.card_list',{
        url:'/card',
        templateUrl:'views/card/card_list.html',
        controller:'CardCardListCtrl',
        controllerAs:'cardCardListCtrl'
      })

      ;

  });
