//
//  LDHomeAPI.m
//  网络请求
//
//  Created by 李洞洞 on 10/4/17.
//  Copyright © 2017年 Minte. All rights reserved.
//

#import "LDHomeAPI.h"
#define HOME_SCROLL_URL @"http://www.roadqu.com/api/mobile/qunawan/tour/seasonalfunplacelist"

@implementation LDHomeAPI

+ (NSURL *)getHomeScrollViewDataWithSucBlock:(httpSuccessBlock)SucBlock andFailBlock:(httpFailBlock)FailBlock
{
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    
    [params setValue:@"1458873145000" forKey:@"a_t"];
    [params setValue:@"56f3b5f6ac4a6" forKey:@"token"];
    [params setValue:@"3e5ba2f1c1a62f627c59b59483a5da7cb5ea1429" forKey:@"sign"];
    
    return [BaseClient httpType:POST andURL:HOME_SCROLL_URL andParam:params andSuccessBlock:SucBlock andFailBlock:FailBlock];
}
+ (NSURL *)getHomeCellDataWithOffset:(int)page andSucBlock:(httpSuccessBlock)SucBlock andFailBlock:(httpFailBlock)FailBlock
{
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    
    [params setValue:@(1) forKey:@"gender"];
    [params setValue:@(1) forKey:@"generation"];
    [params setValue:@(20) forKey:@"limit"];
    [params setValue:@(page) forKey:@"offset"];
    
    
    
    return [BaseClient httpType:GET andURL:HOME_SCROLL_URL andParam:params andSuccessBlock:SucBlock andFailBlock:FailBlock];
}


@end
