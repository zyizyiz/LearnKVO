//
//  SecondViewController.m
//  LearnKVO
//
//  Created by ios on 2019/1/9.
//  Copyright © 2019年 KN. All rights reserved.
//

#import "SecondViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // 4.C面建立通知中心，发送通知
    [[NSNotificationCenter defaultCenter] postNotificationName:@"NotificationCenter" object:@"change"];
}


@end
