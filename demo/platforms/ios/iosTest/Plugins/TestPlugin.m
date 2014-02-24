//
//  TestPlugin.m
//  iosTest
//
//  Created by 羽田 健太郎 on 2014/02/13.
//
//

#import "TestPlugin.h"

@implementation TestPlugin

- (void) nativeFunction:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options {
    
    //get the callback id
    NSString *callbackId = [arguments pop];
    
    NSLog(@"Hello, this is a native function called from PhoneGap/Cordova!");
    
    NSString *resultType = [arguments objectAtIndex:0];
    CDVPluginResult *result;
    
    if ( [resultType isEqualToString:@"success"] ) {
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString: @"Success :)"];
        [self writeJavascript:[result toSuccessCallbackString:callbackId]];
    }
    else {
        result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString: @"Error :("];
        [self writeJavascript:[result toErrorCallbackString:callbackId]];
    }
}

@end
