//
//  BaseClient.h
//  网络请求
//
//  Created by 李洞洞 on 10/4/17.
//  Copyright © 2017年 Minte. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"
#import "AFNetworking.h"
#import "ISNull.h"
typedef NS_ENUM(NSUInteger,BASE_TYPE){
    GET,
    POST,
    PUT,
    DELETE
};
//成功时的block 参数请求的地址 回调的数据 id 可以是字典 也可以是数组
typedef void(^httpSuccessBlock)(NSURL * URL,id data);
//失败时 回调的block 参数 请求的地址 失败的错误信息
typedef void(^httpFailBlock)(NSURL * URL,NSError * error);
@interface BaseClient : NSObject
@property(nonatomic,strong)AFHTTPSessionManager * manager;
@property(nonatomic,copy)NSString * baseURL;

+ (instancetype)shareClient;
//type 请求的方式
//url 请求的地址
//param 请求的参数
//block 成功或者失败 回调的block
//返回值 目的是调用方法是 可以通过返回值 是哪一个接口 方便后期调试
+ (NSURL *)httpType:(BASE_TYPE)type andURL:(NSString *)url andParam:(NSDictionary *)param andSuccessBlock:(httpSuccessBlock)sucBlock andFailBlock:(httpFailBlock)failBlock;

// 取消请求的方法
+ (void)cancelHttpRequestOperation;

@end



























