//
//  Utilities.h
//  
//
//  Created by Audun Øygard on 20/01/16.
//
//

#import <Foundation/Foundation.h>

@interface Utilities : NSObject
+ (NSArray*)getDocumentsFileList;
+ (NSArray*)getDocumentsFileListByFileExtention:(NSString *)fileExtention;
+ (NSString *)getIPAddress;
@end
