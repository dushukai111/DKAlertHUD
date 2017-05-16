# DKAlertHUD
加载视图和弹出视图
## 加载视图
#### 方形加载视图
     [DKAlertHUD showVerticalLoadView:@"加载中.." inView:self.view];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [DKAlertHUD dismissLoadViewInView:self.view];
    });
效果图<br>
![image](https://github.com/dushukai111/publicResources/blob/master/DKAlertHUD/alert1.png)
#### 长条加载视图
    [DKAlertHUD showHorizentalLoadView:@"加载中.." inView:self.view];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [DKAlertHUD dismissLoadViewInView:self.view];
    });
效果图<br>
![image](https://github.com/dushukai111/publicResources/blob/master/DKAlertHUD/alert2.png)
