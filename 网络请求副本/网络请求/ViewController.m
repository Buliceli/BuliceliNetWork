//
//  ViewController.m
//  网络请求
//
//  Created by 李洞洞 on 10/4/17.
//  Copyright © 2017年 Minte. All rights reserved.
//

#import "ViewController.h"
#import "LDHomeAPI.h"
#import "LDFlowLayout.h"
#import "LDFirestCell.h"
#import "LDUnitModel.h"
#import "UIImageView+WebCache.h"
#import "UIAlertView+Block.h"
#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)UIView * ldView;
@property(nonatomic,strong)UICollectionView * collectionView;
@property(nonatomic,strong)NSMutableArray * dataArr;

@end
static NSString * cellID = @"FirestCell";
@implementation ViewController
#pragma mark -- 懒加载
- (NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
        for (int i = 0; i < 4; i++) {
            LDUnitModel * model = [[LDUnitModel alloc]init];
            model.logo = @"https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=3330325448,3545219178&fm=116&gp=0.jpg";
            [_dataArr addObject:model];
        }
    }
    
    return _dataArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UIView * view = ({
        UIView * view = [[UIView alloc]init];
        view.frame = CGRectMake(100, 100, 50, 50);
        view.backgroundColor = [UIColor lightGrayColor];
        view;
    });
    self.ldView = view;
    [self.view addSubview:view];
   // [self lddCollection];
    [self buttonRuntime];
}

- (void)alertRuntime
{
    UIAlertView * alert = [[UIAlertView alloc]initWithTitle:@"我的警告框" message:@"这是一个警告框" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.ldd = @"666";
    
    [alert showWithBlock:^(NSInteger buttonIndex) {
        NSLog(@"点击的下标是:%ld",buttonIndex);
        NSLog(@"%@",alert.ldd);
    }];
    
}
- (void)buttonRuntime
{
    UIButton * btn = ({
        UIButton * btn = [[UIButton alloc]init];
        btn.frame = CGRectMake(150, 150, 50, 50);
        btn.backgroundColor = [UIColor purpleColor];
        [btn handleWithBlock:^{
            self.view.backgroundColor = [UIColor lightGrayColor];
        }];
        btn;
    });
    [self.view addSubview:btn];
}
- (void)labelRuntime
{
    UILabel * label = [[UILabel alloc]init];
    label.ldd = @"666";
    NSLog(@"++%@++",label.ldd);
    [label logLDD];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{/*
    [LDHomeAPI getHomeScrollViewDataWithSucBlock:^(NSURL *URL, id data) {
        
    } andFailBlock:^(NSURL *URL, NSError *error) {
        
    }];
  */
//    [self alertRuntime];
//    
//    NSLog(@"%@",NSStringFromSelector(_cmd));
    [self labelRuntime];
}
#pragma mark --- UICollectionViewConverFlow布局
- (void)lddCollection
{
    LDFlowLayout *layout = [[LDFlowLayout alloc] init];
    CGRect rect = CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64);
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:rect collectionViewLayout:layout];
    [self.view addSubview:collectionView];
    
    [collectionView registerNib:[UINib nibWithNibName:@"LDFirestCell" bundle:nil] forCellWithReuseIdentifier:cellID];
    
    collectionView.dataSource = self;
    collectionView.delegate = self;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView = collectionView;
}
#pragma mark --- Core Animation CATransform3D

- (void)transformRotation
{
    self.ldView.layer.transform = CATransform3DMakeRotation(1.57, 1, 1, 0);
    //1.57 表示所转角度的弧度 = 90*π / 180 = 90 * 3.14 / 180
}
- (void)transformScale
{
    [UIView animateWithDuration:0.25 animations:^{
        self.ldView.layer.transform = CATransform3DMakeScale(2, 2, 1.0);//xyz轴上放大缩小的倍数
    }];
}
#pragma mark---UICollectionViewDelegate,UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LDFirestCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    LDUnitModel * model = self.dataArr[indexPath.row];
    NSURL * URL = [NSURL URLWithString:model.logo];
    
    [cell.ldFirestImage sd_setImageWithURL:URL];
    cell.ldTitleLabel.text = model.title;
    // LDLog(@"二级封面的名称--%@",model.title);
    return cell;
}

@end


























