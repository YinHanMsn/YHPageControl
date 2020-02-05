# YHPageControl
ios 自定义 pageControl，segement

效果图
![image](https://github.com/YinHanMsn/YHPageControl/blob/master/view.png)


使用方式：


    YHPageControl *pageControl = [[YHPageControl alloc]initWithFrame:CGRectMake(10, 100, 355, 44)];
    pageControl.backgroundColor = [UIColor colorWithRed:239/255.0 green:122/255.0 blue:50/255.0 alpha:1];
    pageControl.layer.cornerRadius = 20;
    pageControl.layer.masksToBounds = YES;
    [pageControl setItems:@[@"Item 1", @"Item 2", @"Item 3", @"four", @"four", @"four"]];
    [self.view addSubview:pageControl];
    [pageControl setOnClickItem:^(NSString * _Nonnull item, NSInteger index) {
        NSLog(@"====item = %@ \n ==== index = %li", item, (long)index);
    }];
