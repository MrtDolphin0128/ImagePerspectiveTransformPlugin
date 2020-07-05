#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#import <Cordova/CDVPlugin.h>

@interface ImagePerspectiveTransformCordovaPlugin : CDVPlugin

- (void)TranformBase64ToBase64:(CDVInvokedUrlCommand*)command;

- (void)TranformUriToBase64:(CDVInvokedUrlCommand*)command;

- (void)TranformBase64ToUri:(CDVInvokedUrlCommand*)command;

- (void)TranformUriToUri:(CDVInvokedUrlCommand*)command;

@end
