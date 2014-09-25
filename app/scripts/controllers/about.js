'use strict';

/**
 * @ngdoc function
 * @name cardsortApp.controller:AboutCtrl
 * @description
 * # AboutCtrl
 * Controller of the cardsortApp
 */
angular.module('cardsortApp')
  .controller('AboutCtrl', function ($scope) {
    $scope.awesomeThings = [
      'HTML5 Boilerplate',
      'AngularJS',
      'Karma'
    ];
  });
