'use strict';

/**
 * @ngdoc function
 * @name cardsortApp.controller:MainCtrl
 * @description
 * # MainCtrl
 * Controller of the cardsortApp
 */
angular.module('cardsortApp')
  .controller('MainCtrl', function ($scope) {
    $scope.awesomeThings = [
      'HTML5 Boilerplate',
      'AngularJS',
      'Karma'
    ];
  });
