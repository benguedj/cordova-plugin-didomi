/********* Didomi.m Cordova Plugin Implementation *******/

#import <Cordova/CDV.h>
#import <Didomi/Didomi.h>

@interface Didomi : CDVPlugin {
  // Member variables go here.
}

- (void)shareConsent:(CDVInvokedUrlCommand*)command;
@end

@implementation Didomi

- (void)shareConsent:(CDVInvokedUrlCommand*)command
{
    CDVPluginResult* pluginResult = nil;

    Didomi *didomi = [Didomi shared];
    NSString *jsDidomi = [didomi getJavaScriptForWebViewWithExtra:@""];

    if (jsDidomi) {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:jsDidomi];
    } else {
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
    }

    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

@end
