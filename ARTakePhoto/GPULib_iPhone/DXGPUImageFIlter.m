//
//  DXGPUImageFIlter.m
//  CameraBox
//
//  Created by Chenyan on 16/8/1.
//  Copyright © 2016年 chenyan. All rights reserved.
//

#import "DXGPUImageFIlter.h"
#import "GPUImage.h"

@implementation DXGPUImageFIlter
+ (UIImage *)filterImage:(UIImage *)sourceImage WithW:(CGFloat)w B:(CGFloat)b C:(CGFloat)c {
    @autoreleasepool {



        //--------------白平衡--------------
        //创建滤镜
        GPUImageWhiteBalanceFilter *whiterBanlanceFilter = [[GPUImageWhiteBalanceFilter alloc] init];
        whiterBanlanceFilter.temperature = w;
        //设置渲染区域
        [whiterBanlanceFilter forceProcessingAtSize:sourceImage.size];
        //如果需要处理滤镜处理后的结果，应显示指出
        [whiterBanlanceFilter useNextFrameForImageCapture];


        //---------------亮度--------------
        GPUImageBrightnessFilter *brightFilter = [[GPUImageBrightnessFilter alloc] init];
        brightFilter.brightness = b;
        [brightFilter forceProcessingAtSize:sourceImage.size];
        [brightFilter useNextFrameForImageCapture];


        //--------------对比度--------------
        GPUImageContrastFilter *contrastFilter = [[GPUImageContrastFilter alloc] init];
        contrastFilter.contrast = c;
        [contrastFilter forceProcessingAtSize:sourceImage.size];
        [contrastFilter useNextFrameForImageCapture];

        //输入源
        GPUImagePicture *sourceInput = [[GPUImagePicture alloc] initWithImage:sourceImage];
        
        //创建组合滤镜
        NSArray *filters = @[whiterBanlanceFilter,brightFilter,contrastFilter];
        GPUImageFilterPipeline *filterLine = [[GPUImageFilterPipeline alloc]initWithOrderedFilters:filters input:sourceInput output:nil];
        [sourceInput processImage];

        //获取图片
        UIImage *newImage = [filterLine currentFilteredFrame];

        NSData *data = UIImageJPEGRepresentation(newImage,0.5);

        UIImage *result = [[UIImage alloc] initWithData:data];

        //处理后的释放
        newImage = nil;

        [filterLine removeAllFilters];
        filterLine = nil;

        [sourceInput removeAllTargets];
        [sourceInput removeOutputFramebuffer];
        sourceInput = nil;

        [whiterBanlanceFilter removeAllTargets];
        [brightFilter removeAllTargets];
        [contrastFilter removeAllTargets];

        [whiterBanlanceFilter useNextFrameForImageCapture];
        [brightFilter useNextFrameForImageCapture];
        [contrastFilter useNextFrameForImageCapture];

        [whiterBanlanceFilter endProcessing];
        [brightFilter endProcessing];
        [contrastFilter endProcessing];


        //清除显存
        [[GPUImageContext sharedImageProcessingContext].framebufferCache purgeAllUnassignedFramebuffers];

        return result;
    }
}

+ (NSData *)filterImageToData:(UIImage *)sourceImage WithW:(CGFloat)w B:(CGFloat)b C:(CGFloat)c {
    @autoreleasepool {



        //--------------白平衡--------------
        //创建滤镜
        GPUImageWhiteBalanceFilter *whiterBanlanceFilter = [[GPUImageWhiteBalanceFilter alloc] init];
        whiterBanlanceFilter.temperature = w;
        //设置渲染区域
        [whiterBanlanceFilter forceProcessingAtSize:sourceImage.size];
        //如果需要处理滤镜处理后的结果，应显示指出
        [whiterBanlanceFilter useNextFrameForImageCapture];


        //---------------亮度--------------
        GPUImageBrightnessFilter *brightFilter = [[GPUImageBrightnessFilter alloc] init];
        brightFilter.brightness = b;
        [brightFilter forceProcessingAtSize:sourceImage.size];
        [brightFilter useNextFrameForImageCapture];


        //--------------对比度--------------
        GPUImageContrastFilter *contrastFilter = [[GPUImageContrastFilter alloc] init];
        contrastFilter.contrast = c;
        [contrastFilter forceProcessingAtSize:sourceImage.size];
        [contrastFilter useNextFrameForImageCapture];

        //输入源
        GPUImagePicture *sourceInput = [[GPUImagePicture alloc] initWithImage:sourceImage];

        //创建组合滤镜
        NSArray *filters = @[whiterBanlanceFilter,brightFilter,contrastFilter];
        GPUImageFilterPipeline *filterLine = [[GPUImageFilterPipeline alloc]initWithOrderedFilters:filters input:sourceInput output:nil];
        [sourceInput processImage];

        //获取图片
        UIImage *newImage = [filterLine currentFilteredFrame];

        NSData *result = UIImageJPEGRepresentation(newImage,0.5);

        //处理后的释放
        newImage = nil;

        [filterLine removeAllFilters];
        filterLine = nil;

        [sourceInput removeAllTargets];
        [sourceInput removeOutputFramebuffer];
        sourceInput = nil;

        [whiterBanlanceFilter removeAllTargets];
        [brightFilter removeAllTargets];
        [contrastFilter removeAllTargets];

        [whiterBanlanceFilter useNextFrameForImageCapture];
        [brightFilter useNextFrameForImageCapture];
        [contrastFilter useNextFrameForImageCapture];

        [whiterBanlanceFilter endProcessing];
        [brightFilter endProcessing];
        [contrastFilter endProcessing];


        //清除显存
        [[GPUImageContext sharedImageProcessingContext].framebufferCache purgeAllUnassignedFramebuffers];
        
        return result;
    }
}


@end
