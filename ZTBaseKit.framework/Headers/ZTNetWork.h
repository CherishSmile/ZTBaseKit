//
//  ZTNetWork.h
//  ZTCloudMirror
//
//  Created by ZWL on 15/8/17.
//  Copyright (c) 2015年 ZWL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>



typedef NSString * ZTContentType;
FOUNDATION_EXTERN ZTContentType const ZTContentTypeAppXWWWFormUrlencoded;
FOUNDATION_EXTERN ZTContentType const ZTContentTypeAppJson;
FOUNDATION_EXTERN ZTContentType const ZTContentTypeAppJS;
FOUNDATION_EXTERN ZTContentType const ZTContentTypeAppXml;
FOUNDATION_EXTERN ZTContentType const ZTContentTypeTextPlain;
FOUNDATION_EXTERN ZTContentType const ZTContentTypeTextXml;
FOUNDATION_EXTERN ZTContentType const ZTContentTypeTextHtml;


typedef NS_ENUM(NSInteger,ZTHTTPResponseCode) {
    ZTHTTPResponseCodeSuccess = 200,
    ZTHTTPResponseCodeUnauthorized = 401,
    ZTHTTPResponseCodeNetworkError = 0
};

@class ZTUpLoadModel;

@interface ZTNetModel : NSObject

/**
 参数
 */
@property(nonatomic, strong) id paramers;

/**
 请求url
 */
@property(nonatomic, strong) NSString * url;

/**
 请求ContentType，不设置默认application/x-www-form-urlencoded
 */
@property(nonatomic, copy) ZTContentType  requestContentType;

/**
 是否上传文件
 */
@property(nonatomic, assign) BOOL  isUploadFile;

/**
 上传文件的数据组
 */
@property(nonatomic,strong)NSArray<ZTUpLoadModel*> *dataAry;

/**
 构造函数

 @param paramers 参数
 @param url 请求url
 @return ZTNetModel
 */
-(instancetype)initParamers:(id)paramers urlString:(NSString *)url;
-(instancetype)initParamers:(id)paramers urlString:(NSString *)url requestContentType:(ZTContentType)contentType;

@end


@interface ZTUpLoadModel : NSObject

///数据类型
@property(nonatomic,strong)NSData * path;

///数据类型
@property(nonatomic,strong)NSString * MIMEType;

///文件名称
@property(nonatomic,strong)NSString * fileName;

///接受数据的方法名
@property(nonatomic,strong)NSString * dataMethod;

/**
 构造函数
 
 @param MIMEType 数据类型
 @param name 数据名称
 @param method 接受数据的方法名
 @return ZTUpLoadModel
 */
-(instancetype)initMIMEType:(NSString *)MIMEType fileName:(NSString*)name dataMethod:(NSString*)method;

@end


typedef void(^ZTRequestSuccessBlock)(NSInteger statusCode,id model);

typedef void(^ZTRequestFailedBlock)(NSInteger statusCode,NSString * failDescription);

@interface ZTNetWork : NSObject

@property(nonatomic, strong, readonly) AFHTTPSessionManager * sessionManager;

/**
 * 请求单例
 */
+(instancetype)manager;

/**
 * 取消所有请求
 */
-(void)cancleAllRequest;
/**
 * 取消某个请求
 */
-(void)cancleRequest:(NSURL*)url;

/**
 * delete请求
 */
+(NSURLSessionDataTask *)ZTDELETE:(ZTNetModel *)netModel   success:(ZTRequestSuccessBlock)success fail:(ZTRequestFailedBlock)fail;

/**
 * put请求
 */
+(NSURLSessionDataTask *)ZTPUT:(ZTNetModel *)netModel   success:(ZTRequestSuccessBlock)success fail:(ZTRequestFailedBlock)fail;

/**
 * get请求
 */
+(NSURLSessionDataTask *)ZTGET:(ZTNetModel *)netModel   success:(ZTRequestSuccessBlock)success fail:(ZTRequestFailedBlock)fail;

/**
 * post请求
 */
+(NSURLSessionDataTask *)ZTPOST:(ZTNetModel *)netModel   success:(ZTRequestSuccessBlock)success fail:(ZTRequestFailedBlock)fail;

/**
 * post请求(上传文件)
 */
+(NSURLSessionDataTask *)ZTUPFILE:(ZTNetModel *)upModel  success:(ZTRequestSuccessBlock)success fail:(ZTRequestFailedBlock)fail;

@end
