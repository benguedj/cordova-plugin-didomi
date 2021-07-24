/********* Didomi.m Cordova Plugin Implementation *******/

#import <Cordova/CDV.h>
#import <Didomi/Didomi.h>

@interface CDVDidomi : CDVPlugin {
  // Member variables go here.
}

- (void)injectConsent:(CDVInvokedUrlCommand*)command;
@end

@implementation CDVDidomi

- (void)injectConsent:(CDVInvokedUrlCommand*)command
{
    Didomi *didomi = [Didomi shared];
    NSString *jsCMP = @"window.gdprAppliesGlobally = true; (function () {function a(e) {if (!window.frames[e]) {if (document.body && document.body.firstChild) { var t = document.body; var n = document.createElement(\"iframe\"); n.style.display = \"none\"; n.name = e; n.title = e; t.insertBefore(n, t.firstChild) }else { setTimeout(function () { a(e) }, 5) }}} function e(n, r, o, c, s) {function e(e, t, n, a) { if (typeof n !== \"function\") { return } if (!window[r]) { window[r] = [] } var i = false; if (s) { i = s(e, t, n) } if (!i) { window[r].push({ command: e, parameter: t, callback: n, version: a }) } } e.stub = true; function t(a) {if (!window[n] || window[n].stub !== true) { return } if (!a.data) { return }var i = typeof a.data === \"string\"; var e; try { e = i ? JSON.parse(a.data) : a.data } catch (t) { return } if (e[o]) { var r = e[o]; window[n](r.command, r.parameter, function (e, t) { var n = {}; n[c] = { returnValue: e, success: t, callId: r.callId }; a.source.postMessage(i ? JSON.stringify(n) : n, \"*\") }, r.version) }}if (typeof window[n] !== \"function\") { window[n] = e; if (window.addEventListener) { window.addEventListener(\"message\", t, false) } else { window.attachEvent(\"onmessage\", t) } }} e(\"__tcfapi\", \"__tcfapiBuffer\", \"__tcfapiCall\", \"__tcfapiReturn\"); a(\"__tcfapiLocator\"); (function (e, tgt) {var t = document.createElement(\"script\"); t.id = \"spcloader\"; t.type = \"text/javascript\"; t.async = true; t.src = \"https://sdk.privacy-center.org/\" + e + \"/loader.js?target_type=notice&target=\" + tgt; t.charset = \"utf-8\"; var n = document.getElementsByTagName(\"script\")[0]; n.parentNode.insertBefore(t, n)})(\"539b86a7-a602-4da6-a9a5-560546b3bc2b\", \"eR9naxVm\")})();";
    NSString *jsDidomi = [didomi getJavaScriptForWebViewWithExtra:@""];
    
    if (jsDidomi) {
        NSLog(@"%@", jsDidomi);
    
        [self.webViewEngine evaluateJavaScript:[NSString stringWithFormat:@"%@ %@", jsCMP, jsDidomi] completionHandler:^(id completionId, NSError * error) {
            CDVPluginResult* pluginResult = nil;
            if(error) {
                NSLog(@"Error : %@", error);
                pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
            }  
            else {
                NSLog(@"evaluateJavaScript completed");
                pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
            }
            [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        }];
    } else {
        NSLog(@"jsDidomi is Empty");
        CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    }
}

@end
