#import <Cordova/CDV.h>

@interface FileWriter : CDVPlugin

// This will return the file contents in a JSON object via the getFileContents utility method
- (void) cordovaGetFileContents:(CDVInvokedUrlCommand *)command;

// This will accept a String and call setFileContents to persist the String on to disk
- (void) cordovaSetFileContents:(CDVInvokedUrlCommand *)command;

#pragma mark - Util_Methods

// Pure native code to persist data
- (void) setFileContents;

// Native code to load data from disk and return the String.
- (NSString *) getFileContents;

@end