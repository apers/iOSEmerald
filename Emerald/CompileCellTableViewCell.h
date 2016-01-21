//
//  CompileCellTableViewCell.h
//  
//
//  Created by Audun Øygard on 18/01/16.
//
//

#import <UIKit/UIKit.h>

@interface CompileCellTableViewCell : UITableViewCell
@property NSString *filePath;
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIButton *compileButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activity;
- (BOOL)compileFile;
@end