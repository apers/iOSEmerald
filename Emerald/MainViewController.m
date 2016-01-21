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
    BOOL exists = [[NSFileManager defaultManager] fileExistsAtPath:@"/bin/emx"];
     
     
     if (!exists) {
         NSLog(@"Does not exist!");
     } else {
         NSLog(@"Exists!");
     }
    // Do any additional setup after loading the view.
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
