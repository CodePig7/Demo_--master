//
//  HeadLineView.m
//  Demo_掌盟资讯界面顶部拉伸
//
//  Created by AHJD-04 on 16/10/8.
//  Copyright © 2016年 XSLeagues. All rights reserved.
//

#import "HeadLineView.h"
//当前手机屏幕宽度和高度
#define kWIDTH [UIScreen mainScreen].bounds.size.width
#define kHEIGHT [UIScreen mainScreen].bounds.size.height
//颜色设置
#define kColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
@interface HeadLineView(){
    UIButton *currentSelectedBtn;
    UILabel *label1;
    UILabel *label2;
    UILabel *label3;
    //按钮的数据
    NSMutableArray *buttonArray;
}

@end

@implementation HeadLineView
- (instancetype)init{
    if (self = [super init]) {
        buttonArray = [[NSMutableArray alloc]init];
    }
    return self;
}
//传入currentIndex
- (void)setCurrentIndex:(NSInteger)CurrentIndex{
    _CurrentIndex = CurrentIndex;//改变currentIndex
    [self refreshInterface:_CurrentIndex];
    if ([_delegate respondsToSelector:@selector(refreshHeadLine:)]) {
        [_delegate refreshHeadLine:_CurrentIndex];
    }
    
}

//刷新界面
- (void)refreshInterface:(NSInteger)index{
    if (buttonArray.count>0) {//防止没创建前为空
        for (UIButton *labViewBtn in buttonArray) {
            if (labViewBtn.tag == index) {
                if (labViewBtn.tag == 0) {
                    //深绿线
                    label1.backgroundColor = kColor(179, 211, 85, 1);
                }else if (labViewBtn.tag == 1){
                    label2.backgroundColor = kColor(179, 211, 85, 1);
                }else {
                    label3.backgroundColor = kColor(179, 211, 85, 1);
                }
                currentSelectedBtn = labViewBtn;
            }else{
                if (labViewBtn.tag == 0) {
                    //绿线
                    label1.backgroundColor = kColor(238, 238, 238, 1);
                }else if (labViewBtn.tag == 1){
                    label2.backgroundColor = kColor(238, 238, 238, 1);
                }else{
                    label3.backgroundColor = kColor(238, 238, 238, 1);
                }
            }
        }
    }
}
//按钮点击 传入代理
- (void)buttonClick:(UIButton *)button{
    NSInteger viewTag = [button tag];
    if ([button isEqual:currentSelectedBtn]) {
        return;
    }
    _CurrentIndex = viewTag;
    [self refreshInterface:_CurrentIndex];
    if ([_delegate respondsToSelector:@selector(refreshHeadLine:)]) {
        [_delegate refreshHeadLine:_CurrentIndex];
    }
}

//传入顶部的title
- (void)setTitleArr:(NSArray *)titleArr{
    _titleArray = titleArr;
    UIButton *btn = NULL;
    CGFloat width = kWIDTH/_titleArray.count;
    for (int i=0; i<_titleArray.count; i++) {
        btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i*width, 0, width, 48);
        btn.tag = i ;
        [btn setTitle:_titleArray[i] forState:UIControlStateNormal];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        btn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
        [btn setTitleColor:kColor(87, 173, 104, 1) forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor whiteColor]];
        [btn setUserInteractionEnabled:YES];
        [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [buttonArray addObject:btn];
        if (i == 0) {
            currentSelectedBtn = btn;
            //深绿线
            label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 45.5, kWIDTH/3, 2.5)];
            label1.backgroundColor = kColor(179, 211, 85, 1);
            [self addSubview:label1];
        }else if (i == 1){
            //绿线
            label2 = [[UILabel alloc]initWithFrame:CGRectMake(width, 45.5, kWIDTH/3, 2.5)];
            label2.backgroundColor = kColor(238, 238, 238, 1);
            [self addSubview:label2];
        }else{
            //绿线
            label3 = [[UILabel alloc]initWithFrame:CGRectMake(width *2, 45.5, kWIDTH/3, 2.5)];
            label3.backgroundColor = kColor(238, 238, 238, 1);
            [self addSubview:label3];
        }
    }
}

@end
