//
//  GPUCameraViewController.m
//  ARTakePhoto
//
//  Created by RRTY on 16/11/23.
//  Copyright © 2016年 deepAI. All rights reserved.
//

#import "GPUCameraViewController.h"
#import "GPUImage.h"
#import "GPUImageToonFilter.h"

@interface GPUCameraViewController () {
    GPUImageView *view1, *view2;
    GPUImageVideoCamera *videoCamera;
}

@end

@implementation GPUCameraViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    
    [self loadGPUCamera];
}

- (void)loadGPUCamera {
    
    //input
    videoCamera = [[GPUImageVideoCamera alloc] initWithSessionPreset:AVCaptureSessionPresetHigh cameraPosition:AVCaptureDevicePositionBack];
    videoCamera.outputImageOrientation = UIDeviceOrientationLandscapeRight;
    
    CGRect mainScreenFrame = [[UIScreen mainScreen] bounds];
    CGFloat halfWidth = round(mainScreenFrame.size.width / 2.0);
    CGFloat halfHeight = round(mainScreenFrame.size.height / 2.0);
    CGFloat height = round(mainScreenFrame.size.height);
    
    view1 = [[GPUImageView alloc] initWithFrame:CGRectMake(0.0, 0.0, halfWidth, height)];
    view1.backgroundColor = [UIColor greenColor];
    [self.view addSubview:view1];
    view2 = [[GPUImageView alloc] initWithFrame:CGRectMake(halfWidth, 0.0, halfWidth, height)];
    view2.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:view2];
    

    GPUImageFilter *filter1 = [[GPUImageFilter alloc] initWithFragmentShaderFromFile:@"Shader1"];
    GPUImageFilter *filter2 = [[GPUImageFilter alloc] initWithFragmentShaderFromFile:@"Shader2"];
    
    GPUImageToonFilter *toonFilter = [[GPUImageToonFilter alloc] init];
    
    [videoCamera addTarget:toonFilter];
    [toonFilter addTarget:view1];
    [videoCamera addTarget:toonFilter];
    [toonFilter addTarget:view2];
    
    
    [videoCamera startCameraCapture];
    
}

@end
