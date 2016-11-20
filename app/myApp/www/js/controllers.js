angular.module('weatherWarning.controllers', ['configuration'])

.controller('ActiveWarningCtrl', ['$scope', '$http', 'Warning', function($scope, $http, Warning) {
  $scope.warnings = "";
  fetchWarnings();

  $scope.doRefresh = function() {
    fetchWarnings();
  }

  function fetchWarnings() {
    Warning.active().then(function(result) {
      $scope.warnings = result.data;
    }, function(data) {
      console.log('error');
    }).finally(function() {
      $scope.$broadcast('scroll.refreshComplete');
    });
  };
}])

.controller('WarningHistoryCtrl', ['$scope', '$http', 'Warning', function($scope, $http, Warning) {
  $scope.warnings = "";
  fetchWarnings();

  $scope.doRefresh = function() {
    fetchWarnings();
  }

  function fetchWarnings() {
    Warning.history().then(function(result) {
      angular.forEach(result.data, function(singleWarning) {
        var indexOfLeftParenthesis = singleWarning.title.indexOf("（")
        if (indexOfLeftParenthesis < 0) {
          singleWarning.title = singleWarning.title.substr(3);
        } else {
          var additionalText = singleWarning.title.slice(indexOfLeftParenthesis + 1, -2);
          singleWarning.additional = " (" + additionalText + ")";
          singleWarning.title = singleWarning.title.substr(3, indexOfLeftParenthesis - 5);
        }
      });
      $scope.warnings = result.data;
    }, function(data) {
      console.log('error');
    }).finally(function() {
      $scope.$broadcast('scroll.refreshComplete');
    });
  };

}]);
