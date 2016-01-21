//
//  EmeraldRunner.h
//  
//
//  Created by Audun Øygard on 14/01/16.
//
//

#import <Foundation/Foundation.h>
#import "ConsoleViewController.h"

@interface EmeraldRunner : NSObject
- (void)initalize:(NSString *)host portNumber:(NSString *)port callbackObject:(ConsoleViewController *)callback program:(NSString *)program;
- (void)run;
- (void)stop;
@property NSFileHandle *output;
@property NSFileHandle *input;
@end
