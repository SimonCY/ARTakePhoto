//
//  ViewController.m
//  ARTakePhoto
//
//  Created by RRTY on 16/11/23.
//  Copyright © 2016年 deepAI. All rights reserved.
//

#import "ViewController.h"
#import "GPUCameraViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor yellowColor];
    
}

#pragma mark - touch
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    GPUCameraViewController *vc = [[GPUCameraViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
