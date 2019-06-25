'use strict';
const yaml = require('js-yaml');

export const _safeLoad = (target) => () => yaml.safeLoad(target);
