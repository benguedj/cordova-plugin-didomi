var exec = require('cordova/exec');

exports.shareConsent = function (success, error) {
    exec(success, error, 'Didomi', 'coolMethod', []);
};
