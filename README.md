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
#### icon加载视图
    [DKAlertHUD showIconLoadViewWithImage:[UIImage imageNamed:@"dog_icon"] InView:self.view];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [DKAlertHUD dismissLoadViewInView:self.view];
    });
效果图<br>
![image](https://github.com/dushukai111/publicResources/blob/master/DKAlertHUD/alert3.png)
#### gif加载视图
    [DKAlertHUD showAnimationLoadViewWithImages:array InView:self.view];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [DKAlertHUD dismissLoadViewInView:self.view];
    });
效果图<br>
![image](https://github.com/dushukai111/publicResources/blob/master/DKAlertHUD/alert4.png)

## 弹出视图
弹出视图可显示多行，高度自适应<br>
    [DKAlertHUD showAlertMessage:@"弹出框测试" inView:self.view delay:3];<br>
效果图:<br>
![image](https://github.com/dushukai111/publicResources/blob/master/DKAlertHUD/alert5.png)
![image](https://github.com/dushukai111/publicResources/blob/master/DKAlertHUD/alert6.png)
