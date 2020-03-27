

#import "tabViewViewController.h"

@interface tabViewViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *apiGlobalArr;
    NSArray *_textLabel;
    NSString *  strTest ;
    NSString *path;//沙盒路径
}
@end

@implementation tabViewViewController
-(UITableView *)tableView{
    
    if(!_tableView){
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0,177*KWIDTH,SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.backgroundColor = color(242, 242, 242);
        _tableView.backgroundColor = colorWithHexString(@"#F3F6F4");
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.separatorColor = tableSeparatorColor;
        _tableView.rowHeight = 80*KWIDTH;
        IOS11;
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
   [self.view addSubview:self.tableView];
//    [self parsingApi];
    static dispatch_once_t onceToken;
          dispatch_once(&onceToken, ^{
              [self parsingApi];
          });
}
-(void)parsingApi
{
//    NSMutableDictionary *parameter =[[NSMutableDictionary alloc]init];
//          requestPost(@"https://sports.hxweixin.top/api/v1/fbinfo/infoNav", parameter, ^(NSError *error) {
//              NSLog(@"解析失败");
//          }, ^(NSDictionary *dic) {
//              NSLog(@"解析成功");
//              if([dic[@"code"] intValue] == 200){
//
//                  self->apiGlobalArr = dic[@"data"];
//                  NSString *str =self->apiGlobalArr[0][@"country_array"][0][@"country_name"][0];
//                  NSLog(@"数组-1-%@",str);
//                  NSString *str1 =self->apiGlobalArr[0][@"country_array"][1][@"country_name"][0];
//                   NSLog(@"数组-2-%@",str1);
//
//                  self->_textLabel = @[str,str1];
//                  [self.tableView reloadData];
//              }}
//              );//NSLog(@"测试:%@",dic);//打印
  
 
    /*
    UIImage *image = [UIImage imageNamed:@"TestName@2x.png"];
    NSMutableDictionary *parameter =[[NSMutableDictionary alloc]init];
  
    NSArray *imgArr = [NSArray arrayWithObjects:image, nil];
    requestPostImage(@"https://sports.hxweixin.top/api/v1/common/uploadImage", parameter,imgArr, ^(NSError *error) {
        NSLog(@"失败"); 
    }, ^(NSDictionary *dic) {
        NSLog(@"成功");
        if([dic[@"code"] intValue] == 200){
            
        }NSLog(@"打印数据:%@",dic);
        
    });
     */
    

}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
//每组的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return  self->_textLabel.count;
}
//组之间的距离
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return 0.1*KWIDTH;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.00000001;
}
//行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 88*KWIDTH;
}
//数据源
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"it's cell data";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell){
        //初始化
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
   // cell.textLabel.text = @"死值";
    cell.textLabel.text = self->_textLabel[indexPath.row];
//    if(indexPath.row == 0){
//         cell.textLabel.text =  self->apiGlobalArr[0][@"country_array"][0][@"country_name"][0];
//    }else if (indexPath.row == 1){
//         cell.textLabel.text =  self->apiGlobalArr[0][@"country_array"][1][@"country_name"][0];
//    }
   
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
// 在手指离开的那一刻进行反选中
[tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
