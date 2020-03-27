//
//  JHGlobalMethod.m
//  August
//
//  Created by 舒金辉 on 2018/7/24.
//  Copyright © 2018年 舒金辉. All rights reserved.




#import "JHGlobalMethod.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"
#import "ImageIO/ImageIO.h"
@implementation JHGlobalMethod

static JHGlobalMethod *global = nil;
// 创建单例
+ (JHGlobalMethod *)shareMethod
{
    @synchronized(self) {
        if (global == nil) {
            global = [[JHGlobalMethod alloc] init];
        }
    }
    return global;
}
   

UIView *CustomNavigationbBar(CGRect rect,UIColor *color)
{
    
    UIView *custonmView =[[UIView alloc]initWithFrame:rect];
    custonmView.backgroundColor =color;
    return  custonmView;
}
UIBarButtonItem *customBarButtonItem(UIColor *color,NSString *title)
{
    UIBarButtonItem *btn =[[UIBarButtonItem alloc]init];
    btn.title = title;
    btn.tintColor = color;
    return btn;
}
// 是否隐藏导航栏
void hideNavBarWithBool(BOOL hide)
{
     [[[UIApplication sharedApplication] delegate] window].rootViewController.navigationController.navigationBarHidden = hide;
}
// 设置根视图
void changeRootViewController(UIViewController *viewCtl)
{
     [[[UIApplication sharedApplication] delegate] window].rootViewController = viewCtl;
}
// 创建button
UIButton *getButton(CGRect rect,NSString *title,UIColor *titleColor,UIFont *font,UIColor *backgroundColor)
{
    UIButton *button = [[UIButton alloc]initWithFrame:rect];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    button.titleLabel.font = font;
    [button setBackgroundColor:backgroundColor];
    return button;

}
// 创建Label
UILabel *getLabel(CGRect rect,NSString *title,UIColor *titleColor,UIFont *font)
{
 
    UILabel *label = [[UILabel alloc]initWithFrame:rect];
    label.text = title;
    label.textColor = titleColor;
    label.font = font;
    
    return label;
}

#pragma mark  创建ImageView
UIImageView *getImgView(CGRect rect,UIViewContentMode mode)
{
    UIImageView *img = [[UIImageView alloc]initWithFrame:rect];
    img.clipsToBounds = YES;
    img.contentMode = mode;
    
    
    return img;
}

//自定义颜色转换----->
id colorWithHexString  (NSString *color)
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];


    
    
    
        // String should be 6 or 8 characters
        if ([cString length] < 6) {
            return [UIColor clearColor];
        }
        // 判断前缀
        if ([cString hasPrefix:@"0X"])
            cString = [cString substringFromIndex:2];
        if ([cString hasPrefix:@"#"])
            cString = [cString substringFromIndex:1];
        if ([cString length] != 6)
            return [UIColor clearColor];
        // 从六位数值中找到RGB对应的位数并转换
        NSRange range;
        range.location = 0;
        range.length = 2;
        //R、G、B
        NSString *rString = [cString substringWithRange:range];
        range.location = 2;
        NSString *gString = [cString substringWithRange:range];
        range.location = 4;
        NSString *bString = [cString substringWithRange:range];
        // Scan values
        unsigned int r, g, b;
        [[NSScanner scannerWithString:rString] scanHexInt:&r];
        [[NSScanner scannerWithString:gString] scanHexInt:&g];
        [[NSScanner scannerWithString:bString] scanHexInt:&b];
        return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
    }
void showAlertHint (NSString * hint)
{
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled = NO;
    hud.mode = MBProgressHUDModeText;
    hud.label.text = hint;
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hideAnimated:YES afterDelay:2];
}

void showWindowHUDView(void)
{
    UIView *view = [UIApplication sharedApplication].keyWindow;
    
    MBProgressHUD *hud = (MBProgressHUD *)[view viewWithTag:50000];
    if (!hud)
    {
        hud = [[MBProgressHUD alloc] initWithView:view];
        hud.tag = 50000;
        //
        hud.mode = MBProgressHUDModeCustomView;
        hud.square = NO;
        hud.margin = 0.f;
        
        [view addSubview:hud];
    }
    
    
    [hud showAnimated:YES];
}
void hidWindowHUBView(void)
{
    UIView *view = [UIApplication sharedApplication].keyWindow;
    
    MBProgressHUD *hud = (MBProgressHUD *)[view viewWithTag:50000];
    if (hud)
    {
        [hud hideAnimated:YES];
    }
}
// 数组转json字符串
NSString *arrayToJSONString(NSArray *array)
{
    NSError *error = nil;
   
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonString;
}

