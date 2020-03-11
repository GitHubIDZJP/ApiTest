//
//  JHGlobalMethod.m
//  August
//
//  Created by 舒金辉 on 2018/7/24.
//  Copyright © 2018年 舒金辉. All rights reserved.




#import "JHGlobalMethod.h"
#import "MBProgressHUD.h"

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




//
//UIButton *addButton(CGRect rect,NSString *title,UIColor *titleColor,UIFont *font) action:(SEL)action
//{
//    UIButton *button = [[UIButton alloc]initWithFrame:rect];
//    [button setTitle:title forState:UIControlStateNormal];
//    [button setTitleColor:titleColor forState:UIControlStateNormal];
//    button.titleLabel.font = font;
//    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
//    return button;
//}
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

//自定义颜色转换
id colorWithHexString  (NSString *color)
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
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
    //显示提示信息
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled = NO;
    // Configure for text only and offset down
    
    //    hud.color = mainColor;
    hud.mode = MBProgressHUDModeText;
    hud.label.text = hint;
    hud.margin = 10.f;
   // hud.yOffset = IS_IPHONE_5?200.f:150.f;
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
    //    NSMutableArray *muArray = [NSMutableArray array];
    //    for (NSString *userId in array) {
    //        [muArray addObject:[NSString stringWithFormat:@"\"%@\"", userId]];
    //    }
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    //    NSString *jsonTemp = [jsonString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    //    NSString *jsonResult = [jsonTemp stringByReplacingOccurrencesOfString:@" " withString:@""];
    //    NSLog(@"json array is: %@", jsonResult);
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
    [def synchronize];
}
#pragma mark 获取本地数据
NSString *  getUserInfo(NSString *keyName)
{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    return [def objectForKey:keyName];
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


@end
