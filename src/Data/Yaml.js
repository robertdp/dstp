'use strict';

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports.safeLoadImpl = void 0;

var yaml = require('js-yaml');

var safeLoadImpl = function safeLoadImpl(target) {
  return yaml.safeLoad(target);
};

exports.safeLoadImpl = safeLoadImpl;