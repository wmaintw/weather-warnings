angular.module('weatherWarning.services', ['configuration'])

.factory('Warning', ['$http', 'ACTIVE_WARNING_URL', 'WARNING_HISTORY_URL',
  function($http, ACTIVE_WARNING_URL, WARNING_HISTORY_URL) {
    return {
      active: function() {
        return $http.get(ACTIVE_WARNING_URL);
      },
      history: function() {
        return $http.get(WARNING_HISTORY_URL);
      }
    };
  }]);
