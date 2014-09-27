'use strict';

/**
 * @ngdoc directive
 * @name cardsortApp.directive:tablednd
 * @description
 * # tablednd
 */
angular.module('cardsortApp')
  .directive('tablednd', function ($timeout) {
    return {
      restrict: 'A',
      link: function postLink(scope, element, attrs) {
        $timeout(function(){
          $(element).tableDnD();
        });
      }
    };
  });
