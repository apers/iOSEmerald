//
//  EmeraldRunner.m
//  
//
//  Created by Audun Øygard on 14/01/16.
//
//

#import "EmeraldRunner.h"
#import "NSTask.h"

@import Foundation;

@interface EmeraldRunner ()
@property NSString *hostPort;
@property NSPipe *inputPipe;
@property NSPipe *outputPipe;
@property NSTask *task;
@end

@implementation EmeraldRunner
- (void)initalize:(NSString *)host portNumber:(NSString *)port callbackObject:(ConsoleViewController *)callback{
    
    // Create host:port string
    if(host.length != 0 || port.length != 0) {
        self.hostPort = [NSString stringWithFormat:@"%@:%@", host, port];
    } else {
        self.hostPort = @"";
    }
    
    // Initalize pipes
    self.inputPipe = [NSPipe pipe];
    self.outputPipe = [NSPipe pipe];
    self.output = [self.outputPipe fileHandleForReading];
    self.input = [self.inputPipe fileHandleForWriting];
    
    // Add callback to console view, for when there is output on pipe
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:callback selector:@selector(notifiedForOutput:) name:NSFileHandleReadCompletionNotification object:self.output];
    
    // Create task and assign pipes
    self.task = [[NSTask alloc] init];
    [self.task setStandardInput:self.inputPipe];
    [self.task setStandardOutput:self.outputPipe];
    
    // Set binary to launch (emx)
    self.task.launchPath = @"/bin/emx";
    
    // Set arguments
    [self.task setArguments:[NSArray arrayWithObjects:@"-U",
                             [NSString stringWithFormat:@"-R%@", self.hostPort],
                             nil]];
    
    // Notify callback when there is data in pipe
    [self.output readInBackgroundAndNotify];
}

- (void) run {
    // Launch emerald
    [self.task launch];
    
    // Wait for exit or comment out for async running
    // [self.task waitUntilExit];
}

- (void) stop {
    [self.task interrupt];
}
@end
