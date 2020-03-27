//
//  sdWebImageLoadImg.m
//  ApiTest
//
//  Created by test on 2020/3/24.
//  Copyright © 2020 test. All rights reserved.
//




#import "sdWebImageLoadImg.h"
#import "SVProhressHUD.h"
@interface sdWebImageLoadImg ()
@property (weak, nonatomic) IBOutlet UIImageView *SD_Web_load;

@end

@implementation sdWebImageLoadImg

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSURL *urlSXtr = [NSURL URLWithString:@"https://pic.hxweixin.top/images/20200310/93a7944fa9a46f75a34330c0fa85cab0.jpg"];
    [self.SD_Web_load sd_setImageWithURL:urlSXtr placeholderImage:defaultImg];
    
 //   [SVProhressHUD showErrorWithStatus:@"ProductID为无效ID"];

}


@end