// 时间戳转时间（毫秒的时间戳）
NSString *timeWithTimeIntervalString(NSString *timeString, NSString *dateFormat)
{
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    //    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:dateFormat];
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue] / 1000];
    NSString* dateString = [formatter stringFromDate:date];
    //    NSLog(@"时间 === %@",dateString);
    return dateString;
}

/*!
 * @brief 把格式化的JSON格式的字符串转换成字典
 * @param jsonString JSON格式的字符串
 * @return 返回字典
 */
NSDictionary *dictionaryWithJsonString(NSString *jsonString)
{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}
// 获取图片
UIImage *getImage(NSString *string)
{
    UIImage *image = [UIImage imageNamed:string];
    return image;
}
NSString *UIImageToBase64Str(UIImage *image){
    NSData *data = UIImageJPEGRepresentation(image, 1.0f);
    NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return encodedImageStr;
}
// 设置圆角
void getLayerCornerRadius(UIView *vi,CGFloat radius,BOOL clips)
{
    vi.layer.cornerRadius = radius;
    vi.layer.masksToBounds = clips;

}

/**
 设置状态栏背景颜色
 
 @param color 设置颜色
 */
void setStatusBarBackgroundColor(UIColor *color) {
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
}
#pragma mark  设置边框
void getLayerBorder(UIView *vi,CGFloat Width,UIColor *color)
{
    vi.layer.borderWidth = Width;
    vi.layer.borderColor = color.CGColor;
}

#pragma mark 设置label字体颜色大小
void Attributedlabel(UILabel *label,NSArray *attributedArr)
{
    
    // 创建Attributed
    NSMutableAttributedString *noteStr = [[NSMutableAttributedString alloc] initWithString:label.text];
    
    for (int i = 0; i < attributedArr.count; i++) {
        
        
        NSRange rang = NSMakeRange([attributedArr[i][@"loc"] integerValue], [attributedArr[i][@"len"] integerValue]);
        
        if (attributedArr[i][@"color"]) {
            UIColor *color = attributedArr[i][@"color"];
            // 改变颜色
            [noteStr addAttribute:NSForegroundColorAttributeName value:color range:rang];
        }
        
        if (attributedArr[i][@"font"]) {
            CGFloat font = [attributedArr[i][@"font"] floatValue];
            
            // 改变字体大小及类型
            [noteStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:font] range:rang];
        }
        
        
        
    }
    // 为label添加Attributed
    [label setAttributedText:noteStr];
}

#pragma mark 是否空值
NSString *getContentStr (id content_str, NSString *replace_str)
{
    if ([content_str isKindOfClass:[NSNull class]] || ![content_str isKindOfClass:[NSString class]]) {
        
        return replace_str;
    }
    else
        return  content_str;
}

NSString *modeContent(id contentStr, NSString *tidaiStr)
{
    if (![contentStr isKindOfClass:[NSNull class]] && [contentStr isKindOfClass:[NSString class]]) {
        return [NSString stringWithFormat:@"%@",contentStr];
    }
    return tidaiStr;
}

#pragma mark 保存本地数据
void saveUserInfo(NSString *keyName,id valueName)
{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    [def setObject:valueName forKey:keyName];
    [def synchronize];//同步
}
void saveLocalInfo(NSString *localKey,id localName){
    NSUserDefaults *localData = [NSUserDefaults standardUserDefaults];
    [localData setObject:localKey forKey:localName];
    [localData synchronize];
}
#pragma mark 获取本地数据
NSString *  getUserInfo(NSString *keyName)
{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    return [def objectForKey:keyName];
}
NSString *  getLocalInfo(NSString *localName){
    NSUserDefaults *localData = [NSUserDefaults standardUserDefaults];
       return [localData objectForKey:localName];
}
#pragma mark 删除本地数据
void removeUserInfo(NSString *key)
{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    [def removeObjectForKey:key];
    [def synchronize];
}
#pragma mark 验证手机号格式
bool checkTel(NSString * str)
{
    if ([str length] == 0) {
        return NO;
    }
    NSString *regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0,5-9]))\\d{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:str];
    if (!isMatch) {
        return NO;
    }
    return YES;
}

