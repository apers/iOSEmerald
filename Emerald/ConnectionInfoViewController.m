//
//  ConnectionInfoViewController.m
//  
//
//  Created by Audun Øygard on 15/01/16.
//
//

#import "ConnectionInfoViewController.h"
#import "ConsoleViewController.h"
#import "ChooseProgramViewController.h"

@interface ConnectionInfoViewController ()
@property (weak, nonatomic) IBOutlet UITextField *hostname;
@property (weak, nonatomic) IBOutlet UITextField *port;
@end

@implementation ConnectionInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"Segue!");
    ChooseProgramViewController *programView = [segue destinationViewController];
    if(self.hostname.text.length != 0 && self.port.text.length != 0) {
        programView.connectionInfo = [[NSArray alloc] initWithObjects:self.hostname.text, self.port.text, nil];
    } else {
        programView.connectionInfo = nil;
    }
}

@end
