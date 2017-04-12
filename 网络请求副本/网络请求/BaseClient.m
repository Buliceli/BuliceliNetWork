//
//  BaseClient.m
//  网络请求
//
//  Created by 李洞洞 on 10/4/17.
//  Copyright © 2017年 Minte. All rights reserved.
//

#import "BaseClient.h"

@implementation BaseClient

+ (instancetype)shareClient
{
    static BaseClient * client = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //Clicent对象被创建时 属性Manager应该被创建 并初始化 否则manager为空 无法进行网络请求
        client = [[self alloc]initWithBaseURL:@""];
    });
    return client;
}
#pragma mark -- 自定义构造方法
- (instancetype)initWithBaseURL:(NSString *)baseUrl
{
    if (self = [super init]) {
        _baseURL = baseUrl;
        _manager = [AFHTTPSessionManager manager];
        _manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        _manager.responseSerializer.acceptableContentTypes = [[NSSet alloc]initWithObjects:@"text/html",@"application/json", nil];
    }
    return self;
}

#pragma mark -- 公共的请求方法
+ (NSURL *)httpType:(BASE_TYPE)type andURL:(NSString *)url andParam:(NSDictionary *)param andSuccessBlock:(httpSuccessBlock)sucBlock andFailBlock:(httpFailBlock)failBlock
{
    if ([ISNull isNilOfSender:url]) {
        //url为空
#if 1
        //测试代码 上线就注销
        NSError * error = [[NSError alloc]initWithDomain:@"url为空" code:9999 userInfo:nil];
        NSLog(@"请求地址为空");
        failBlock(nil,error);
#endif
        return nil;
    }
    if ([self netIsReachability]) {
        //有网 判断请求的类型 调用不同的方法
        if (type == GET) {
            return [self requestGETWithURL:url andParam:param andSuccessBlock:sucBlock andFailBlock:failBlock];
        }else if (type == POST){
            return [self requestPOSTWithURL:url andParam:param andSuccessBlock:sucBlock andFailBlock:failBlock];
        }else if (type == PUT){
            return [self requestPUTWithURL:url andParam:param andSuccessBlock:sucBlock andFailBlock:failBlock];
        }else{
            return [self requestDELETEWithURL:url andParam:param andSuccessBlock:sucBlock andFailBlock:failBlock];
        }
    }else{
        NSLog(@"当前无网");
        return nil;
    }
    return nil;
}
#pragma mark -- 检查当前的网络状态
+ (BOOL)netIsReachability
{
    //yes有网络 no 无网络
    return [[Reachability reachabilityForInternetConnection]isReachable];
}
#pragma mark -- GET方法的封装
+ (NSURL *)requestGETWithURL:(NSString *)url andParam:(NSDictionary *)param andSuccessBlock:(httpSuccessBlock)sucBlock andFailBlock:(httpFailBlock)failBlock
{
    BaseClient * client = [BaseClient shareClient];
    NSString * signUrl = [NSString stringWithFormat:@"%@%@",client.baseURL,url];
    signUrl = [signUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL * returnUrl = [NSURL URLWithString:signUrl];
    //进行网络请求
    [client.manager GET:signUrl parameters:param progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                                           //此处的responseObject是id类型啊?
        NSString * str = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        NSLog(@"%@",str);
        //这为什么要回主线程执行呢?
        dispatch_async(dispatch_get_main_queue(), ^{
            if (responseObject == nil) {
                NSError * error = [[NSError alloc]initWithDomain:@"网络请求数据为空" code:999 userInfo:nil];
                failBlock(returnUrl,error);
            }else{
                id object = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
                sucBlock(returnUrl,object);
            }
        });
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         dispatch_async(dispatch_get_main_queue(), ^{
             failBlock(returnUrl,error);
         });
    }];
    //block有迟延 调用方法时 立刻拿到接口
    return returnUrl;
}

#pragma mark --POST 方法的封装

+ (NSURL *)requestPOSTWithURL:(NSString *)url andParam:(NSDictionary *)param andSuccessBlock:(httpSuccessBlock)sucBlock andFailBlock:(httpFailBlock)failBlock
{
    
    BaseClient * client = [BaseClient shareClient];
    
    NSString * signUrl = [NSString stringWithFormat:@"%@%@",client.baseURL,url];
    
    signUrl = [signUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    NSURL * retureUrl = [NSURL URLWithString:signUrl];
    
   [client.manager POST:signUrl parameters:param progress:^(NSProgress * _Nonnull uploadProgress) {
       
   } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
       
       NSString * str = [[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
       
       NSLog(@"*************%@",str);
       dispatch_async(dispatch_get_main_queue(), ^{
       
       if (responseObject == nil) {
           
           NSError * error = [[NSError alloc]initWithDomain:@"返回数据为空" code:9999 userInfo:nil];
           
           failBlock(retureUrl,error);
           
           
       }else
       {
           id object = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
           sucBlock(retureUrl,object);
       }
           
       });
   } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       dispatch_async(dispatch_get_main_queue(), ^{
           failBlock(retureUrl,error);
       });
       
   }];
    
    return retureUrl;
}

#pragma mark -- PUT 方法的封装

+ (NSURL *)requestPUTWithURL:(NSString *)url andParam:(NSDictionary *)param andSuccessBlock:(httpSuccessBlock)sucBlock andFailBlock:(httpFailBlock)failBlock
{
    BaseClient * client = [BaseClient shareClient];
    NSString * signUrl = [NSString stringWithFormat:@"%@%@",client.baseURL,url];
    signUrl = [signUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL * returnURL = [NSURL URLWithString:signUrl];
    
    [client.manager PUT:signUrl parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
        dispatch_async(dispatch_get_main_queue(), ^{
        
        if (responseObject == nil) {
            NSError * error = [[NSError alloc]initWithDomain:@"请求数据为空" code:9999 userInfo:nil];
            failBlock(returnURL,error);
        }else
        {
            id object = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            sucBlock(returnURL,object);
            
            
        }
        });
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            failBlock(returnURL,error);
        });
        
    }];
    
    return returnURL;
    
    
}


+ (NSURL *)requestDELETEWithURL:(NSString *)url andParam:(NSDictionary *)param andSuccessBlock:(httpSuccessBlock)sucBlock andFailBlock:(httpFailBlock)failBlock
{
    BaseClient * client = [BaseClient shareClient];
    NSString * signUrl = [NSString stringWithFormat:@"%@%@",client.baseURL,url];
    signUrl = [signUrl stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL * returnURL = [NSURL URLWithString:signUrl];
    
    [client.manager DELETE:signUrl parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
        dispatch_async(dispatch_get_main_queue(), ^{
        
        if (responseObject == nil) {
            NSError * error = [[NSError alloc]initWithDomain:@"请求数据为空" code:9999 userInfo:nil];
            failBlock(returnURL,error);
        }else
        {
            id object = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            sucBlock(returnURL,object);
            
            
        }
            
        });
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            failBlock(returnURL,error);
        });
        
    }];
    
    return returnURL;
    
    
}

#pragma mark - 取消请求
+ (void)cancelHttpRequestOperation
{
    BaseClient * client = [BaseClient shareClient];
    [client.manager.operationQueue cancelAllOperations];
    //取消manager队列中所有的任务
}











@end































