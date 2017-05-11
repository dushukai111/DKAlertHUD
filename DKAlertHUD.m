//
//  DKAlertHUD.m
//  VideoPlayer
//
//  Created by kaige on 2017/3/15.
//  Copyright © 2017年 dushukai. All rights reserved.
//

#import "DKAlertHUD.h"
#define screenWidth [UIScreen mainScreen].bounds.size.width
#define screenHeight [UIScreen mainScreen].bounds.size.height
#define DKVerticalLoadViewTag 10001 //纵向加载视图
#define DKHorizentalLoadViewTag 10002 //横向加载视图
#define DKIconLoadViewTag 10003 //带icon的加载视图
#define DKAnimationLoadViewTag 10004 //gif加载视图
@implementation DKAlertHUD
+ (void)showAlertMessage:(NSString *)msg inView:(UIView *)contentView delay:(CGFloat)seconds{
    //背景视图，用于遮挡下层视图
    UIView *backgroundView=[[UIView alloc] init];
    [contentView addSubview:backgroundView];
    backgroundView.translatesAutoresizingMaskIntoConstraints=NO;
    [contentView addConstraint:[NSLayoutConstraint constraintWithItem:backgroundView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:contentView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0]];
    [contentView addConstraint:[NSLayoutConstraint constraintWithItem:backgroundView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:contentView attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0]];
    [contentView addConstraint:[NSLayoutConstraint constraintWithItem:backgroundView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
    [contentView addConstraint:[NSLayoutConstraint constraintWithItem:backgroundView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
    
    //弹出框
    UIView *alertContentView=[[UIView alloc] init];
    alertContentView.backgroundColor=[UIColor colorWithWhite:0 alpha:0.7];
    alertContentView.layer.cornerRadius=5.0;
    [backgroundView addSubview:alertContentView];
    alertContentView.translatesAutoresizingMaskIntoConstraints=NO;
    
    //显示文字
      //获取contentView距离keyWindow的偏移量
    CGFloat offsetY=[contentView convertPoint:CGPointMake(0, 0) toView:[UIApplication sharedApplication].keyWindow].y;
    UILabel *textLabel=[[UILabel alloc] init];
    textLabel.textColor=[UIColor whiteColor];
    textLabel.font=[UIFont systemFontOfSize:15];
    textLabel.text=msg;
    textLabel.numberOfLines=0;
    [backgroundView addSubview:textLabel];
    textLabel.translatesAutoresizingMaskIntoConstraints=NO;
    [backgroundView addConstraint:[NSLayoutConstraint constraintWithItem:textLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:backgroundView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
    [backgroundView addConstraint:[NSLayoutConstraint constraintWithItem:textLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:backgroundView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:-offsetY]];
    [backgroundView addConstraint:[NSLayoutConstraint constraintWithItem:textLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationLessThanOrEqual toItem:backgroundView attribute:NSLayoutAttributeWidth multiplier:0.8 constant:0]];//设置label最大宽度为contentView的0.8倍
    //设置alertContentView的约束
    [backgroundView addConstraint:[NSLayoutConstraint constraintWithItem:alertContentView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:textLabel attribute:NSLayoutAttributeLeading multiplier:1.0 constant:-10]];
    [backgroundView addConstraint:[NSLayoutConstraint constraintWithItem:alertContentView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:textLabel attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:10]];
    [backgroundView addConstraint:[NSLayoutConstraint constraintWithItem:alertContentView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:textLabel attribute:NSLayoutAttributeTop multiplier:1.0 constant:-10]];
    [backgroundView addConstraint:[NSLayoutConstraint constraintWithItem:alertContentView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:textLabel attribute:NSLayoutAttributeBottom multiplier:1.0 constant:10]];
    
    backgroundView.alpha=0;
    [UIView animateWithDuration:0.3 animations:^{
        backgroundView.alpha=1.0;
    } completion:^(BOOL finished) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(seconds * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.3 animations:^{
                backgroundView.alpha=0;
            } completion:^(BOOL finished) {
                [backgroundView removeFromSuperview];
            }];
        });
    }];
    
    
}
+ (void)showVerticalLoadView:(NSString *)msg inView:(UIView *)contentView{
    UIView *loadView=[contentView viewWithTag:DKVerticalLoadViewTag];
    if (loadView) {//如果已经存在加载视图，不在创建，直接修改msg
        UILabel *msgLabel=[loadView viewWithTag:2];
        msgLabel.text=msg;
        return;
    }
    //加载框，下面采用延迟0.5秒显示加载框，原因是当加载视图在viewDidLoad中添加的时候，self.view的的位置不能最终确定
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(500 * NSEC_PER_MSEC)), dispatch_get_main_queue(), ^{
        
        //背景视图，用于遮挡下层视图
        UIView *backgroundView=[[UIView alloc] init];
        backgroundView.tag=DKVerticalLoadViewTag;
        [contentView addSubview:backgroundView];
        backgroundView.translatesAutoresizingMaskIntoConstraints=NO;
        [contentView addConstraint:[NSLayoutConstraint constraintWithItem:backgroundView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:contentView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0]];
        [contentView addConstraint:[NSLayoutConstraint constraintWithItem:backgroundView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:contentView attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0]];
        [contentView addConstraint:[NSLayoutConstraint constraintWithItem:backgroundView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
        [contentView addConstraint:[NSLayoutConstraint constraintWithItem:backgroundView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
        CGFloat offsetY=screenHeight/2-[contentView convertPoint:CGPointMake(contentView.bounds.size.width/2, contentView.bounds.size.height/2) toView:[UIApplication sharedApplication].keyWindow].y;
        CGFloat width=screenWidth<screenHeight?screenWidth:screenHeight;//获取屏幕最小边长，用来确定加载框大小
        UIView *alertContentView=[[UIView alloc] init];
        alertContentView.backgroundColor=[UIColor colorWithWhite:0 alpha:0.7];
        alertContentView.layer.cornerRadius=10.0;
        [backgroundView addSubview:alertContentView];
        alertContentView.translatesAutoresizingMaskIntoConstraints=NO;
        [backgroundView addConstraint:[NSLayoutConstraint constraintWithItem:alertContentView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:backgroundView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
        [backgroundView addConstraint:[NSLayoutConstraint constraintWithItem:alertContentView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:backgroundView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:offsetY]];
        [backgroundView addConstraint:[NSLayoutConstraint constraintWithItem:alertContentView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width/3]];
        [backgroundView addConstraint:[NSLayoutConstraint constraintWithItem:alertContentView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width/3]];
        //大菊花
        UIActivityIndicatorView *aiView=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        aiView.tag=1;
        [alertContentView addSubview:aiView];
        [aiView startAnimating];
        aiView.translatesAutoresizingMaskIntoConstraints=NO;
        [alertContentView addConstraint:[NSLayoutConstraint constraintWithItem:aiView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:alertContentView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
        [alertContentView addConstraint:[NSLayoutConstraint constraintWithItem:aiView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:alertContentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:-15]];
        //显示文字
        UILabel *textLabel=[[UILabel alloc] init];
        textLabel.font=[UIFont systemFontOfSize:15.0];
        textLabel.textColor=[UIColor whiteColor];
        textLabel.textAlignment=NSTextAlignmentCenter;
        textLabel.numberOfLines=2;//最多两行
        textLabel.tag=2;//设置tag便于修改显示文字
        textLabel.text=msg;
        [alertContentView addSubview:textLabel];
        textLabel.translatesAutoresizingMaskIntoConstraints=NO;
        [alertContentView addConstraint:[NSLayoutConstraint constraintWithItem:textLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:alertContentView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:10]];
        [alertContentView addConstraint:[NSLayoutConstraint constraintWithItem:textLabel attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:alertContentView attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-10]];
        [alertContentView addConstraint:[NSLayoutConstraint constraintWithItem:textLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:alertContentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-15]];
    });
    
}
+ (void)showHorizentalLoadView:(NSString *)msg inView:(UIView *)contentView{
    UIView *loadView=[contentView viewWithTag:DKHorizentalLoadViewTag];
    if (loadView) {//如果已经存在加载视图，不在创建，直接修改msg
        UILabel *msgLabel=[loadView viewWithTag:2];
        msgLabel.text=msg;
        return;
    }
    //加载框，下面采用延迟0.5秒显示加载框，原因是当加载视图在viewDidLoad中添加的时候，self.view的的位置不能最终确定
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(500 * NSEC_PER_MSEC)), dispatch_get_main_queue(), ^{
        
        //背景视图，用于遮挡下层视图
        UIView *backgroundView=[[UIView alloc] init];
        backgroundView.tag=DKHorizentalLoadViewTag;
        [contentView addSubview:backgroundView];
        backgroundView.translatesAutoresizingMaskIntoConstraints=NO;
        [contentView addConstraint:[NSLayoutConstraint constraintWithItem:backgroundView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:contentView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0]];
        [contentView addConstraint:[NSLayoutConstraint constraintWithItem:backgroundView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:contentView attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0]];
        [contentView addConstraint:[NSLayoutConstraint constraintWithItem:backgroundView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
        [contentView addConstraint:[NSLayoutConstraint constraintWithItem:backgroundView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
        CGFloat offsetY=screenHeight/2-[contentView convertPoint:CGPointMake(contentView.bounds.size.width/2, contentView.bounds.size.height/2) toView:[UIApplication sharedApplication].keyWindow].y;
        CGFloat width=[UIScreen mainScreen].bounds.size.width<[UIScreen mainScreen].bounds.size.height?[UIScreen mainScreen].bounds.size.width:[UIScreen mainScreen].bounds.size.height;//获取屏幕最小边长，用来确定加载框大小
        UIView *alertContentView=[[UIView alloc] init];
        alertContentView.backgroundColor=[UIColor colorWithWhite:0 alpha:0.7];
        alertContentView.layer.cornerRadius=5.0;
        [backgroundView addSubview:alertContentView];
        alertContentView.translatesAutoresizingMaskIntoConstraints=NO;
        [backgroundView addConstraint:[NSLayoutConstraint constraintWithItem:alertContentView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:backgroundView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
        [backgroundView addConstraint:[NSLayoutConstraint constraintWithItem:alertContentView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:backgroundView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:offsetY]];
        [backgroundView addConstraint:[NSLayoutConstraint constraintWithItem:alertContentView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationLessThanOrEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width*0.8]];
        [backgroundView addConstraint:[NSLayoutConstraint constraintWithItem:alertContentView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:40]];
        //小菊花
        UIActivityIndicatorView *aiView=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        aiView.tag=1;
        [alertContentView addSubview:aiView];
        [aiView startAnimating];
        aiView.translatesAutoresizingMaskIntoConstraints=NO;
        [alertContentView addConstraint:[NSLayoutConstraint constraintWithItem:aiView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:alertContentView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:10]];
        [alertContentView addConstraint:[NSLayoutConstraint constraintWithItem:aiView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:alertContentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
        //显示文字
        UILabel *textLabel=[[UILabel alloc] init];
        textLabel.font=[UIFont systemFontOfSize:15.0];
        textLabel.textColor=[UIColor whiteColor];
        textLabel.textAlignment=NSTextAlignmentCenter;
        textLabel.tag=2;//设置tag便于修改显示文字
        textLabel.text=msg;
        [alertContentView addSubview:textLabel];
        textLabel.translatesAutoresizingMaskIntoConstraints=NO;
        [alertContentView addConstraint:[NSLayoutConstraint constraintWithItem:textLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:aiView attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:10]];
        [alertContentView addConstraint:[NSLayoutConstraint constraintWithItem:textLabel attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:alertContentView attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:-10]];
        [alertContentView addConstraint:[NSLayoutConstraint constraintWithItem:textLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:alertContentView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
    });
}
+ (void)showIconLoadViewWithImage:(UIImage*)icon InView:(UIView*)contentView{
    UIView *loadView=[contentView viewWithTag:DKIconLoadViewTag];
    if (loadView) {//如果已经存在加载视图，不在创建
        return;
    }
    //加载框，下面采用延迟0.5秒显示加载框，原因是当加载视图在viewDidLoad中添加的时候，self.view的的位置不能最终确定
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(500 * NSEC_PER_MSEC)), dispatch_get_main_queue(), ^{
        
        //背景视图，用于遮挡下层视图
        UIView *backgroundView=[[UIView alloc] init];
        backgroundView.tag=DKIconLoadViewTag;
        [contentView addSubview:backgroundView];
        backgroundView.translatesAutoresizingMaskIntoConstraints=NO;
        [contentView addConstraint:[NSLayoutConstraint constraintWithItem:backgroundView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:contentView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0]];
        [contentView addConstraint:[NSLayoutConstraint constraintWithItem:backgroundView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:contentView attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0]];
        [contentView addConstraint:[NSLayoutConstraint constraintWithItem:backgroundView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
        [contentView addConstraint:[NSLayoutConstraint constraintWithItem:backgroundView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
        CGFloat offsetY=screenHeight/2-[contentView convertPoint:CGPointMake(contentView.bounds.size.width/2, contentView.bounds.size.height/2) toView:[UIApplication sharedApplication].keyWindow].y;
        //圆圈下白色背景
        UIView *iconBackView=[[UIView alloc] init];
        iconBackView.backgroundColor=[UIColor whiteColor];
        iconBackView.layer.cornerRadius=26.0;
        [backgroundView addSubview:iconBackView];
        iconBackView.translatesAutoresizingMaskIntoConstraints=NO;
        [backgroundView addConstraint:[NSLayoutConstraint constraintWithItem:iconBackView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:backgroundView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
        [backgroundView addConstraint:[NSLayoutConstraint constraintWithItem:iconBackView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:backgroundView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:offsetY]];
        [backgroundView addConstraint:[NSLayoutConstraint constraintWithItem:iconBackView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:52]];
        [backgroundView addConstraint:[NSLayoutConstraint constraintWithItem:iconBackView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:52]];
        //icon
        UIImageView *iconView=[[UIImageView alloc] init];
        iconView.image=icon;
        iconView.layer.cornerRadius=22;
        iconView.layer.masksToBounds=YES;
        [backgroundView addSubview:iconView];
        iconView.translatesAutoresizingMaskIntoConstraints=NO;
        [backgroundView addConstraint:[NSLayoutConstraint constraintWithItem:iconView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:iconBackView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
        [backgroundView addConstraint:[NSLayoutConstraint constraintWithItem:iconView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:iconBackView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
        [backgroundView addConstraint:[NSLayoutConstraint constraintWithItem:iconView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:44]];
        [backgroundView addConstraint:[NSLayoutConstraint constraintWithItem:iconView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:44]];
        //旋转的圆圈
        UIImageView *rotateView=[[UIImageView alloc] init];
        rotateView.image=[UIImage imageWithContentsOfFile:[[[NSBundle mainBundle] pathForResource:@"DKAlertView" ofType:@"bundle"] stringByAppendingPathComponent:@"dk_load_view_icon.png"]];
        [backgroundView addSubview:rotateView];
        rotateView.translatesAutoresizingMaskIntoConstraints=NO;
        [backgroundView addConstraint:[NSLayoutConstraint constraintWithItem:rotateView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:iconBackView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
        [backgroundView addConstraint:[NSLayoutConstraint constraintWithItem:rotateView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:iconBackView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0]];
        [backgroundView addConstraint:[NSLayoutConstraint constraintWithItem:rotateView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:50]];
        [backgroundView addConstraint:[NSLayoutConstraint constraintWithItem:rotateView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:50]];
        //增加旋转动画
        CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        animation.toValue=[NSNumber numberWithFloat:M_PI*2];
        animation.duration=1;
        animation.repeatCount=HUGE_VALF;
        [rotateView.layer addAnimation:animation forKey:@"transform.rotation.z"];
        
        
        
    });
}
+ (void)showAnimationLoadViewWithImages:(NSArray<UIImage*>*)images InView:(UIView *)contentView{
    UIView *loadView=[contentView viewWithTag:DKAnimationLoadViewTag];
    if (loadView) {//如果已经存在加载视图，不在创建
        return;
    }
    //加载框，下面采用延迟0.5秒显示加载框，原因是当加载视图在viewDidLoad中添加的时候，self.view的的位置不能最终确定
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(500 * NSEC_PER_MSEC)), dispatch_get_main_queue(), ^{
        
        //背景视图，用于遮挡下层视图
        UIView *backgroundView=[[UIView alloc] init];
        backgroundView.tag=DKAnimationLoadViewTag;
        [contentView addSubview:backgroundView];
        backgroundView.translatesAutoresizingMaskIntoConstraints=NO;
        [contentView addConstraint:[NSLayoutConstraint constraintWithItem:backgroundView attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:contentView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:0]];
        [contentView addConstraint:[NSLayoutConstraint constraintWithItem:backgroundView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:contentView attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:0]];
        [contentView addConstraint:[NSLayoutConstraint constraintWithItem:backgroundView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:0]];
        [contentView addConstraint:[NSLayoutConstraint constraintWithItem:backgroundView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:contentView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0]];
        CGFloat offsetY=screenHeight/2-[contentView convertPoint:CGPointMake(contentView.bounds.size.width/2, contentView.bounds.size.height/2) toView:[UIApplication sharedApplication].keyWindow].y;
        //动画视图
        CGSize imageSize=CGSizeMake(50, 50);//默认大小50*50
        if (images.count>0&&[[images objectAtIndex:0] isKindOfClass:[UIImage class]]) {
            imageSize=[[images objectAtIndex:0] size];
        }
        UIImageView *animationView=[[UIImageView alloc] init];
        animationView.animationImages=images;
        animationView.animationDuration=0.5;
        [backgroundView addSubview:animationView];
        [animationView startAnimating];
        animationView.translatesAutoresizingMaskIntoConstraints=NO;
        [backgroundView addConstraint:[NSLayoutConstraint constraintWithItem:animationView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:backgroundView attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0]];
        [backgroundView addConstraint:[NSLayoutConstraint constraintWithItem:animationView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:backgroundView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:offsetY]];
        [backgroundView addConstraint:[NSLayoutConstraint constraintWithItem:animationView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:50]];
        [backgroundView addConstraint:[NSLayoutConstraint constraintWithItem:animationView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:imageSize.height/imageSize.width*50]];
        
    });
}
+ (void)dismissLoadViewInView:(UIView *)contentView{
    for (UIView *view in contentView.subviews) {
        if (view.tag>10000) {
            [view removeFromSuperview];
        }
    }
}
@end
