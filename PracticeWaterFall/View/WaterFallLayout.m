//
//  WaterFallLayout.m
//  PracticeWaterFall
//
//  Created by wangshanshan on 2018/4/8.
//  Copyright © 2018年 ws. All rights reserved.
//

#import "WaterFallLayout.h"
const NSInteger WSDefaultColumnSpacint = 10;
const NSInteger WSDefaultRowSpacing = 10;
const NSInteger WSDefaultColumnCount = 3;
const UIEdgeInsets WSDefaultSectionInset = {0,0,0,0};

@interface WaterFallLayout()

//存放所有cell的布局属性
@property (strong, nonatomic) NSMutableArray *attrsArray;
//存放所有列的当前高度
@property (strong, nonatomic) NSMutableArray *columnHeightsArray;

@end

@implementation WaterFallLayout
#pragma mark - 懒加载
-(NSMutableArray *)attrsArray{
    if (!_attrsArray) {
        _attrsArray = [NSMutableArray array];
    }
    return _attrsArray;
}
-(NSMutableArray *)columnHeightsArray{
    if (!_columnHeightsArray) {
        _columnHeightsArray = [NSMutableArray array];
    }
    return _columnHeightsArray;
}
#pragma mark - 初始化
//使用代码初始化的时候，会调用该方法，在该方法中设置行间距、列间距的默认值
-(instancetype)init{
    if (self = [super init]) {
        [self defaultSetting];
    }
    return self;
}
//使用xib或storyboard初始化的时候，会调用该方法，在该方法中设置行间距、列间距的默认值
-(void)awakeFromNib{
    [super awakeFromNib];
    [self defaultSetting];
}
-(void)defaultSetting{
    _columnCount = WSDefaultColumnCount;
    _columnSpacing = WSDefaultColumnSpacint;
    _rowSpacing = WSDefaultRowSpacing;
    self.sectionInset = WSDefaultSectionInset;
}
#pragma mark - 布局相关方法
-(void)prepareLayout{
    [super prepareLayout];
    
    //清除所有的布局高度
    [self.columnHeightsArray removeAllObjects];
    for (NSInteger i = 0; i < self.columnCount; i++) {
        [self.columnHeightsArray addObject:@(self.sectionInset.top)];
    }
    //清除所有的属性布局
    [self.attrsArray removeAllObjects];
    //根据collectionView获取总共有多少个item
    NSInteger itemCount = [self.collectionView numberOfItemsInSection:0];
    //为每一个item创建一个attributes并存入数组
    for (NSInteger i = 0; i < itemCount; i++) {
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        [self.attrsArray addObject:attributes];
    }
}
//设置每一个item的attributes
-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    //根据indexPath获取item的attributes
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    //获取collectionView的宽度
    NSInteger collectionViewWidth = self.collectionView.frame.size.width;
    //获取内容宽度
    NSInteger contentWidth = collectionViewWidth - self.sectionInset.left - self.sectionInset.right;
    //获取item宽度
    NSInteger itemWidth = (contentWidth - (self.columnCount - 1)*self.columnSpacing)/self.columnCount;
    
    //计算itemHeight
    NSInteger itemHeight = 0;
    //由外部计算item的高度
    if ([self.delegate respondsToSelector:@selector(waterfallLayout:itemHeightForWidth:atIndexPath:)]) {
        itemHeight = [self.delegate waterfallLayout:self itemHeightForWidth:itemWidth atIndexPath:indexPath];
    }
    
    //找出高度最短的一列
    __block NSUInteger minIndex = 0;
    [self .columnHeightsArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([self.columnHeightsArray[minIndex] floatValue] > [obj floatValue]) {
            minIndex = idx;
        }
    }];
    
    //根据最短列的列数计算item的x值
    CGFloat itemX = self.sectionInset.left + (self.columnSpacing + itemWidth) * minIndex;
    //计算item的y值
    CGFloat itemY = [self.columnHeightsArray[minIndex] integerValue] + self.rowSpacing;
    //设置attributes的frame
    attributes.frame = CGRectMake(itemX, itemY, itemWidth, itemHeight);
    //更新字典中列数的最大值
    self.columnHeightsArray[minIndex] = @(CGRectGetMaxY(attributes.frame));
    return attributes;
}

//重写方法计算collectionView的contentSize
-(CGSize)collectionViewContentSize{
    //找出高度最高的一列
    __block NSUInteger maxIndex = 0;
    [self.columnHeightsArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([self.columnHeightsArray[maxIndex] floatValue] < [obj floatValue]) {
            maxIndex = idx;
        }
    }];
    
    CGSize contentSize = CGSizeMake(0, [self.columnHeightsArray[maxIndex] floatValue] + self.sectionInset.bottom);
    
    return contentSize;
}
//返回rect范围内item的attributes
-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect{
    return self.attrsArray;
}

@end