#pragma mark 利用正则表达式验证邮箱
bool isValidateEmail(NSString *email)
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    BOOL isT = [emailTest evaluateWithObject:email];
    return isT;
}

#pragma mark 中划线
NSMutableAttributedString *AttributedMidText(NSString *texstr)
{
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:texstr attributes:attribtDic];
    
    return attribtStr;

}

#pragma mark 下划线
NSMutableAttributedString *AttributedMaxText(NSString *texstr)
{
    NSDictionary *attribtDic = @{NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:texstr attributes:attribtDic];

     return attribtStr;
}

#pragma mark 截取下标之前字符串
NSString *substringToIndex(NSString *texstr,NSInteger index)
{
    return [texstr substringToIndex:index];
}

#pragma mark 截取下标之后字符串
NSString *substringFromIndex(NSString *texstr,NSInteger index)
{
    return [texstr substringFromIndex:index];
}

#pragma mark 匹配字符串，截取范围
NSString *substringWithRange(NSString *texstr,NSInteger index,NSInteger index2)
{
    NSRange range = NSMakeRange(index, index2);
    return  [texstr substringWithRange:range];
}

#pragma mark 判断该字符是否在字符串
bool characterString(NSString *texstr,NSString *charstr)
{
    BOOL isBool = [texstr rangeOfString:charstr].location != NSNotFound;
    
    return isBool;
}

#pragma mark 获取app版本号
NSString *getAPPVerion(void)
{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    

}

#pragma mark 获取UUID
NSString *getUUID(void)
{
     return [[UIDevice currentDevice] identifierForVendor].UUIDString;
}
#pragma mark appStore下载地址
NSString *getAppStore(NSString *ID)
{
    return [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@",ID];
}

#pragma mark 拨打电话
void dialPhone(NSString *phone)
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt:%@",phone]]];
   
}
#pragma mark---->获取文字大小
CGSize getTextSize(NSString *text, UIFont *font, CGFloat width)
{
    NSDictionary *dict=[NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName, nil];
    CGSize size=[text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:dict context:nil].size;
    return size;
}
//保存网络请求数据
void saveDownloadInfo (NSString* fileName, id sourceData){
    id obc = sourceData;
       
       BOOL isSucceed = [NSKeyedArchiver archiveRootObject:obc toFile:userInfoFile1(fileName)];
       if (isSucceed) {
           NSLog(@"保存成功");
       }else
       {
           NSLog(@"保存失败");
       }
}
//获取保存网络请求数据
id getDownloadData (NSString *fileName){
    id data;
    
    if ([[NSFileManager defaultManager]fileExistsAtPath:userInfoFile(fileName)]) {
        
        data = [NSKeyedUnarchiver unarchiveObjectWithFile:userInfoFile(fileName)];
        
    }
    
    return data;
}
//删除保存网络请求数据
void deleteDownloadData (NSString *fileName){
    if ([[NSFileManager defaultManager]fileExistsAtPath:userInfoFile(fileName)]) {
           
           BOOL isSucceed = [[NSFileManager defaultManager]removeItemAtPath:userInfoFile(fileName) error:nil];
           
           if (isSucceed) {
               NSLog(@"删除成功");
           }else
           {
               NSLog(@"删除失败");
           }
           
       }
}
NSDate* getdateTimeBytimeStr(NSString *timeStr){
     NSDate *returnDate;
    // timeStr = @"2015-7-18 09:54";
    // timeStr = @"今天 09:54";
    NSTimeInterval secondsPerDay = 24 * 60 * 60;
    
    NSString *subString  = [timeStr substringToIndex:2];
    
    NSDate *today = [NSDate date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy年MM月dd日"];
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc]init];
    [dateFormatter2 setDateFormat:@"yyyy年MM月dd日 HH:mm"];
    
    if ([subString isEqualToString:@"今天"]) {
        NSString *todayString = [dateFormatter stringFromDate:today];
        NSString *time_str = [NSString stringWithFormat:@"%@ %@",todayString,[timeStr substringFromIndex:timeStr.length - 5]];
        returnDate = [dateFormatter2 dateFromString:time_str];
        
    }else if([subString isEqualToString:@"明天"]){
        NSDate *tomorrow = [today dateByAddingTimeInterval:secondsPerDay];
        NSString *tomorrowStr = [dateFormatter stringFromDate:tomorrow];
        NSString *time_str = [NSString stringWithFormat:@"%@ %@",tomorrowStr,[timeStr substringFromIndex:timeStr.length - 5]];
        returnDate = [dateFormatter2 dateFromString:time_str];
        
    }else if([subString isEqualToString:@"后天"]){
        NSDate *tomorrow = [today dateByAddingTimeInterval: 2 * secondsPerDay];
        NSString *tomorrowStr = [dateFormatter stringFromDate:tomorrow];
        NSString *time_str = [NSString stringWithFormat:@"%@ %@",tomorrowStr,[timeStr substringFromIndex:timeStr.length - 5]];
        returnDate = [dateFormatter2 dateFromString:time_str];
        
    }else if([subString isEqualToString:@"昨天"]){
        NSDate *tomorrow = [today dateByAddingTimeInterval:-secondsPerDay];
        NSString *tomorrowStr = [dateFormatter stringFromDate:tomorrow];
        NSString *time_str = [NSString stringWithFormat:@"%@ %@",tomorrowStr,[timeStr substringFromIndex:timeStr.length - 5]];
        returnDate = [dateFormatter2 dateFromString:time_str];
        
    }else if([subString isEqualToString:@"前天"]){
        NSDate *tomorrow = [today dateByAddingTimeInterval:- 2 * secondsPerDay];
        NSString *tomorrowStr = [dateFormatter stringFromDate:tomorrow];
        NSString *time_str = [NSString stringWithFormat:@"%@ %@",tomorrowStr,[timeStr substringFromIndex:timeStr.length - 5]];
        returnDate = [dateFormatter2 dateFromString:time_str];
    }else{
        returnDate = [dateFormatter2 dateFromString:timeStr];
    }
    
    return returnDate;

}

