//
//  YAScreenShotClass.m
//  MyBook
//
//  Created by FaceUI on 13-7-16.
//  Copyright (c) 2013年 faceUI_anyi. All rights reserved.
//

#import "YAScreenShotClass.h"

@implementation YAScreenShotClass
+(UIImage *)screenShotFrom:(UIView *)view frame:(CGRect)frame
{
 
    UIGraphicsBeginImageContextWithOptions(frame.size, NO, 0.0);
    //获取图像
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
//    static int index;
//    //保存图像
//    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) objectAtIndex:0];
//    NSLog(@"%@",path);
//    if ([UIImagePNGRepresentation(image) writeToFile:path atomically:YES]) {
//        index += 1;
//        NSLog(@"Succeeded!");
//    }
//    else {
//        NSLog(@"Failed!");
//    }
    return image;
}
@end
