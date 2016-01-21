//
//  ChooseProgramViewController.m
//  
//
//  Created by Audun Øygard on 20/01/16.
//
//

#import "ChooseProgramViewController.h"
#import "Utilities.h"
#import "ConsoleViewController.h"

@interface ChooseProgramViewController () <UIPickerViewDataSource, UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIPickerView *picker;
@property NSMutableArray *emeraldFiles;
@property NSString *chosenProgram;
@end

@implementation ChooseProgramViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.picker setDataSource:self];
    [self.picker setDelegate:self];
    self.emeraldFiles = [NSMutableArray arrayWithArray:[Utilities getDocumentsFileListByFileExtention:@".x"]];
    [self.emeraldFiles insertObject:[NSArray arrayWithObjects:@"", @"<none>", nil] atIndex:0];

    
    // Do any additional setup after loading the view.
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.emeraldFiles[row][1];
}

// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.emeraldFiles.count;
}

// set chosen program
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.chosenProgram = self.emeraldFiles[row][0];
    NSLog(@"Program: %@", self.chosenProgram);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    ConsoleViewController *consoleView = [segue destinationViewController];
    consoleView.connectionInfo = self.connectionInfo;
    consoleView.program = self.chosenProgram;
}

@end
