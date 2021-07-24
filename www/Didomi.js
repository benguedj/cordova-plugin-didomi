var exec = require('cordova/exec');

exports.injectConsent = function (success, error) {
    console.log("injectConsent : exec CDVDidomi - injectConsent");
    exec(success, error, 'CDVDidomi', 'injectConsent', []);
};
