//
//  TestPlugin.h
//  iosTest
//
//  Created by 羽田 健太郎 on 2014/02/13.
//
//

#import <Cordova/CDV.h>

@interface TestPlugin : CDVPlugin

- (void) nativeFunction:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options;

@end
