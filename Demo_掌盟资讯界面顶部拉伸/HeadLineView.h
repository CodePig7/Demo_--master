//
//  HeadLineView.h
//  Demo_掌盟资讯界面顶部拉伸
//
//  Created by AHJD-04 on 16/10/8.
//  Copyright © 2016年 XSLeagues. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol headLineDelegate <NSObject>

@optional
- (void)refreshHeadLine:(NSInteger)currentIndex;

@end

@interface HeadLineView : UIView
@property(nonatomic,assign)NSInteger CurrentIndex;
@property(nonatomic,strong) NSArray *titleArray;
@property(nonatomic,weak)id<headLineDelegate> delegate;
@end
