//
//  JHDateTimeChooseView.h
//  Windspell
//
//  Created by ios on 2018/3/14.
//  Copyright © 2018年 gdswwwios8. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JHDateTimeChooseView : UIView
@property (nonatomic,strong) UIView *whiteView;
@property (nonatomic,strong) NSArray *dataArray;
@property (nonatomic,strong) UILabel *titleLabel;
/**
 默认滚动到当前时间
 */
-(instancetype)initWithDateStyle:(CGRect)frame CompleteBlock:(void(^)(NSString *))completeBlock;

-(void)show;

@end
