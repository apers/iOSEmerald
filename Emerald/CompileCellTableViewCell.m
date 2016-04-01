//
//  CompileCellTableViewCell.m
//  
//
//  Created by Audun Øygard on 18/01/16.
//
//

#import "CompileCellTableViewCell.h"
#import "NSTask.h"

@interface  CompileCellTableViewCell ()
@property NSTask *task;
- (void)compileDone;
@end


@implementation CompileCellTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (BOOL)compileFile {
    NSLog(@"File: %@", self.filePath);
    
    // alloc task
    self.task = [[NSTask alloc] init];
    
    // set path
    self.task.launchPath = @"/bin/ec";
    
    // set arguments
    [self.task setArguments:[NSArray arrayWithObjects:self.filePath, nil]];
    
    // Add callback for completion
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self
           selector:@selector(compileDone)
               name:NSTaskDidTerminateNotification
             object:self.task];
    
    
    
    // Hide compile button
    self.compileButton.hidden = YES;
    
    // Show progress icon
    self.activity.hidden = NO;
    [self.activity startAnimating];
    
    // Launch compiler
    [self.task launch];
    return YES;
}


// Called when the compilation task is done
- (void)compileDone {
    int status = [self.task terminationStatus];
    
    self.activity.hidden = YES;
    self.compileButton.hidden = NO;
    // Success
    if(status == 0) {
        [self.compileButton setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        self.compileButton.titleLabel.text = @"Success";
    // Failure
    } else {
        [self.compileButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        self.compileButton.titleLabel.text = @"Failure";
    }
    
}

@end
