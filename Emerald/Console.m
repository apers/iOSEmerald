//
//  Console.m
//  
//
//  Created by Audun Øygard on 14/01/16.
//
//

#import "Console.h"

@implementation Console
- (void)write:(NSString *)text {
    // To avoid resetting text formatting and losing text color
    if (![self isSelectable]) {
        self.selectable = YES;
    }
    self.text = text;

    // To avoid resetting text formatting and losing text color
    if (![self isSelectable]) {
        self.selectable = NO;
    }
}

- (void)append:(NSString *)text {
    NSString *newText = [self.text stringByAppendingString:text];
    [self write:newText];
}

- (void)clear {
    [self write:@""];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end