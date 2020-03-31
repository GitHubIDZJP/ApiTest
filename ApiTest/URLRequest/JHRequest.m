
#import "JHRequest.h"

@implementation JHRequest
requestError block_requestError;
requestSuccessful block_requestSuccessful;
requestBody block_requestBody;





//NO1
void requestGET(NSString *requestUrl,NSDictionary *parameter,requestError errorBlock,requestSuccessful successfulBlock)
{
    JHRequest *r = [JHRequest new];
    
    if (r->block_requestError != errorBlock)
    {
        r->block_requestError = errorBlock;
    }
    if (r->block_requestSuccessful != successfulBlock)
    {
        r->block_requestSuccessful = successfulBlock;
    }
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    
    NSLog(@"url:%@",requestUrl);
    
    
    [session GET:requestUrl parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"%@",dict);
        r->block_requestSuccessful(dict);
        
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        r->block_requestError(error);
    }];
    
    
}
//NO2
void requestPost(NSString *requestUrl,NSDictionary *parameter,requestError errorBlock,requestSuccessful successfulBlock)
{
    JHRequest *request = [[JHRequest alloc] init];
    if (request->block_requestError != errorBlock) {
        request->block_requestError = errorBlock;
    }
    if (request->block_requestSuccessful != successfulBlock) {
        request->block_requestSuccessful = successfulBlock;
    }
    
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    
    //
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    securityPolicy.validatesDomainName = NO;
    securityPolicy.allowInvalidCertificates = YES;
    session.securityPolicy = securityPolicy;
    
    //   session.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSLog(@"url:%@",requestUrl);
    //    showWindowHUDView();
    
    [session POST:requestUrl parameters:parameter progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        //        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        request->block_requestSuccessful(responseObject);
        
        hidWindowHUBView();
        
        NSDictionary *dic = responseObject;
        
        if ([dic[@"code"] integerValue] == 2) {
            
            NSLog(@"%@",getUserInfo(@"loginstates"));
            
            if([getUserInfo(@"loginstates") integerValue] == 1)
            {
                //通过通知中心发送通知
                [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"loginNoti" object:nil userInfo:nil]];
                
                saveUserInfo(@"loginstates", @"2");
            
            }
        }
        //         NSString *str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        //        request->block_requestSuccessful(str);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        request->block_requestError(error);
        hidWindowHUBView();
        
    }];
    //    oper.responseSerializer = [AFCompoundResponseSerializer serializer];
    //    [oper start];
}

//body请求
void requestPostBody(NSString *requestUrl,NSDictionary *parameter, requestBody bodyBlock,requestError errorBlock,requestSuccessful successfulBlock)
{
    JHRequest *r = [JHRequest new];
    
    if (r->block_requestError != errorBlock)
    {
        r->block_requestError = errorBlock;
    }
    if (r->block_requestSuccessful != successfulBlock)
    {
        r->block_requestSuccessful = successfulBlock;
    }
    
    r->block_requestBody = bodyBlock;
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
   
    [session POST:@"" parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        r->block_requestBody(formData);
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        r->block_requestSuccessful(dict);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        r->block_requestError(error);
    }];
//    oper.responseSerializer = [AFCompoundResponseSerializer serializer];
//    [oper start];
}

//NO4
void requestPostImage(NSString *requestUrl,NSDictionary *parameter,NSArray *photoArr,requestError errorBlock,requestSuccessful successfulBlock){
    
    JHRequest *request = [[JHRequest alloc] init];
    if (request->block_requestError != errorBlock) {
        request->block_requestError = errorBlock;
    }
    if (request->block_requestSuccessful != successfulBlock) {
        request->block_requestSuccessful = successfulBlock;
    }
    //__unsafe_unretained __block Request *weakself = self;
    
    AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
    session.responseSerializer = [AFJSONResponseSerializer new];
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    NSLog(@"url=%@",requestUrl);
    [session POST:requestUrl parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSMutableArray *keyArr = [NSMutableArray array];
        for (int i = 0; i < photoArr.count; i++) {
            [keyArr addObject:[NSString stringWithFormat:@"img%d",i]];
            NSString* file_str = [NSString stringWithFormat:@"file%d.png",i];
            saveImage(photoArr[i], file_str);
            [formData appendPartWithFileURL:[NSURL fileURLWithPath:userInfoFile1(file_str)] name:keyArr[i] error:nil];
        }
    } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        request->block_requestSuccessful(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    
        request->block_requestError(error);
    }];
    
    
    
    
}

#pragma mark 保存图片
void saveImage(UIImage *image,NSString *file){
    //file:文件名
    //image: 图片对象
    NSData *sizeData = UIImageJPEGRepresentation(image,1.0);
    NSData *data = UIImageJPEGRepresentation(image, 0.00000000001);
    if (sizeData.length > 8000)
    {
        data = UIImageJPEGRepresentation(image, 0.00000000001);
    }
    [data writeToFile:userInfoFile(file) atomically:YES];
    
}
-(void)saveImage:(UIImage*)image File:(NSString*)file
{
    
    NSData *sizeData = UIImageJPEGRepresentation(image, 1.0);
    
    NSData *data = UIImageJPEGRepresentation(image, 1.0);
    
    if (sizeData.length > 80000)
    {
        
        data = UIImageJPEGRepresentation(image, 0.0001);
    }
    // NSData *data = UIImagePNGRepresentation(image);
    BOOL isSuccess =  [data writeToFile:@"" atomically:YES];
    NSLog(@"---%d----",isSuccess);
    
    
}


@end
