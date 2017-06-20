//
//  CommonUtils.h
//  Pods
//
//  Created by Adam on 2017/6/15.
//
//

#import <Foundation/Foundation.h>
#import "YCLJ_Header.h"

@interface CommonUtils : NSObject

#pragma mark - Param Dict
+ (NSMutableDictionary *) getParamDict:(NSString *)routeName
                              dataDict:(NSMutableDictionary *)dataDict;

+ (void)DLog:(NSString *)msg;

@end
