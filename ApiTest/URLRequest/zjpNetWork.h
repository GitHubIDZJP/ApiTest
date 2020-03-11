//
//  zjpNetWork.h
//  ApiTest
//
//  Created by test on 2020/3/11.
//  Copyright © 2020 test. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/**
 * 定义成功的Block
 */
typedef void (^successBlock)(id responseBody);


/**
 * 定义失败的Block
 */
typedef void (^failureBlock)(NSError *error);


//************ 网络请求管理类 *****************/
@interface zjpNetWork : NSObject





//****************************** 基础 *******************************/



/**
 * 单例
 */
+ (instancetype)manager;

/**
 * GET方法
 * 实例方法请求网络
 */
- (void)GET:(NSString *)urlStr parameters:(NSDictionary *)paramenters success:(successBlock)success failure:(failureBlock)failure;

/**
 * GET方法
 * 类方法请求网络
 */
+ (void)GET:(NSString *)urlStr parameters:(NSDictionary *)parameters success:(successBlock)success failure:(failureBlock)failure;

/**
 * POST方法
 * 实例方法请求网络
 */
- (void)POST:(NSString *)urlStr parameters:(NSDictionary *)parameters success:(successBlock)success failure:(failureBlock)failure;


/**
 * POST方法
 * 类方法请求网络
 */
+ (void)POST:(NSString *)urlStr parameters:(NSDictionary *)parameters success:(successBlock)success failure:(failureBlock)failure;


@end

NS_ASSUME_NONNULL_END
