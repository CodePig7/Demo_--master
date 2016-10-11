//
//  ViewController.m
//  Demo_掌盟资讯界面顶部拉伸
//
//  Created by AHJD-04 on 16/10/8.
//  Copyright © 2016年 XSLeagues. All rights reserved.
//

#import "ViewController.h"
#import "NavHeadTitleView.h"
#import "HeadLineView.h"
#import "HeadImageView.h"
#define kWIDTH [UIScreen mainScreen].bounds.size.width
#define kHEIGHT [UIScreen mainScreen].bounds.size.height
//颜色
#define kColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define IMAGECOUNT 4
@interface ViewController ()<NavHeadTitleViewDelegate,headLineDelegate,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
{
    NSMutableArray *dataArr0;
    NSMutableArray *dataArr1;
    NSMutableArray *dataArr2;
}
@property(nonatomic,strong)UIImageView *backgroundImgV;//背景图
@property(nonatomic,assign)float backImgHeight;
@property(nonatomic,assign)float backImgWidth;
@property(nonatomic,assign)float backImgOrgy;
@property(nonatomic,strong)NavHeadTitleView *NavView;//导航栏
@property(nonatomic,strong)HeadImageView *headImageView;//头视图
@property(nonatomic,strong)HeadLineView *headLineView;//
@property(nonatomic,assign)NSInteger currentIndex;
@property(nonatomic,assign)int rowHeight;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)UIPageControl *pageControl;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

//创建数据源
-(void)loadData{
    _currentIndex=0;
    dataArr0=[[NSMutableArray alloc]init];
    dataArr1=[[NSMutableArray alloc]init];
    dataArr2=[[NSMutableArray alloc]init];
    for (int i=0; i < 3; i++) {
        if (i == 0) {
            for (int i=0; i<10; i++) {
                NSString * string=[NSString stringWithFormat:@"第%d行新闻",i];
                [dataArr0 addObject:string];
            }
        }else if(i == 1){
            for (int i=1; i<8; i++) {
                NSString * string=[NSString stringWithFormat:@"娱乐%d",i];
                [dataArr1 addObject:string];
            }
        }else if (i == 2){
            for (int i=0; i<3; i++) {
                NSString * string=[NSString stringWithFormat:@"活动%d",i];
                [dataArr2 addObject:string];
            }
        }
    }
}

//顶部滚动视图
- (void)topScrollView{
    UIScrollView *topScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kWIDTH, kHEIGHT*0.3)];
    [self.view addSubview:topScrollView];
    topScrollView.backgroundColor = [UIColor clearColor];
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
    for (NSInteger i=0; i<IMAGECOUNT; i++) {
        UIImageView *imageView = [[UIImageView alloc]init];
        [imageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"IMG_275%d",i]]];
        imageView.frame = CGRectMake(i*topScrollView.frame.size.width, 0, topScrollView.frame.size.width, topScrollView.frame.size.height);
        [topScrollView addSubview:imageView];
    }
    
    UIPageControl *pageControl = [[UIPageControl alloc]init];
    self.pageControl = pageControl;
    pageControl.frame = CGRectMake(0,topScrollView.frame.size.height-60, topScrollView.frame.size.width, 40);
    //设置圆点没有选中时的颜色
    pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    //设置圆点选中时的颜色
    pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    //设置一共有几个圆点
    pageControl.numberOfPages = IMAGECOUNT;
    //禁止与用户交互(用户点击无反应)
    pageControl.userInteractionEnabled = NO;
    
    //将分页控件添加至self.view中
    [self.view addSubview:pageControl];
    
}

//滚动视图协议中的方法:一滚动就执行
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGPoint offset = scrollView.contentOffset;
    //取 滚动的横向距离 与屏幕宽度的整数倍
    double i = offset.x/scrollView.frame.size.width;
    
    //将这个整数倍作为选中的小圆点的下标
    self.pageControl.currentPage = round(i);
}

//创建TableView
- (void)createTableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kWIDTH, kHEIGHT-64) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.tableFooterView = [UIView new];
        [self.view addSubview:self.tableView];
    }
    [_tableView setTableHeaderView:[self headImageView]];
}

//滑动手势设置
- (void)handleSwipes:(UISwipeGestureRecognizer *)sender{
    UIView *targetView = sender.view;
    if (targetView.tag == 1) {
        return;
    }
    if (sender.direction == UISwipeGestureRecognizerDirectionLeft) {
        if (_currentIndex>1) {
            return;
        }
        _currentIndex++;
    }else if (sender.direction == UISwipeGestureRecognizerDirectionRight){
        if (_currentIndex <=0) {
            return;
        }
        _currentIndex--;
    }
    [_headLineView setCurrentIndex:_currentIndex];
}

- (void)refreshHeadLine:(NSInteger)currentIndex{
    _currentIndex = currentIndex;
    [_tableView reloadData];
}
-(void)createNav{
    self.NavView=[[NavHeadTitleView alloc]initWithFrame:CGRectMake(0, 0, kWIDTH, 64)];
    self.NavView.title=@"个人中心";
    self.NavView.color=[UIColor whiteColor];
    self.NavView.backTitleImage=@"Mail";
    self.NavView.rightTitleImage=@"Setting";
    self.NavView.delegate=self;
    [self.view addSubview:self.NavView];
}
//左按钮
-(void)NavHeadback{
    NSLog(@"点击了左按钮");
}
//右按钮回调
-(void)NavHeadToRight{
    NSLog(@"点击了右按钮");
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 48;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
