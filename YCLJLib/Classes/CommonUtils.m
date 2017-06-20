//
//  CommonUtils.m
//  Pods
//
//  Created by Adam on 2017/6/15.
//
//

#import "CommonUtils.h"

@implementation CommonUtils

+ (NSString *)currentTimeInterval {
    
    NSDate *today = [NSDate dateWithTimeIntervalSinceNow:0];
    // 秒.毫秒 1442541004.2110679
    NSTimeInterval interval = [today timeIntervalSince1970];
    NSString *dateInterval = [NSString stringWithFormat:@"%.0f", interval * 1000];
    
    return dateInterval;
}

#pragma mark - Param Dict
+ (NSMutableDictionary *) getParamDict:(NSString *)routeName
                              dataDict:(NSMutableDictionary *)dataDict
{
    
    NSMutableDictionary *specialDict = [NSMutableDictionary dictionary];
    
//    [specialDict setObject:routeName forKey:@"route"];
    
    if (dataDict != nil) {
        [dataDict setObject:[CommonUtils currentTimeInterval] forKey:@"time"];
        
        [specialDict setObject:dataDict forKey:@"data"];
    } else {
        [specialDict setObject:@"" forKey:@"data"];
    }
    
    NSMutableDictionary *commonDict = [NSMutableDictionary dictionary];
    [commonDict setObject:@"ios" forKey:@"plat"];
    [commonDict setObject:@"2" forKey:@"interVersion"];
    [dataDict setObject:commonDict forKey:@"common"];
    
//    NSMutableDictionary *tranDict = [NSMutableDictionary dictionary];
//    [tranDict setObject:[self dictToJsonString:specialDict] forKey:@"cmd"];
    
    return dataDict;
}

+ (NSString *)dictToJsonString:(NSMutableDictionary *)dictionary
{
    NSString *backVal = nil;
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:&error];
    backVal = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    if (error) {
        NSLog(@"dic->%@",error);
    }
    
    return backVal;
}

+ (void)DLog:(NSString *format, ...) {

    NSLog(@"%@", format);
}

@end
