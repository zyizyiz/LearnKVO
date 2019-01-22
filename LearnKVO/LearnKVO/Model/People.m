//
//  People.m
//  LearnKVO
//
//  Created by ios on 2019/1/9.
//  Copyright © 2019年 KN. All rights reserved.
//

#import "People.h"

@interface People()

// 年龄
@property(nonatomic,copy)NSString *age;
@end

@implementation People

- (void)setRealName:(NSString *)name {
    _name = name;
    NSLog(@"xxx");
}


@end
