'use strict';

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports._safeLoad = void 0;

var yaml = require('js-yaml');

var _safeLoad = function _safeLoad(target) {
  return yaml.safeLoad(target);
};

exports._safeLoad = _safeLoad;