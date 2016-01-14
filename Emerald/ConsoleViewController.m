//
//  ConsoleViewController.m
//  
//
//  Created by Audun Øygard on 14/01/16.
//
//

#import "ConsoleViewController.h"
#import "Console.h"
#import "EmeraldRunner.h"

@interface ConsoleViewController ()
@property (weak, nonatomic) IBOutlet Console *console;
@property EmeraldRunner *runner;
- (IBAction)unwindConsole:(UIStoryboardSegue*)unwindSegue;
@end
@implementation ConsoleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Allocate runner
    self.runner = [[EmeraldRunner alloc] init];
    
    // Clear console
    [self.console clear];

    // Initalize runner
    //[self.runner initalize:@"pers.link" portNumber:@"123123" callbackObject:self];
    [self.runner initalize:@"" portNumber:@"" callbackObject:self];
    [self.runner run];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSLog(@"Memory warning");
    // Dispose of any resources that can be recreated.
}

-(void) notifiedForOutput: (NSNotification *)notified
{
    NSLog(@"Output");
    // Get data
    NSData * data = [[notified userInfo] valueForKey:NSFileHandleNotificationDataItem];
    
    if ([data length]){
        // Create string from data
        NSString * outputString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        // Write to console
        [self.console append:outputString];
        //NSTextStorage *ts = [_unixTaskStdOutput textStorage];
        //[ts replaceCharactersInRange:NSMakeRange([ts length], 0)
        //                  withString:outputString];
        
        // Keep listening
        [self.runner.output readInBackgroundAndNotify];
    }
    
    /*if (unixTask != nil) {
        
        [fhOutput readInBackgroundAndNotify];
    }*/
    
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    NSLog(@"Segue");
}

@end
