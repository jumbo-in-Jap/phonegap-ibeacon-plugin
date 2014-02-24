//
//  IosIBeaconPlugin.m
//  iosTest
//
//  Created by 羽田 健太郎 on 2014/02/13.
//
//

#import "IosIBeaconPlugin.h"

@interface IosIBeaconPlugin()
@property(nonatomic, strong)CBPeripheralManager* peripheralManager;
@property(nonatomic, strong)NSUUID* beaconUUID;
@property(nonatomic, strong)NSString* beaconIdentifer;
@property(nonatomic)CLBeaconMajorValue beaconMajor;
@property(nonatomic)CLBeaconMinorValue beaconMinor;

@end

@implementation IosIBeaconPlugin
@synthesize peripheralManager;
@synthesize beaconUUID;
@synthesize beaconMajor;
@synthesize beaconMinor;
@synthesize beaconIdentifer;

/* arguments[uuid, major, minor, identifer] */
- (void) startAdvertiseFromJS:(CDVInvokedUrlCommand *)command{
    
    // plugin should call in background.
    [self.commandDelegate runInBackground:^{
        [self setArgumentsFromWeb:command.arguments];
        CDVPluginResult* pluginResult = nil;
        NSString* echo = [command.arguments objectAtIndex:0];
        if (echo != nil && [echo length] > 0) {
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:echo];
        } else {
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR];
        }
        
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    
        self.peripheralManager = [[CBPeripheralManager alloc] initWithDelegate:self queue:nil options:nil];
        if (self.peripheralManager.state == CBPeripheralManagerStatePoweredOn) {
            [self startAdvertising];
        }
    }];

}

- (void) stopAdvertiseFromJS:(CDVInvokedUrlCommand *)command{
    
    // plugin should call in background.
    [self.commandDelegate runInBackground:^{
        CDVPluginResult* pluginResult = nil;
        pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"success"];
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        if (self.peripheralManager.state == CBPeripheralManagerStatePoweredOn) {
            [self.peripheralManager stopAdvertising];
        }
    }];
}

-(void)setArgumentsFromWeb:(NSArray*)args{
    self.beaconUUID = [[NSUUID alloc] initWithUUIDString:args[0]];
    NSString* majorStr = [NSString stringWithFormat:@"%@",args[1]];
    self.beaconMajor = [majorStr intValue];
    NSString* minorStr = [NSString stringWithFormat:@"%@",args[2]];
    self.beaconMinor = [minorStr integerValue];
    self.beaconIdentifer = args[3];
}

- (void)startAdvertising
{
    CLBeaconRegion *beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:self.beaconUUID
                                                                           major:self.beaconMajor
                                                                           minor:self.beaconMinor
                                                                      identifier:self.beaconIdentifer];
    NSDictionary *beaconPeripheralData = [beaconRegion peripheralDataWithMeasuredPower:nil];
    [self.peripheralManager startAdvertising:beaconPeripheralData];
}



-(NSString*)getState:(CBPeripheralManager *)pm{
    NSString* state;
    switch (pm.state) {
        case CBPeripheralManagerStateUnknown:
            state = @"unknown";
            break;
        case CBPeripheralManagerStateResetting:
            state = @"resetting";
            break;
        case CBPeripheralManagerStateUnsupported:
            state = @"unsupport";
            break;
        case CBPeripheralManagerStateUnauthorized:
            state = @"unauthorize";
            break;
        case CBPeripheralManagerStatePoweredOff:
            state = @"off";
            break;
        case CBPeripheralManagerStatePoweredOn:
            state = @"on";
            break;
            
        default:
            break;
    }
    
    return state;
}

#pragma mark - peripheralManagerDelegate
- (void)peripheralManagerDidUpdateState:(CBPeripheralManager *)peripheral{
    NSString* stateStr = [self getState:peripheral];
    NSString* js = [NSString stringWithFormat:@"peripheralManagerStateChange('%@')", stateStr];
    [self.webView stringByEvaluatingJavaScriptFromString:js];
    [self startAdvertising];
}

@end