-(NSDate*)getdateTimeBytimeStr:(NSString *)timeStr{
    NSDate *returnDate;
    
    // timeStr = @"2015-7-18 09:54";
    // timeStr = @"今天 09:54";
    NSTimeInterval secondsPerDay = 24 * 60 * 60;
    
    NSString *subString  = [timeStr substringToIndex:2];
    
    NSDate *today = [NSDate date];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy年MM月dd日"];
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc]init];
    [dateFormatter2 setDateFormat:@"yyyy年MM月dd日 HH:mm"];
    
    if ([subString isEqualToString:@"今天"]) {
        NSString *todayString = [dateFormatter stringFromDate:today];
        NSString *time_str = [NSString stringWithFormat:@"%@ %@",todayString,[timeStr substringFromIndex:timeStr.length - 5]];
        returnDate = [dateFormatter2 dateFromString:time_str];
        
    }else if([subString isEqualToString:@"明天"]){
        NSDate *tomorrow = [today dateByAddingTimeInterval:secondsPerDay];
        NSString *tomorrowStr = [dateFormatter stringFromDate:tomorrow];
         NSString *time_str = [NSString stringWithFormat:@"%@ %@",tomorrowStr,[timeStr substringFromIndex:timeStr.length - 5]];
        returnDate = [dateFormatter2 dateFromString:time_str];
        
    }else if([subString isEqualToString:@"后天"]){
        NSDate *tomorrow = [today dateByAddingTimeInterval: 2 * secondsPerDay];
        NSString *tomorrowStr = [dateFormatter stringFromDate:tomorrow];
        NSString *time_str = [NSString stringWithFormat:@"%@ %@",tomorrowStr,[timeStr substringFromIndex:timeStr.length - 5]];
        returnDate = [dateFormatter2 dateFromString:time_str];
        
    }else if([subString isEqualToString:@"昨天"]){
        NSDate *tomorrow = [today dateByAddingTimeInterval:-secondsPerDay];
        NSString *tomorrowStr = [dateFormatter stringFromDate:tomorrow];
        NSString *time_str = [NSString stringWithFormat:@"%@ %@",tomorrowStr,[timeStr substringFromIndex:timeStr.length - 5]];
        returnDate = [dateFormatter2 dateFromString:time_str];
        
    }else if([subString isEqualToString:@"前天"]){
        NSDate *tomorrow = [today dateByAddingTimeInterval:- 2 * secondsPerDay];
        NSString *tomorrowStr = [dateFormatter stringFromDate:tomorrow];
        NSString *time_str = [NSString stringWithFormat:@"%@ %@",tomorrowStr,[timeStr substringFromIndex:timeStr.length - 5]];
        returnDate = [dateFormatter2 dateFromString:time_str];
    }else{
        returnDate = [dateFormatter2 dateFromString:timeStr];
    }

    return returnDate;
}

