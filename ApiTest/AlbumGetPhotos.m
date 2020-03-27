//
//  AlbumGetPhotos.m
//  ApiTest
//
//  Created by test on 2020/3/19.
//  Copyright © 2020 test. All rights reserved.
//


//相册获取图片
#import "AlbumGetPhotos.h"
#import <AssetsLibrary/AssetsLibrary.h>//系统库
@interface AlbumGetPhotos ()<UINavigationControllerDelegate, UIImagePickerControllerDelegate>
- (IBAction)showImagePickerVC:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation AlbumGetPhotos

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UIImage *img = [UIImage imageNamed:@"TestName@2x.png"];
//    saveImage(img, @"TestName@2x.png");
}
- (IBAction)showImagePickerVC:(id)sender
{
    UIImagePickerController *imagePickerVC = [[UIImagePickerController alloc] init];
    imagePickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickerVC.allowsEditing = YES;
    imagePickerVC.delegate = self;
    [self presentViewController:imagePickerVC animated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    //1.选择的是图片资源
    if ([type isEqualToString:@"public.image"]) {
    UIImage  *selImg = info[UIImagePickerControllerOriginalImage];
        _imageView.image = selImg;
        saveImage(selImg, @"fileName");

       NSData *imageData = UIImageJPEGRepresentation(selImg,0.5);//图片压缩
        
        
        
    }
    
   
}

@end
