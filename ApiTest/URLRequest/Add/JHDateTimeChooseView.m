//
//  JHDateTimeChooseView.m
//  Windspell
//
//  Created by ios on 2018/3/14.
//  Copyright © 2018年 gdswwwios8. All rights reserved.
//

#import "JHDateTimeChooseView.h"
#import "JHGlobalMethod.h"

typedef void(^doneBlock)(NSString *);

@interface JHDateTimeChooseView ()<UIPickerViewDelegate,UIPickerViewDataSource,UIGestureRecognizerDelegate>
{
     NSString *_startDate;
}
@property (nonatomic,strong)UIPickerView *datePicker;
@property (nonatomic,strong) NSMutableArray *dataArr;
@property (nonatomic,strong)doneBlock doneBlock;
@end

@implementation JHDateTimeChooseView


-(instancetype)initWithDateStyle:(CGRect)frame CompleteBlock:(void(^)(NSString *))completeBlock
{
     self = [super initWithFrame:frame];
    
    if (self) {
        
         self.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.3];
        
        self.whiteView.frame = CGRectMake(0, frame.size.height - frame.size.height / 2.5, SCREEN_WIDTH, frame.size.height / 2.5);
        [self addSubview:self.whiteView];

        [self.whiteView addSubview:self.datePicker];
        
        
        
        NSArray *arr = @[@"取消",@"确定"];
        
        [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            //UIButton *btn = getButton(CGRectMake(0 + (frame.size.width - 50) * idx, 0, 50, 40), obj, White3, Font13);
            UIButton *btn = getButton(CGRectMake(0 + (frame.size.width - 50) * idx, 0, 50, 40), obj, UIColor.whiteColor, nil, nil);
            if (idx == 1) {
                [btn setTitleColor:UIColor.blueColor forState:UIControlStateNormal];
            }
            btn.tag = idx;
            [self.whiteView addSubview:btn];
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            
        }];
        
        UILabel *label = getLabel(CGRectMake(80, 0, frame.size.width - 160, 40), @"出发日期", White3, Font14);
        label.textAlignment = NSTextAlignmentCenter;
        [self.whiteView addSubview:label];
        self.titleLabel = label;
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 41, SCREEN_WIDTH, 1)];
        line.backgroundColor = UIColor.redColor;
        [self.whiteView addSubview:line];
        //点击背景是否影藏
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismiss)];
        tap.delegate = self;
        [self addGestureRecognizer:tap];

        
        if (completeBlock) {
            self.doneBlock = ^(NSString *selectDate) {
                completeBlock(selectDate);
            };
        }
    }
    
    return self;
}

- (void)btnClick:(UIButton *)sender
{
    if(sender.tag == 0)
    {
        [self dismiss];
        
    }else
    {
        self.doneBlock(_startDate);
        [self dismiss];
    }
}
- (NSMutableArray *)dataArr
{
    if (!_dataArr) {
        
        _dataArr = [NSMutableArray array];
        
    }
    return _dataArr;
}

- (void)setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;
    
    [self.dataArr removeAllObjects];
    
    [self.dataArr addObjectsFromArray:dataArray];
    
    [self.datePicker reloadAllComponents];
    
    _startDate = dataArray[0];
    
}


- (UIView *)whiteView
{
    if (!_whiteView) {
        
        _whiteView = [[UIView alloc]init];
        _whiteView.backgroundColor = [UIColor whiteColor];
    }
    return _whiteView;
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if( [touch.view isDescendantOfView:self.whiteView]) {
        return NO;
    }
    return YES;
}


#pragma mark - getter / setter
-(UIPickerView *)datePicker {
    if (!_datePicker) {
        _datePicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, CGRectGetHeight(self.whiteView.frame) - 40)];
        _datePicker.showsSelectionIndicator = YES;
        _datePicker.delegate = self;
        _datePicker.dataSource = self;
    }
    return _datePicker;
}
#pragma mark - Action
-(void)show {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:.3 animations:^{
        //        self.bottomConstraint.constant = bottom_height;
        [self layoutIfNeeded];
    }];
    
    
}
-(void)dismiss {
    
    [UIView animateWithDuration:.3 animations:^{
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [self removeFromSuperview];
    }];
    
}

#pragma mark - UIPickerViewDelegate,UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
    
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
     return self.dataArr.count;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return 40;
}


-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel *customLabel = (UILabel *)view;
    if (!customLabel) {
        customLabel = [[UILabel alloc] init];
        customLabel.textAlignment = NSTextAlignmentCenter;
        [customLabel setFont:[UIFont systemFontOfSize:17]];
    }
    NSString *title;
    
    title = self.dataArr[row];
    customLabel.text = title;

    customLabel.textColor = White3;
    return customLabel;
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSLog(@"%@",self.dataArr[row]);
    
    _startDate =self.dataArr[row];

    
}

@end
