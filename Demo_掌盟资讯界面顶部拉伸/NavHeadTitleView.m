//
//  NavHeadTitleView.m
//  Demo_掌盟资讯界面顶部拉伸
//
//  Created by 夏帅 on 16/10/9.
//  Copyright © 2016年 XSLeagues. All rights reserved.
//

#import "NavHeadTitleView.h"
@interface NavHeadTitleView()
@property(nonatomic,strong)UILabel *label;
@property(nonatomic,strong)UIButton * backBtn;
@property(nonatomic,strong)UIButton * rightBtn;
@end

@implementation NavHeadTitleView
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.headBgView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);//修改处
        self.headBgView.backgroundColor = [UIColor whiteColor];//拉上去的时候显示的颜色
        self.headBgView.image = [UIImage imageNamed:@"nav－-bar"];
        //是顶部导航栏透明
        self.headBgView.alpha = 0;
        [self addSubview:self.headBgView];
        
        self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.backBtn.backgroundColor = [UIColor clearColor];
        self.backBtn.frame = CGRectMake(5, 20, 44, 44);
        [self.backBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.backBtn];
        
        self.label = [[UILabel alloc]initWithFrame:CGRectMake(44, 20, frame.size.width-44-44, 44)];
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.font = [UIFont systemFontOfSize:18];
        [self addSubview:self.label];
        
        self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.rightBtn.backgroundColor = [UIColor clearColor];
        self.rightBtn.frame = CGRectMake(self.frame.size.width-46, 30, 30, 30);
        [self.rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

- (void)setBackTitleImage:(NSString *)backTitleImage{
    _backTitleImage = backTitleImage;
    [self.backBtn setImage:[UIImage imageNamed:_backTitleImage] forState:UIControlStateNormal];
}

- (void)setRightImageView:(NSString *)rightImageView{
    _rightImageView = rightImageView;
    [self.rightBtn setImage:[UIImage imageNamed:_rightImageView] forState:UIControlStateNormal];
}

- (void)setRightTitleImage:(NSString *)rightTitleImage{
    _rightTitleImage = rightTitleImage;
    [self.rightBtn setImage:[UIImage imageNamed:_rightTitleImage] forState:UIControlStateNormal];
}

- (void)setTitle:(NSString *)title{
    _title = title;
    self.label.text = title;
}

- (void)setColor:(UIColor *)color{
    _color = color;
    self.label.textColor = color;
}

//返回按钮
- (void)backClick{
    if ([_delegate respondsToSelector:@selector(NavHeadback)]) {
        [_delegate NavHeadback];
    }
}

//右边按钮
-(void)rightBtnClick{
    if ([_delegate respondsToSelector:@selector(NavHeadToRight)]) {
        [_delegate NavHeadToRight];
    }
}

@end
