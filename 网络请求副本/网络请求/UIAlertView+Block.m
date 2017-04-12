//
//  UIAlertView+Block.m
//  网络请求
//
//  Created by 李洞洞 on 11/4/17.
//  Copyright © 2017年 Minte. All rights reserved.
//  1声明2赋值3调用

#import "UIAlertView+Block.h"
#import <objc/runtime.h>
static const char alertKey,btnKey;

@implementation UIAlertView (Block)


- (void)setLdd:(NSString *)ldd
{
    objc_setAssociatedObject(self, @selector(ldd), ldd, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSString*)ldd
{
    return objc_getAssociatedObject(self, @selector(ldd));
}


- (void)showWithBlock:(SuccessBlock)block
{
    if (block) {
        objc_setAssociatedObject(self, &alertKey, block, OBJC_ASSOCIATION_COPY);//关联block这个属性
        self.delegate = self;
    }
    [self show];
    //在这个方法里 通过blcok拿到了另外一个方法里的变量
    /*
     应用场景:
     这两个方法可以让一个对象和另一个对象关联，就是说一个对象可以保持对另一个对象的引用，并获取那个对象。有了这些，就能实现属性功能了
     */
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    SuccessBlock block = objc_getAssociatedObject(self, &alertKey);//拿到关联的属性
    block(buttonIndex);
}

@end

#pragma mark ------------------------------------
@implementation UIButton (Block)
//1 声明 2 赋值 3 调用
//外界ViewController中对block赋值后调用第40行代码
- (void)handleWithBlock:(btnBlock)block
{
    if (block) {
        objc_setAssociatedObject(self, &btnKey, block, OBJC_ASSOCIATION_COPY);
        //如果外界给block赋值了 那么关联当前类的block对象
    }
    [self addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    
}
- (void)btnAction
{//在button的点击事件里 拿到之前关联的block对象 让block调用
// 作用就是相当于在不同的方法之间传递了block这个对象 让他在合适的地方进行调用 应用前景应当还是挺广泛的
    btnBlock block = objc_getAssociatedObject(self, &btnKey);
    block();
}
@end

#pragma mark ------------动态添加属性------------------------

@implementation NSObject (CategoryWithProperty)

- (void)setProperty:(NSObject *)property
{
    objc_setAssociatedObject(self, @selector(property), property, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (NSObject*)property
{
    return objc_getAssociatedObject(self, @selector(property));
}
@end
#pragma mark --- 匿名类别 又叫类拓展

@implementation UILabel

- (void)logLDD
{
    NSLog(@"ldd");
}

@end




//@interface UILabel ()
//@property(nonatomic,copy)NSString * ldd;
//- (void)logLDD;
//@end
























