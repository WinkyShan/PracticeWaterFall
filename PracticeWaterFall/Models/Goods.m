//
//  Goods.m
//  PracticeWaterFall
//
//  Created by wangshanshan on 2018/4/9.
//  Copyright © 2018年 ws. All rights reserved.
//

#import "Goods.h"

@implementation Goods

+ (instancetype)goodsWithDict:(NSDictionary *)dict{
    id goods = [[self alloc]init];
    [goods setValuesForKeysWithDictionary:dict];
    return goods;
}
/**
 *  根据索引返回商品数组
 */
+ (NSArray *)goodsWithIndex:(NSInteger)index {
    
    NSString *fileName = [NSString stringWithFormat:@"%ld.plist", index + 1];
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
    NSArray *goodsArray = [NSArray arrayWithContentsOfFile:path];
    NSMutableArray *tmpArray = [NSMutableArray arrayWithCapacity:goodsArray.count];
    
    [goodsArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [tmpArray addObject:[self goodsWithDict:obj]];
    }];
    
    return tmpArray.copy;
}
@end
