//
//  DKAlertHUD.h
//  VideoPlayer
//
//  Created by kaige on 2017/3/15.
//  Copyright © 2017年 dushukai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface DKAlertHUD : NSObject
//可显示多行的弹出视图
+ (void)showAlertMessage:(NSString*)msg inView:(UIView*)contentView delay:(CGFloat)seconds;
//纵向加载视图(菊花在上、文字在下)
+ (void)showVerticalLoadView:(NSString*)msg inView:(UIView*)contentView;
//横向加载视图(菊花在左、文字在右)
+ (void)showHorizentalLoadView:(NSString*)msg inView:(UIView*)contentView;
//带图标的加载视图(只有图标，没有文字)
+ (void)showIconLoadViewWithImage:(UIImage*)icon InView:(UIView*)contentView;
+ (void)showAnimationLoadViewWithImages:(NSArray<UIImage*>*)images InView:(UIView*)contentView;
//移除加载视图
+ (void)dismissLoadViewInView:(UIView*)contentView;
@end
