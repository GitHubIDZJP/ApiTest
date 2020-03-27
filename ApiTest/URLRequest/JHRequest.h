//
//  JHRequest.h
//  August
//
//  Created by 舒金辉 on 2018/7/24.
//  Copyright © 2018年 舒金辉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

#define userInfoFile(filePath) [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:filePath]




typedef void(^requestError)(NSError *error);
typedef void(^requestSuccessful)(NSDictionary *dic);
typedef void(^requestBody)(id<AFMultipartFormData>formData);

@interface JHRequest : NSObject
{
    requestError block_requestError;
    requestSuccessful block_requestSuccessful;
    requestBody block_requestBody;
}

//GET请求
void requestGET(NSString *requestUrl,NSDictionary *parameter,requestError errorBlock,requestSuccessful successfulBlock);
//Post请求
void requestPost(NSString *requestUrl,NSDictionary *parameter,requestError errorBlock,requestSuccessful successfulBlock);
//body请求
void requestPostBody(NSString *requestUrl,NSDictionary *parameter, requestBody bodyBlock,requestError errorBlock,requestSuccessful successfulBlock);
//贴吧模块  请求的服务器地址不一样
void requestBarPost(NSString *requestUrl,NSDictionary *parameter,requestError errorBlock,requestSuccessful successfulBlock);
//上传图片
void requestPostImage(NSString *requestUrl,NSDictionary *parameter,NSArray *photoArr,requestError errorBlock,requestSuccessful successfulBlock);
//保存图片到本地
void saveImage(UIImage *image,NSString *file);
-(void)saveImage:(UIImage*)image File:(NSString*)file;







@end
