//
//  DXGPUImageFIlter.h
//  CameraBox
//
//  Created by Chenyan on 16/8/1.
//  Copyright © 2016年 chenyan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DXGPUImageFIlter : NSObject

+ (UIImage *)filterImage:(UIImage *)sourceImage WithW:(CGFloat)w B:(CGFloat)b C:(CGFloat)c;

+ (NSData *)filterImageToData:(UIImage *)sourceImage WithW:(CGFloat)w B:(CGFloat)b C:(CGFloat)c;

@end
