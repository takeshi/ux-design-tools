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


    d3.select(".d3").selectAll("p")
        .data([4, 8, 15, 16, 23, 42])
      .enter().append("p")
        .text(function(d) { return "I’m number " + d + "!"; });
    var svg = d3.select("svg");

    var circle = svg.selectAll("circle")
        .data([32, 57, 112, 293]);

    var circleEnter = circle.enter().append("circle");

    circleEnter.attr("cy", 60)
      .attr("cx", function(d, i) { return i * 100 + 30; })
      .attr("r", function(d) { return Math.sqrt(d); });


    $scope.num = 10;


    $scope.update = function(){

      function tx(d){
          return 'hello ' + d;
      }
      var data = [];
      for(var i = 0;i<$scope.num ;i++){
        data.push(i);
      }

      var p = d3.select(".d3").selectAll("p")
          .data(data)
          .text(tx);

      var x = d3.scale.linear()
          .domain([0, d3.max(data)])
          .range([0, 420]);

      // // Enter…
      p.enter().append("p")

          .text(tx)
          .style("background-color", "white")      

          .transition()
            .duration(1000)
            .delay(function(d, i) { return i * 50; })
            .style("color", "white")      
            .style("background-color", "blue")
            .style("width",function(d){
              return x(d)  + 'px';
            });


      // // Exit…
      p.exit().remove();

    };
  });
