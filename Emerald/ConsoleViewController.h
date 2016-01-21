//
//  ConsoleViewController.h
//  
//
//  Created by Audun Øygard on 14/01/16.
//
//

#import <UIKit/UIKit.h>

@interface ConsoleViewController : UIViewController
@property NSArray *connectionInfo;
@property NSString *program;
-(void) notifiedForOutput: (NSNotification *)notified;
@end
