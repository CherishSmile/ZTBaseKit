//
//  ZTNetWork.m
//  ZTCloudMirror
//
//  Created by ZWL on 15/8/17.
//  Copyright (c) 2015年 ZWL. All rights reserved.
//

#import "ZTNetWork.h"
#import "ZTBaseFunction.h"
#import "ZTBaseConfiguration.h"


#define NTTIMEOUT 15.f
#define NTTUPFileIMEOUT 60.f

@interface ZTNetModel()
@end
@implementation ZTNetModel

-(instancetype)initParamers:(NSDictionary *)paramers urlString:(NSString *)url{
    self = [super init];
    if (self) {
        _paramers = paramers;
        _url = url;
    }
    return self;
}

-(instancetype)initParamers:(NSDictionary *)paramers urlString:(NSString *)url restApi:(BOOL)isRestApi{
    if (self = [super init]) {
        _paramers = paramers;
        _url = url;
        _isRestApi = isRestApi;
    }
    return self;
}

@end

@implementation ZTUpLoadModel
-(instancetype)initMIMEType:(NSString *)MIMEType fileName:(NSString *)name dataMethod:(NSString *)method{
    self = [super init];
    if (self) {
        _MIMEType = MIMEType;
        _fileName = name;
        _dataMethod = method;
    }
    return self;
}
@end



@interface ZTNetWork ()
@property(nonatomic, strong) NSMutableArray<NSURLSessionDataTask*> * tasks;
@property(nonatomic, strong) AFHTTPSessionManager * sessionManager;
@end

@implementation ZTNetWork

-(instancetype)init{
    if (self = [super init]) {
        self.tasks = [NSMutableArray array];
    }
    return self;
}

+(instancetype)manager{
    static ZTNetWork *netWork;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        netWork = [[self alloc] init];
    });
    return netWork;
}

-(void)cancleAllRequest{
    NSArray *tasks = [self.tasks copy];
    [tasks enumerateObjectsUsingBlock:^(NSURLSessionDataTask * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
         [obj cancel];
    }];
}

-(void)cancleRequest:(NSURL *)url{
    NSArray *tasks = [self.tasks copy];
    [tasks enumerateObjectsUsingBlock:^(NSURLSessionDataTask * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.originalRequest.URL.absoluteString isEqualToString:url.absoluteString]) {
            [obj cancel];
            * stop = YES;
        }
    }];
}

+(NSURLSessionDataTask*)ZTPUT:(ZTNetModel *)netModel success:(ZTRequestSuccessBlock)success fail:(ZTRequestFailedBlock)fail{
    NSURLSessionDataTask *task = nil;
    if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus!=AFNetworkReachabilityStatusNotReachable) {
        ZTNetWork *netWork = [self manager];
        AFHTTPSessionManager * manger = netWork.sessionManager;
        manger.requestSerializer.timeoutInterval = NTTIMEOUT;
        
       task = [manger PUT:isNil(netModel.url) parameters:netModel.paramers success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
           [netWork.tasks removeObject:task];
           [self printRequestLog:task.currentRequest param:netModel.paramers result:responseObject];
           if (success) {
               NSHTTPURLResponse *response = (NSHTTPURLResponse*)task.response;
               success(response.statusCode,responseObject);
           }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self printRequestLog:task.currentRequest param:netModel.paramers result:error];
            [netWork.tasks removeObject:task];
            if (fail) {
                NSHTTPURLResponse *response = (NSHTTPURLResponse*)task.response;
                fail(response.statusCode,error.localizedDescription);
            }
        }];
        [netWork.tasks addObject:task];
    }
    else
    {
        fail(ZTHTTPResponseCodeNetworkError,NETWORKERRO);
    }
    return task;
}

+(NSURLSessionDataTask*)ZTDELETE:(ZTNetModel *)netModel success:(ZTRequestSuccessBlock)success fail:(ZTRequestFailedBlock)fail{
    NSURLSessionDataTask *task = nil;
    if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus!=AFNetworkReachabilityStatusNotReachable) {
        ZTNetWork *netWork = [self manager];
        AFHTTPSessionManager * manger = netWork.sessionManager;
        manger.requestSerializer.timeoutInterval = NTTIMEOUT;

        task=[manger DELETE:isNil(netModel.url) parameters:netModel.paramers success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [netWork.tasks removeObject:task];
            [self printRequestLog:task.currentRequest param:netModel.paramers result:responseObject];
            if (success) {
                NSHTTPURLResponse *response = (NSHTTPURLResponse*)task.response;
                success(response.statusCode,responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self printRequestLog:task.currentRequest param:netModel.paramers result:error];
            [netWork.tasks removeObject:task];
            if (fail) {
                NSHTTPURLResponse *response = (NSHTTPURLResponse*)task.response;
                fail(response.statusCode,error.localizedDescription);
            }
        }];
        [netWork.tasks addObject:task];
    }
    else
    {
        fail(ZTHTTPResponseCodeNetworkError,NETWORKERRO);
    }
    return task;
}


