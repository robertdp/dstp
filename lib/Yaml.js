'use strict';
const yaml = require('js-yaml');

export const safeLoadImpl = (target) => yaml.safeLoad(target);
