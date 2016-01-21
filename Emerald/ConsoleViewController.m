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
#import "Utilities.h"

@interface ConsoleViewController () <UITextViewDelegate>
- (void) toggleKeyboard;
@property (weak, nonatomic) IBOutlet Console *console;
@property EmeraldRunner *runner;
@property BOOL keyboardVisible;
@property NSString *currentCommand;
@end
@implementation ConsoleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // init
    self.currentCommand = [[NSString alloc] init];
        
    // Set self as delegate for console view
    [self.console setDelegate:self];
    self.keyboardVisible = NO;
        
    // Hide back button. We have a custom handler
    self.navigationItem.hidesBackButton = YES;
        
    // Allocate runner
    self.runner = [[EmeraldRunner alloc] init];
    
    // Clear console
    [self.console clear];

    // Initalize runner
    // Check if we have connection info
    if (self.connectionInfo != nil) {
        NSLog(@"%@:%@", self.connectionInfo[0], self.connectionInfo[1]);
        [self.runner initalize:self.connectionInfo[0] portNumber:self.connectionInfo[1] callbackObject:self program:self.program];
    } else {
        [self.runner initalize:@"" portNumber:@"" callbackObject:self program:self.program];
    }
    [self.runner run];
    // Append ip to console
    [self.console append:[NSString stringWithFormat:@"Running with IP: %@\n", Utilities.getIPAddress]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    NSLog(@"Memory warning");
    // Dispose of any resources that can be recreated.
}

-(void) notifiedForOutput: (NSNotification *)notified
{
    //self.console.scrollEnabled = NO;
    // Get data
    NSData * data = [[notified userInfo] valueForKey:NSFileHandleNotificationDataItem];
    
    if ([data length]){
        // Create string from data
        NSString * outputString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        
        // Write to console
        [self.console append:outputString];
        
        // Keep listening
        [self.runner.output readInBackgroundAndNotify];
    }
    [self.console scrollRangeToVisible:NSMakeRange(self.console.text.length-1, 1)];
    self.console.scrollEnabled = NO;
    self.console.scrollEnabled = YES;
}

// Listener for keyboard button
- (IBAction)toggleButton:(id)sender {
    [self toggleKeyboard];
}

// Detect changes in TextView
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {

    // Delete
    if(range.length == 1) {
        if (self.currentCommand.length > 0) {
            self.currentCommand = [self.currentCommand substringToIndex:self.currentCommand.length-1];
        }
    } else if ([text  isEqual: @"\n"]) { // New line
        // Send command to Emerald
        self.currentCommand = [self.currentCommand stringByAppendingString:text];
        [self.runner.input writeData:[self.currentCommand dataUsingEncoding:NSUTF8StringEncoding]];        
        // Clear command
        self.currentCommand = @"";
    } else { // Append new character to command string
        self.currentCommand = [self.currentCommand stringByAppendingString:text];
    }
    
    
    return YES;
}

// Enable or disable keyboard
-(void) toggleKeyboard {
    if (self.keyboardVisible) {
        NSLog(@"Hide");
        self.console.editable = NO;
        [self.console setUserInteractionEnabled:YES];
        [self.console resignFirstResponder];
    } else {
        NSLog(@"Show");
        self.console.editable = YES;
        [self.console setUserInteractionEnabled:NO];
        [self.console setSpellCheckingType:UITextSpellCheckingTypeNo];
        self.console.autocorrectionType = UITextAutocorrectionTypeNo;
        [self.console becomeFirstResponder];
    }
    self.keyboardVisible = !self.keyboardVisible;

}

- (IBAction)unwindToConsole:(UIStoryboardSegue *)segue {

}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    [self.runner stop];
}

@end
