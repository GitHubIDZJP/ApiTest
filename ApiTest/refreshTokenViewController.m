
#import "refreshTokenViewController.h"

@interface refreshTokenViewController ()



@end

@implementation refreshTokenViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*
        NSMutableDictionary *parameter =[[NSMutableDictionary alloc]init];
              requestPost(@"https://sports.hxweixin.top/api/v1/refreshToken", parameter, ^(NSError *error) {
                  NSLog(@"解析失败");
              }, ^(NSDictionary *dic) {
                  NSLog(@"解析成功");
                  if([dic[@"code"] intValue] == 200){
                  }}
                  );//NSLog(@"测试:%@",dic);//打印
     */
   // UIImage *image = [UIImage imageNamed:@"TestName@2x.png"];
       NSString *fileName =@"TestName@2x.png";
}
    -(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
    {
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager POST:@"https://sports.hxweixin.top/api/v1/common/uploadImage" parameters:nil constructingBodyWithBlock:^(id  _Nonnull formData) {
            UIImage *image = [UIImage imageNamed:@"TestName@2x.png"];
            NSData *imageData = UIImageJPEGRepresentation(image,0.5);
            //使用formData来拼接数据
            /*
             第一个参数:二进制数据 要上传的文件参数
             第二个参数:服务器规定的
             第三个参数:该文件上传到服务器以什么名称保存
             */
            [formData appendPartWithFileData:imageData name:@"file" fileName:@"xxxx.png" mimeType:@"image/png"];
            
    //        [formData appendPartWithFileURL:[NSURL fileURLWithPath:@"/Users/zyyt/Desktop/11.jpg"] name:@"file" fileName:@"123.png" mimeType:@"image/png" error:nil];
            
          //  [formData appendPartWithFileURL:[NSURL fileURLWithPath:@"/Users/zyyt/Desktop/11.jpg"] name:@"file" error:nil];
            
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            
            NSLog(@"%f",1.0 * uploadProgress.completedUnitCount/uploadProgress.totalUnitCount);
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"上传成功---%@",responseObject);
            
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"上传失败---%@",error);
        }];

        
    }

    

@end
