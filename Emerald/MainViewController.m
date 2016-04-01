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
    
    NSLog(@"PATH: %@", [Utilities getEmeraldEmx]);
    BOOL exists = [[NSFileManager defaultManager] isExecutableFileAtPath:[Utilities getEmeraldEmx]];
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
