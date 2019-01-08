//
//  ViewController.m
//  LearnKVO
//
//  Created by ios on 2019/1/9.
//  Copyright © 2019年 KN. All rights reserved.
//

/*
 KVO步骤：
 1.注册观察者
 2.实现回调方法
 3.触发回调方法
 4.移除观察者
 
 手动触发，需要同时实现以下方法：
 willChangeValueForKey
 didChangeValueForKey
 
 通知中心步骤：
 A面传值给C面(跨越多页面传值，一对多)
 1.A面建立通知中心，注册监听事件
 2.A面设置接收通知的事件
 3.3.A面移除通知中心
 4.C面建立通知中心，发送通知
 */
#import "ViewController.h"
#import "People.h"
#import "SecondViewController.h"

@interface ViewController ()

// model
@property(nonatomic,copy)People *man;

// 按钮
@property(nonatomic,strong)UIButton *btn;

// 跳转到下一个界面
@property(nonatomic,strong)UIButton *jumpBtn;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _man = [[People alloc]init];
    // 1.注册观察者
    [_man addObserver:self forKeyPath:@"name" options:(NSKeyValueObservingOptionNew) context:nil];
    
    _btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    [_btn setTitle:@"点击" forState:UIControlStateNormal];
    [_btn setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:_btn];
    
    // 通知中心
    // 1.A面建立通知中心，注册监听事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNotification:) name:@"NotificationCenter" object:nil];
    
    _jumpBtn = [[UIButton alloc]initWithFrame:CGRectMake(100, 250, 100, 100)];
    [_jumpBtn setTitle:@"跳转到下一个界面" forState:UIControlStateNormal];
    [_jumpBtn setBackgroundColor:[UIColor redColor]];
    [_jumpBtn addTarget:self action:@selector(jumpNextVC) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:_jumpBtn];
}

-(void)jumpNextVC {
    SecondViewController *vc = [[SecondViewController alloc]init];
    [self.navigationController pushViewController:vc animated:true];
}

// 2.A面设置接收通知的事件
-(void)receiveNotification:(NSNotification *)notifi {
    NSLog(@"%@ --- %@ --- %@",notifi.object,notifi.userInfo,notifi.name);
    if ([notifi.object isEqualToString:@"change"]) {
        [_btn setTitle:@"change" forState:(UIControlStateNormal)];
        [_btn setBackgroundColor:[UIColor greenColor]];
    }
}

// 2.实现回调方法
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqual: @"name"]) {
        NSLog(@"man's name is %@",change[NSKeyValueChangeNewKey]);
    }
    if ([keyPath isEqualToString:@"onClick"]) {
        NSLog(@"click btn");
    }
}

// 3.触发回调方法
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    static int num = 1;
//    [_man setName:[NSString stringWithFormat:@"%d",num]];
//    num++;
    // 手动触发 要同时实现这两个方法
    [_man willChangeValueForKey:@"name"];
    [_man didChangeValueForKey:@"name"];
}

// 4.移除观察者
// 3.A面移除通知中心
-(void)dealloc {
    [_man removeObserver:self forKeyPath:@"name"];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
