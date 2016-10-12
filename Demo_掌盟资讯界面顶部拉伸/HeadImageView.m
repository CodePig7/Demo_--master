//
//  HeadImageView.m
//  Demo_掌盟资讯界面顶部拉伸
//
//  Created by AHJD-04 on 16/10/8.
//  Copyright © 2016年 XSLeagues. All rights reserved.
//

#import "HeadImageView.h"
#define kWIDTH [UIScreen mainScreen].bounds.size.width
#define kHEIGHT [UIScreen mainScreen].bounds.size.height
#define IMAGECOUNT 4
@interface HeadImageView ()<UIScrollViewDelegate>
@property(nonatomic,strong)UIPageControl *pageControl;
@end

@implementation HeadImageView

//顶部滚动视图
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
    UIScrollView *topScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kWIDTH, 40)];
    //设置水平滚动条不可见
    topScrollView.showsHorizontalScrollIndicator = NO;
    topScrollView.delegate = self;
    //设置滚动视图的滚动区域
    topScrollView.contentSize = CGSizeMake(topScrollView.frame.size.width*IMAGECOUNT, 0);
    //设置边缘不可弹跳
    topScrollView.bounces = NO;
    //设置是否分页
    topScrollView.pagingEnabled = YES;
    //向滚动视图内添加子视图
    for (NSInteger i=1; i<IMAGECOUNT; i++) {
        UIImageView *imageView = [[UIImageView alloc]init];
        [imageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"IMG_275%ld.JPG",i]]];
        imageView.frame = CGRectMake((i-1)*topScrollView.frame.size.width, 0, topScrollView.frame.size.width, topScrollView.frame.size.height);
        [topScrollView addSubview:imageView];
    }
    
    UIPageControl *pageControl = [[UIPageControl alloc]init];
    self.pageControl = pageControl;
    pageControl.frame = CGRectMake(0,topScrollView.frame.size.height-60, topScrollView.frame.size.width, 40);
    //设置圆点没有选中时的颜色
    pageControl.pageIndicatorTintColor = [UIColor redColor];
    //设置圆点选中时的颜色
    pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    //设置一共有几个圆点
    pageControl.numberOfPages = IMAGECOUNT;
    //禁止与用户交互(用户点击无反应)
    pageControl.userInteractionEnabled = NO;
    
    //将分页控件添加至self.view中
    [topScrollView addSubview:pageControl];
    }
    return self;

}

//滚动视图协议中的方法:一滚动就执行
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint offset = scrollView.contentOffset;
    //取 滚动的横向距离 与屏幕宽度的整数倍
    double i = offset.x/scrollView.frame.size.width;
    
    //将这个整数倍作为选中的小圆点的下标
    self.pageControl.currentPage = round(i);

}

@end
