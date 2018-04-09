//
//  WaterFallLayout.h
//  PracticeWaterFall
//
//  Created by wangshanshan on 2018/4/8.
//  Copyright © 2018年 ws. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WaterFallLayout;
@protocol WaterFallLayoutDelegate<NSObject>

@required
//计算item高度的代理方法，将item的高度与indexPath传递给外界
- (CGFloat)waterfallLayout:(WaterFallLayout *)waterfallLayout itemHeightForWidth:(CGFloat)itemWidth atIndexPath:(NSIndexPath *)indexPath;

@end

//自定义layout
@interface WaterFallLayout : UICollectionViewFlowLayout
//列数
@property (assign, nonatomic) NSInteger columnCount;
//item之间间距
@property (assign, nonatomic) NSInteger columnSpacing;
//行间距
@property (assign, nonatomic) NSInteger rowSpacing;
//section与CollectionView的间距，默认是UIEdgeInsets(0,0,0,0)
@property (assign, nonatomic) UIEdgeInsets sectionInset;

@property (weak, nonatomic) id<WaterFallLayoutDelegate> delegate;


@end
