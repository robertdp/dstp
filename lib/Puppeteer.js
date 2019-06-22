'use strict';
const puppeteer = require('puppeteer');

export const _launch = (options) => () => puppeteer.launch(options);

export const _newPage = (browser) => () => browser.newPage();

export const _goto = (page) => (url) => () => page.goto(url);

export const _close = (browser) => () => browser.close();

export const _click = (page) => (selector) => () => page.click(selector);

export const _screenshot = (page) => (screenshotOptions) => () => page.screenshot(screenshotOptions);

export const _submit = (page) => (selector) => () => page.evaluate(({}) => {
    $(selector).parent('form').submit();
}, selector);

export const _waitForNavigation = (page) => () => page.waitForNavigation();

export const _waitForSelector = (page) => (selector) => () => page.waitForSelector(selector);
