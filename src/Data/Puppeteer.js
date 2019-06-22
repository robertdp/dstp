'use strict';

var _interopRequireDefault = require("@babel/runtime/helpers/interopRequireDefault");

Object.defineProperty(exports, "__esModule", {
  value: true
});
exports._waitForSelector = exports._waitForNavigation = exports._submit = exports._screenshot = exports._click = exports._close = exports._goto = exports._newPage = exports._launch = void 0;

var _objectDestructuringEmpty2 = _interopRequireDefault(require("@babel/runtime/helpers/objectDestructuringEmpty"));

var puppeteer = require('puppeteer');

var _launch = function _launch(options) {
  return function () {
    return puppeteer.launch(options);
  };
};

exports._launch = _launch;

var _newPage = function _newPage(browser) {
  return function () {
    return browser.newPage();
  };
};

exports._newPage = _newPage;

var _goto = function _goto(page) {
  return function (url) {
    return function () {
      return page["goto"](url);
    };
  };
};

exports._goto = _goto;

var _close = function _close(browser) {
  return function () {
    return browser.close();
  };
};

exports._close = _close;

var _click = function _click(page) {
  return function (selector) {
    return function () {
      return page.click(selector);
    };
  };
};

exports._click = _click;

var _screenshot = function _screenshot(page) {
  return function (screenshotOptions) {
    return function () {
      return page.screenshot(screenshotOptions);
    };
  };
};

exports._screenshot = _screenshot;

var _submit = function _submit(page) {
  return function (selector) {
    return function () {
      return page.evaluate(function (_ref) {
        (0, _objectDestructuringEmpty2["default"])(_ref);
        $(selector).parent('form').submit();
      }, selector);
    };
  };
};

exports._submit = _submit;

var _waitForNavigation = function _waitForNavigation(page) {
  return function () {
    return page.waitForNavigation();
  };
};

exports._waitForNavigation = _waitForNavigation;

var _waitForSelector = function _waitForSelector(page) {
  return function (selector) {
    return function () {
      return page.waitForSelector(selector);
    };
  };
};

exports._waitForSelector = _waitForSelector;