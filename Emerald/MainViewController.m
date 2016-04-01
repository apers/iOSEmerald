//
//  MainViewController.m
//  
//
//  Created by Audun Øygard on 14/01/16.
//
//

#import "MainViewController.h"

@interface MainViewController ()
- (IBAction)returnToMain:(UIStoryboardSegue *)segue;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Set the emerald enviroment variables
    [Utilities setEmeraldEnv];
    
    // Check if the Emerald binary exists
    NSLog(@"PATH: %@", [Utilities getEmeraldEmx]);
    BOOL exists = [[NSFileManager defaultManager] isExecutableFileAtPath:[Utilities getEmeraldEmx]];
    
    // Show an alert if the binary could not be found
    if (!exists) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Permission" message:[NSString stringWithFormat:@"%@%@",@"Could not locate Emerald binary at: ", [Utilities getEmeraldEmx]] delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
         [alert show];
    } else {
         NSLog(@"Emerald binary found!");
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)returnToMain:(UIStoryboardSegue *)segue {
}

@end
