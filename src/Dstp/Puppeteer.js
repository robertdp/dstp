var puppeteer = require('puppeteer');

exports._launch = function(options) {
  return puppeteer.launch(options);
};

exports._newPage = function(browser) {
  return browser.newPage();
};

exports._goto = function(page, url) {
  return page.goto(url);
};

exports._close = function(browser) {
  return browser.close();
};

exports._click = function(page, selector) {
  return page.click(selector);
};

exports._screenshot = function(page, options) {
  return page.screenshot(options);
};

exports._submit = function(page, selector) {
  return page.evaluate("$(" + selector + ").parent('form').submit()");
};

exports._waitForNavigation = function(page) {
  return page.waitForNavigation();
};


exports._waitForSelector = function(page, selector) {
  return page.waitForSelector(selector);
};