+(NSURLSessionDataTask*)ZTGET:(ZTNetModel *)netModel success:(ZTRequestSuccessBlock)success fail:(ZTRequestFailedBlock)fail{
    NSURLSessionDataTask *task = nil;
    if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus!=AFNetworkReachabilityStatusNotReachable) {
        ZTNetWork *netWork = [self manager];
        AFHTTPSessionManager * manger = netWork.sessionManager;
        manger.requestSerializer.timeoutInterval = NTTIMEOUT;
        
        task = [manger GET:isNil(netModel.url) parameters:netModel.paramers progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self printRequestLog:task.currentRequest param:netModel.paramers result:responseObject];
            [netWork.tasks removeObject:task];
            if (success) {
                NSHTTPURLResponse *response = (NSHTTPURLResponse*)task.response;
                success(response.statusCode,responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self printRequestLog:task.currentRequest param:netModel.paramers result:error];
            [netWork.tasks removeObject:task];
            if (fail) {
                NSHTTPURLResponse *response = (NSHTTPURLResponse*)task.response;
                fail(response.statusCode,error.localizedDescription);
            }
        }];
        [netWork.tasks addObject:task];
    }
    else
    {
        fail(ZTHTTPResponseCodeNetworkError,NETWORKERRO);
    }
    return task;
}

/**
 post请求（非上传文件）

 @param netModel 网络请求Model
 @param success 成功回调
 @param fail 失败回调
 */
+(NSURLSessionDataTask*)ZTPOST:(ZTNetModel *)netModel success:(ZTRequestSuccessBlock)success fail:(ZTRequestFailedBlock)fail
{
    NSURLSessionDataTask *task = nil;
    if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus!=AFNetworkReachabilityStatusNotReachable) {
        ZTNetWork *netWork = [self manager];
        AFHTTPSessionManager * manger = netWork.sessionManager;
        manger.requestSerializer.timeoutInterval = NTTIMEOUT;

        task = [manger POST:isNil(netModel.url) parameters:netModel.paramers progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self printRequestLog:task.currentRequest param:netModel.paramers result:responseObject];
            [netWork.tasks removeObject:task];
            if (success) {
                NSHTTPURLResponse *response = (NSHTTPURLResponse*)task.response;
                success(response.statusCode,responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self printRequestLog:task.currentRequest param:netModel.paramers result:error];
            [netWork.tasks removeObject:task];
            if (fail) {
                NSHTTPURLResponse *response = (NSHTTPURLResponse*)task.response;
                fail(response.statusCode,error.localizedDescription);
            }
        }];
        [netWork.tasks addObject:task];
    }
    else
    {
        fail(ZTHTTPResponseCodeNetworkError,NETWORKERRO);
    }
    return task;
}

/**
 post请求（上传文件）
 
 @param upModel 网络请求Model
 @param success 成功回调
 @param fail 失败回调
 */
+(NSURLSessionDataTask*)ZTUPFILE:(ZTNetModel *)upModel success:(ZTRequestSuccessBlock)success fail:(ZTRequestFailedBlock)fail
{
    NSURLSessionDataTask *task = nil;
    if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus!=AFNetworkReachabilityStatusNotReachable)
    {
        ZTNetWork *netWork = [self manager];
        AFHTTPSessionManager * manger = netWork.sessionManager;
        manger.requestSerializer.timeoutInterval = NTTUPFileIMEOUT;

        task = [manger POST:isNil(upModel.url) parameters:upModel.paramers constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            for (ZTUpLoadModel * model in upModel.dataAry) {
                [formData appendPartWithFileData:model.path name:model.dataMethod fileName:model.fileName mimeType:model.MIMEType];
            }
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            [self printRequestLog:task.currentRequest param:upModel.paramers result:responseObject];
            [netWork.tasks removeObject:task];
            if (success) {
                NSHTTPURLResponse *response = (NSHTTPURLResponse*)task.response;
                success(response.statusCode,responseObject);
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self printRequestLog:task.currentRequest param:upModel.paramers result:error];
            [netWork.tasks removeObject:task];
            if (fail) {
                NSHTTPURLResponse *response = (NSHTTPURLResponse*)task.response;
                fail(response.statusCode,error.localizedDescription);
            }
        }];
        [netWork.tasks addObject:task];
    }
    else
    {
        fail(ZTHTTPResponseCodeNetworkError,NETWORKERRO);
    }
    return task;
}


/**
 sessionManager

 @return AFHTTPSessionManager
 */
- (AFHTTPSessionManager *)sessionManager{
    if (!_sessionManager) {
        _sessionManager = [AFHTTPSessionManager manager];
        [_sessionManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    }
    return _sessionManager;
}


/**
 * 打印请求信息
 */
+(void)printRequestLog:(NSURLRequest *)request param:(NSDictionary*)requestParam result:(id)responseObject{
    if (ZTConfig.isOpenDebug) {
        NSLog(@"接口地址：%@\n请求方式：%@\n请求参数：\n%@\n请求头：\n%@\n请求结果：\n%@",request.URL.absoluteString,request.HTTPMethod,requestParam,request.allHTTPHeaderFields,changeToJsonString(responseObject));
    }
}



@end
