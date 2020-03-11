//
//  JHGlobalMethod.h
//  August
//
//  Created by 舒金辉 on 2018/7/24.
//  Copyright © 2018年 舒金辉. All rights reserved.
//







#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface JHGlobalMethod : NSObject

+ (JHGlobalMethod *)shareMethod;

#pragma mark  是否隐藏导航栏
void hideNavBarWithBool(BOOL hide);
#pragma mark  设置根视图
void changeRootViewController(UIViewController *viewCtl);

#pragma mark  设置状态栏背景颜色
void setStatusBarBackgroundColor(UIColor *color);








#pragma mark 自定义view
//CustomNavigationbBar(rectNav, color(255,255,255));
 UIView *CustomNavigationbBar(CGRect rect,UIColor *color);

#pragma mark 自定义UIBarButtonItem
UIBarButtonItem  *customBarButtonItem(UIColor *color,NSString *title);

#pragma mark  创建button
UIButton *getButton(CGRect rect,NSString *title,UIColor *titleColor,UIFont *font,UIColor *backgroundColor);
//UIButton *addButton(CGRect rect,NSString *title,UIColor *titleColor,UIFont *font) action:(SEL)action;
#pragma mark  创建Label
UILabel *getLabel(CGRect rect,NSString *title,UIColor *titleColor,UIFont *font);
#pragma mark  创建ImageView
UIImageView *getImgView(CGRect rect,UIViewContentMode mode);

#pragma mark  自定义颜色转换
id colorWithHexString  (NSString *color);
#pragma mark  数组转json字符串
NSString *arrayToJSONString(NSArray *array);

#pragma mark  时间戳转时间（毫秒的时间戳）
NSString *timeWithTimeIntervalString(NSString *timeString, NSString *dateFormat);

#pragma mark  将json转为字典
NSDictionary *dictionaryWithJsonString(NSString *jsonString) ;

#pragma mark  获取图片
UIImage *getImage(NSString *string);
#pragma mark  设置圆角
void getLayerCornerRadius(UIView *vi,CGFloat radius,BOOL clips);

#pragma mark  设置边框
void getLayerBorder(UIView *vi,CGFloat Width,UIColor *color);

#pragma mark  提示词
void showAlertHint (NSString * hint);
#pragma mark  显示
void showWindowHUDView(void);
#pragma mark 隐藏
void hidWindowHUBView(void);

#pragma mark 是否空值
NSString *getContentStr (id content_str, NSString *replace_str);

#pragma mark 验证手机号格式
bool checkTel(NSString * str);

#pragma mark 利用正则表达式验证邮箱
bool isValidateEmail(NSString *email);




#pragma mark 保存本地数据
void saveUserInfo(NSString *keyName,id valueName);
#pragma mark 获取本地数据
NSString *  getUserInfo(NSString *keyName);
#pragma mark 删除本地数据
void removeUserInfo(NSString *key);
#pragma mark 是否空值
NSString *modeContent(id contentStr, NSString *tidaiStr);

#pragma mark 设置label字体颜色大小
void Attributedlabel(UILabel *label,NSArray *attributedArr);



#pragma mark 中划线
NSMutableAttributedString *AttributedMidText(NSString *texstr);

#pragma mark 下划线
NSMutableAttributedString *AttributedMaxText(NSString *texstr);

#pragma mark 截取下标之前字符串
NSString *substringToIndex(NSString *texstr,NSInteger index);

#pragma mark 截取下标之后字符串
NSString *substringFromIndex(NSString *texstr,NSInteger index);

#pragma mark 匹配字符串,截取范围
NSString *substringWithRange(NSString *texstr,NSInteger index,NSInteger index2);

#pragma mark 判断该字符是否在字符串
bool characterString(NSString *texstr,NSString *charstr);

#pragma mark 获取app版本号
NSString *getAPPVerion(void);

#pragma mark 获取UUID
NSString *getUUID(void);

#pragma mark appStore下载地址
NSString *getAppStore(NSString *ID);

#pragma mark 拨打电话
void dialPhone(NSString *phone);




@end
