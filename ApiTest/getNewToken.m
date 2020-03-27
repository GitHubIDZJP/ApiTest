/*
同步和异步(基于块)调用
易于设置请求头，cookies和POST数据
容易得到响应状态，报头和编码
文件上传与进度块
可以使用流与下载进度块
快速和简单的HTTP认证
以curl格式记录请求
 */
#import "getNewToken.h"
#import "STHTTPRequest.h"
#import "JHDateTimeChooseView.h"
@interface getNewToken ()

@end

@implementation getNewToken

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"获取新token");
    JHDateTimeChooseView *jT = [[JHDateTimeChooseView alloc]initWithFrame:RECT(100,160,ScreenWidth,400)];
    jT.backgroundColor = UIColor.cyanColor;
    [self.view addSubview:jT];
}

@end
