//
//  ZTNetWork.h
//  ZTCloudMirror
//
//  Created by ZWL on 15/8/17.
//  Copyright (c) 2015年 ZWL. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger,ZTHTTPResponseCode) {
    ZTHTTPResponseCodeSuccess = 200,
    ZTHTTPResponseCodeNetworkError = 0
};

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
 构造函数

 @param paramers 参数
 @param url 请求url
 @return ZTNetModel
 */
-(instancetype)initParamers:(NSDictionary *)paramers urlString:(NSString *)url;


@end


@interface ZTUpLoadModel : NSObject
///数据类型
@property(nonatomic,strong)NSData * path;
///数据类型
@property(nonatomic,strong)NSString * fileType;
///数据名称
@property(nonatomic,strong)NSString * fileName;
///接受数据的方法名
@property(nonatomic,strong)NSString * dataMethod;

/**
 构造函数

 @param fileType 数据类型
 @param name 数据名称
 @param method 接受数据的方法名
 @return ZTUpLoadModel
 */
-(instancetype)initFileType:(NSString *)fileType fileName:(NSString*)name dataMethod:(NSString*)method;

@end


@interface ZTNetUpLoadModel : ZTNetModel

/**
 上传文件的数据组
 */
@property(nonatomic,strong)NSArray<ZTUpLoadModel*> *dataAry;

@end


typedef void(^SuccessBlock)(NSInteger statusCode,id model);

typedef void(^FailedBlock)(NSInteger statusCode,NSString * failDescription);

@interface ZTNetWork : NSObject

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
+(NSURLSessionDataTask*)ZTDELETE:(ZTNetModel *)netModel   success:(SuccessBlock)success fail:(FailedBlock)fail;

/**
 * put请求
 */
+(NSURLSessionDataTask*)ZTPUT:(ZTNetModel *)netModel   success:(SuccessBlock)success fail:(FailedBlock)fail;

/**
 * get请求
 */
+(NSURLSessionDataTask*)ZTGET:(ZTNetModel *)netModel   success:(SuccessBlock)success fail:(FailedBlock)fail;

/**
 * post请求
 */
+(NSURLSessionDataTask*)ZTPOST:(ZTNetModel *)netModel   success:(SuccessBlock)success fail:(FailedBlock)fail;

/**
 * post请求(上传文件)
 */
+(NSURLSessionDataTask*)ZTUPFILE:(ZTNetUpLoadModel *)upModel  success:(SuccessBlock)success fail:(FailedBlock)fail;

@end
