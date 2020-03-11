//
//  JHRequest.h
//  August
//
//  Created by 舒金辉 on 2018/7/24.
//  Copyright © 2018年 舒金辉. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"





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

//上传图片
void requestPostImage(NSString *requestUrl,NSDictionary *parameter,NSArray *photoArr,requestError errorBlock,requestSuccessful successfulBlock);

void saveImage(UIImage *image,NSString *file);








@end
