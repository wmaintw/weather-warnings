'use strict';

angular.module('configuration', [])
  .constant('ACTIVE_WARNING_URL', 'http://192.168.0.102:4567/active-warning')
  .constant('WARNING_HISTORY_URL', 'http://192.168.0.102:4567/warning-history');
