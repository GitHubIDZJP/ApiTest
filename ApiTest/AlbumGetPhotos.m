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
        
        
//         [ _imageView
//        setImage:[info
//        objectForKey:@"UIImagePickerControllerOriginalImage"]];
//             _imageView.hidden=NO;
        
        
        _imageView.image = selImg;
        
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        // 得到本地沙盒中名为"MyImage"的路径，"MyImage"是保存的图片名
        NSString *imageFilePath = [path stringByAppendingPathComponent:@"MyImage"];
        // 将取得的图片写入本地的沙盒中，其中0.5表示压缩比例，1表示不压缩，数值越小压缩比例越大
        BOOL success = [UIImageJPEGRepresentation(selImg, 0.5) writeToFile:imageFilePath  atomically:YES];
        if (success){
            NSLog(@"写入本地成功");
        }

        
        
        
       //NSData *imageData = UIImageJPEGRepresentation(selImg,0.5);//图片压缩
         //saveImage(@"sd",imageData);
        
        
    }
    
   
}

@end
