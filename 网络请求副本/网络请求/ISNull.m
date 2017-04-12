//
//  ISNull.m
//  模拟攒机
//
//  Created by Elean on 15/7/15.
//  Copyright (c) 2015年 Elean. All rights reserved.
//

#import "ISNull.h"
//#import "AFNetworking.h"
@implementation ISNull

+(BOOL)isNilOfSender:(NSObject *)sender
{
    if (!sender) {
        return YES;
    }
       if ([sender isKindOfClass:[NSArray class]]) {
        NSArray *array = (NSArray *)sender;
        if (array.count) {
            return NO;
        }
        else
        {
            return YES;
        }
    }
  
    if ([sender isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dic = (NSDictionary *)sender;
        if ([dic allKeys].count) {
            return NO;
        }
        else
        {
            return YES;
        }
    }
    if ([sender isKindOfClass:[NSString class]]) {
        NSString *str = (NSString *)sender;
        if (str != NULL && [str stringByReplacingOccurrencesOfString:@" " withString:@""].length > 0) {
            return NO;
        }
        else
        {
            return YES;
        }
    }
   
    return YES;
}

@end
