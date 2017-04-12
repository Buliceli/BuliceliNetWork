//
//  LDHomeAPI.h
//  网络请求
//
//  Created by 李洞洞 on 10/4/17.
//  Copyright © 2017年 Minte. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseClient.h"
@interface LDHomeAPI : NSObject

+ (NSURL *)getHomeScrollViewDataWithSucBlock:(httpSuccessBlock)SucBlock andFailBlock:(httpFailBlock)FailBlock;



+ (NSURL *)getHomeCellDataWithOffset:(int)page andSucBlock:(httpSuccessBlock)SucBlock andFailBlock:(httpFailBlock)FailBlock;




@end
