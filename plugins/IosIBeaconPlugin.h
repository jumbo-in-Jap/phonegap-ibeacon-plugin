//
//  IosIBeaconPlugin.h
//  iosTest
//
//  Created by 羽田 健太郎 on 2014/02/13.
//
//

#import <Cordova/CDV.h>
#import <CoreBluetooth/CoreBluetooth.h>
#import <CoreLocation/CoreLocation.h>

//#define UUID @"80D8FFC4-9807-407C-8C4D-F7AF9248B027"
//#define IDENTIFER @"jp.com.sample.iBeaconPlugin"

@interface IosIBeaconPlugin : CDVPlugin<CBPeripheralManagerDelegate>
- (void) startAdvertiseFromJS:(CDVInvokedUrlCommand *)command;

- (NSString*)getState:(CBPeripheralManager *)pm;

@end
