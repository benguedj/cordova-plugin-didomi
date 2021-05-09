var exec = require('cordova/exec');

exports.shareConsent = function (success, error) {
    console.log("shareConsent : exec CDVDidomi - shareConsent");
    exec(success, error, 'CDVDidomi', 'shareConsent', []);
};
