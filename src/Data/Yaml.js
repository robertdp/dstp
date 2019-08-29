var yaml = require('js-yaml');

exports._safeLoad = function(target) {
  return yaml.safeLoad(target);
};
