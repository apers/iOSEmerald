//
//  Utilities.m
//  
//
//  Created by Audun Øygard on 20/01/16.
//
//

#include <ifaddrs.h>
#include <arpa/inet.h>
#import "Utilities.h"

@import UIKit;

@implementation Utilities

// Returns an array of the files in the documents folder
+ (NSArray*)getDocumentsFileList {
    
    // Find URL of documents folder
    NSURL *url = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    
    NSString *documentsUrl = [url path];
    
    if(documentsUrl == nil) {
        NSLog(@"Documents url is nil. Utilities.m:24");
    } else {
        NSLog(@"%@", documentsUrl);
    }
    
    // Get list of files
    NSFileManager *fileman = [NSFileManager defaultManager];
    NSArray *files = [fileman contentsOfDirectoryAtPath:documentsUrl error:nil];
    
    NSMutableArray *completePathArray = [[NSMutableArray alloc] init];
    
    // Create complete name file list
    for (NSString *file in files) {
        [completePathArray addObject:[NSArray arrayWithObjects:
                                      [NSString stringWithFormat:@"%@/%@", documentsUrl, file],
                                      [NSString stringWithFormat:@"%@", file],
                                      nil]];
    }
    
    return [completePathArray copy];
}


// Returns an array of the files in the documents folder with a given extention
+ (NSArray*)getDocumentsFileListByFileExtention:(NSString *)fileExtention {
    // Find URL of documents folder
    NSURL *url = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    
    NSString *documentsUrl = [url path];
    
    NSLog(@"%@", documentsUrl);
    
    if(documentsUrl == nil) {
        NSLog(@"Documents url nil Utilities.m:59");
    } else {
        NSLog(@"%@", documentsUrl);
    }
    
    // Get list of files
    NSFileManager *fileman = [NSFileManager defaultManager];
    NSArray *files = [fileman contentsOfDirectoryAtPath:documentsUrl error:nil];
    
    
    // Filter files by file extention
    NSArray *filesWithExtention = [files filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:[NSString stringWithFormat:@"self ENDSWITH '%@'",  fileExtention]]];
    
    NSMutableArray *completePathArray = [[NSMutableArray alloc] init];
    
    // Create complete name file list
    for (NSString *file in filesWithExtention) {
        [completePathArray addObject:[NSArray arrayWithObjects:
                                      [NSString stringWithFormat:@"%@/%@", documentsUrl, file],
                                      [NSString stringWithFormat:@"%@", file],
                                      nil]];
    }
    
    return [completePathArray copy];
}

// Returns the ip-address of en0 as a string
+ (NSString *)getIPAddress {
    
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                    
                }
                
            }
            
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
    
}

+ (NSString*)getEmeraldRoot {
    return @"/";
}

+ (NSString*)getEmeraldEmx {
    return [NSString stringWithFormat:@"%@%@", [Utilities getEmeraldRoot], @"bin/emx"];
}
+ (NSString*)getEmeraldEmc {
    return [NSString stringWithFormat:@"%@%@", [Utilities getEmeraldRoot], @"bin/emc"];
}


// Sets the emerald enviroment variable (not needed if its installed to /)
+ (void)setEmeraldEnv {
    NSString *key = @"EMERALDROOT";
    NSString *value = [Utilities getEmeraldRoot];
    setenv([key UTF8String], [value UTF8String], 1);
}


@end


