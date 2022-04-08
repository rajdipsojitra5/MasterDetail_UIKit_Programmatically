//
//  UtilityObjectiveC.m
//  MasterDetail_UIKit_Programmatically
//
//  Created by ks on 06/04/22.
//

#import "UtilityObjectiveC.h"

@implementation UtilityObjectiveC

+ (NSString *)getStringToAppendURLForAPIFromArray:(NSMutableArray *)arrayObject {
    NSLog(@"%@",arrayObject);
    NSString *stringToAppendURL = @"";
    for (NSString *stringTemp in arrayObject) {
        stringToAppendURL = [NSString stringWithFormat:@"%@%@%@",stringToAppendURL,@"/",stringTemp];
    }
    NSLog(@"%@",stringToAppendURL);
    return stringToAppendURL;
}

@end
