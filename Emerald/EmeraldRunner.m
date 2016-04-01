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
@property NSString *program;
@end

@implementation EmeraldRunner
- (void)initalize:(NSString *)host portNumber:(NSString *)port callbackObject:(ConsoleViewController *)callback program:(NSString*)program {
    
    // Create host:port string
    if(host.length != 0 || port.length != 0) {
        self.hostPort = [NSString stringWithFormat:@"%@:%@", host, port];
    } else {
        self.hostPort = @"";
    }
    
    // Set program
    if(program == nil) {
        self.program = @"";
    } else {
        self.program = program;
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
    self.task.launchPath = [Utilities getEmeraldEmx];
    
    // Set arguments
    if(![self.program  isEqual: @""]) {
        [self.task setArguments:[NSArray arrayWithObjects:@"-U",
                                 [NSString stringWithFormat:@"-R%@", self.hostPort],
                                 [NSString stringWithFormat:@"%@", self.program],
                                 nil]];
    } else {
        [self.task setArguments:[NSArray arrayWithObjects:@"-U",
                                 [NSString stringWithFormat:@"-R%@", self.hostPort],
                                 nil]];
    }

    
    // Notify callback when there is data in pipe
    [self.output readInBackgroundAndNotify];
}

- (void) run {
    // Launch emerald
    [self.task launch];
}
// Kill the current session. Called when seguing out of the view
- (void) stop {
    kill([self.task processIdentifier], SIGTERM);
    [self.task waitUntilExit];
}
@end