//设置本地通知
void setLocalNoti(NSString *timeStr, NSString *notiName,NSString *bodyName,NSString *daId_bwId_srId){
    NSDate *fireTime = getdateTimeBytimeStr(timeStr);
       UILocalNotification *notification = [[UILocalNotification alloc]init];
       notification.fireDate = fireTime;
       notification.alertAction = bodyName;
       notification.timeZone = [NSTimeZone defaultTimeZone];
       notification.repeatInterval = NSCalendarUnitDay;
       notification.alertBody = bodyName;
       notification.soundName = @"callRing.mp3";
       notification.userInfo = [NSDictionary dictionaryWithObject:notiName forKey:daId_bwId_srId];
       [[UIApplication sharedApplication] scheduleLocalNotification: notification];
       
       
       NSArray *arr = [[UIApplication sharedApplication] scheduledLocalNotifications];
}

#pragma mark 删除通知
void deleteLocalNotification(NSString *key){
    NSArray *arr = [[UIApplication sharedApplication]scheduledLocalNotifications];
    for (UILocalNotification *localNoti in arr) {
        NSDictionary *userInfo = localNoti.userInfo;
       // NSLog(@"******key = %@", [userInfo allKeys][0]);
        NSString *notiKey = [userInfo allKeys][0];
        if ([notiKey isEqualToString:key]) {
            [[UIApplication sharedApplication]cancelLocalNotification:localNoti];
        }
    }
}

void setParamsDictionary(NSMutableDictionary *params,NSString *text,NSString *key){
    if (text.length != 0) {
           [params setObject:text forKey:key];
       }
}
//获取对应语言的国际化
//NSString *getLanguageInternal(NSString *language){
//    return nil;
//}
//获取当前屏幕显示的viewcontroller
- (UIViewController *)getCurrentVC{
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}
#pragma mark getRandomCode  ++++++++++++获取随机码
NSString* getRandomCode(){
    NSString *code = @"";
    for (int i = 0; i < 6; i++) {
        NSInteger num = arc4random() % 10;
        code =[code stringByAppendingFormat:@"%ld",(long)num];
    }
    return code;
}
//将json转为字典
/*!
* @brief 把格式化的JSON格式的字符串转换成字典
* @param jsonString JSON格式的字符串
* @return 返回字典
*/
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString{
    if (jsonString == nil) {
           return nil;
       }
       
       NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
       NSError *err;
       NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                           options:NSJSONReadingMutableContainers
                                                             error:&err];
       if(err) {
           NSLog(@"json解析失败：%@",err);
           return nil;
       }
       return dic;
}
//手机号码验证
BOOL validateMobile(NSString *phoneStr)
{
    NSString *phoneRegex = @"1[3,4,5,7,8][0-9]{9}$|14[0-9]{9}|15[0-9]{9}$|18[0-9]{9}$";//@"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:phoneStr];
}
//竖着拍照上传
UIImage *fixOrientation(UIImage *aImage){
    // No-op if the orientation is already correct
    if (aImage.imageOrientation == UIImageOrientationUp)
        return aImage;

    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;

    switch (aImage.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, aImage.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;

        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;

        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, aImage.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        default:
            break;
    }

    switch (aImage.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;

        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, aImage.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        default:
            break;
    }

    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, aImage.size.width, aImage.size.height,
                                             CGImageGetBitsPerComponent(aImage.CGImage), 0,
                                             CGImageGetColorSpace(aImage.CGImage),
                                             CGImageGetBitmapInfo(aImage.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (aImage.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.height,aImage.size.width), aImage.CGImage);
            break;

        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,aImage.size.width,aImage.size.height), aImage.CGImage);
            break;
    }

    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}
@end
