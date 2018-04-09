//
//  CollectionViewCell.m
//  PracticeWaterFall
//
//  Created by wangshanshan on 2018/4/8.
//  Copyright © 2018年 ws. All rights reserved.
//

#import "CollectionViewCell.h"

@interface CollectionViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@end


@implementation CollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setGoods:(Goods *)goods{
    _goods = goods;
    self.priceLabel.text = goods.price;
    
}

@end
