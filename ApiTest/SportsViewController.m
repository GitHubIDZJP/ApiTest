

#import "SportsViewController.h"
#import "zjpNetWork.h"
@interface SportsViewController ()
{
    NSArray *apiGlobalArr;
    NSString *s;
    NSString *s1;
    
}
@property (weak, nonatomic) IBOutlet UILabel *pl;
@property (weak, nonatomic) IBOutlet UILabel *CL;

@end

@implementation SportsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  //
//    self.pl.text = s;
//    self.CL.text =s1;
    static dispatch_once_t onceToken;
       dispatch_once(&onceToken, ^{
           // 只执行1次的代码(这里面默认是线程安全的)
           [self parsingApi];
       });
}
-(void)parsingApi
//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    NSDictionary *parameter = [[NSDictionary alloc]init];
    //https://sports.hxweixin.top/api/v1/fbinfo/infoNav
    //http://www.cnstorm.com/index.php?route=api/tool/config
     [[zjpNetWork manager]POST:@"https://sports.hxweixin.top/api/v1/fbinfo/infoNav" parameters:parameter success:^(id responseBody) {
                      NSLog(@"成功");
               if([responseBody[@"code"] intValue] == 200){
                             
                   self->apiGlobalArr = responseBody[@"data"];
                   NSString *str =self->apiGlobalArr[0][@"country_array"][0][@"country_name"][0];
                             NSLog(@"数组-1-%@",str);
                   NSString *str1 =self->apiGlobalArr[0][@"country_array"][1][@"country_name"][0];
                              NSLog(@"数组-2-%@",str1);
                             // _textLabel = @[str,str1];
                    self.pl.text = str;
                     self.CL.text =str1;
                   
                  
                         }
                // NSLog(@"api解析%@",responseBody);
                  } failure:^(NSError *error) {
                      NSLog(@"失败");
                  }];
}

@end
