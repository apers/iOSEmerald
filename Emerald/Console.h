//
//  Console.h
//  
//
//  Created by Audun Øygard on 14/01/16.
//
//

#import <UIKit/UIKit.h>

@interface Console : UITextView
- (void)append:(NSString *)text;
-(void)clear;
@end
