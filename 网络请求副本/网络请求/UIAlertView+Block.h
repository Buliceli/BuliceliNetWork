//
//  UIAlertView+Block.h
//  网络请求
//
//  Created by 李洞洞 on 11/4/17.
//  Copyright © 2017年 Minte. All rights reserved.
//  Category(分类)
/*
 1.分类（category）的作用
 1.1作用：可以在不修改原来类的基础上，为一个类扩展方法。
 1.2最主要的用法：给系统自带的类扩展方法。
 
 2.分类中能写点啥？
 2.1分类中只能添加“方法”，不能增加成员变量。
 2.2分类中可以访问原来类中的成员变量，但是只能访问@protect和@public形式的变量。如果想要访问本类中的私有变量，分类和子类一样，只能通过方法来访问。
 2.3如果一定要在分类中添加成员变量，可以通过getter，setter手段进行添加
 */

#import <UIKit/UIKit.h>
typedef void(^SuccessBlock)(NSInteger buttonIndex);
@interface UIAlertView (Block)<UIAlertViewDelegate>
@property(nonatomic,copy)NSString * ldd;
- (void)showWithBlock:(SuccessBlock)block;
@end
#pragma mark ----------------------------
typedef void(^btnBlock)();
@interface UIButton (Block)

- (void)handleWithBlock:(btnBlock)block;

@end
#pragma mark ----------------------------
//在分类方法里 为对象动态添加属性
@interface NSObject (CategoryWithProperty)
@property(nonatomic,strong)NSObject * property;

@end
#pragma mark ----匿名类别 又叫类拓展

@interface UILabel ()
@property(nonatomic,copy)NSString * ldd;
- (void)logLDD;
@end










