//
//  YHPageControl.h
//  
//
//  Created by yinhan on 2020/2/3.
//  Copyright © 2020 yinhan. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface YHPageControl : UIView
@property (nonatomic, strong) NSArray * items;
@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, strong) void(^onClickItem)(NSString * item, NSInteger index);
@end

NS_ASSUME_NONNULL_END
