//
//  Goods.h
//  PracticeWaterFall
//
//  Created by wangshanshan on 2018/4/9.
//  Copyright © 2018年 ws. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Goods : NSObject
@property (nonatomic, assign) NSInteger h; // 商品图片高
@property (nonatomic, assign) NSInteger w; // 商品图片宽
@property (nonatomic, copy) NSString *img; // 商品图片地址
@property (nonatomic, copy) NSString *price; // 商品价格

+ (instancetype)goodsWithDict:(NSDictionary *)dict; // 字典转模型
+ (NSArray *)goodsWithIndex:(NSInteger)index;
@end
