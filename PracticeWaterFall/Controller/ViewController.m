//
//  ViewController.m
//  PracticeWaterFall
//
//  Created by wangshanshan on 2018/4/8.
//  Copyright © 2018年 ws. All rights reserved.
//

#import "ViewController.h"
#import "CollectionViewCell.h"
#import "WaterFallLayout.h"
#import "Goods.h"
static NSString *identifier = @"CollectionViewCell";

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,WaterFallLayoutDelegate>
//@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
//@property (weak, nonatomic) IBOutlet WaterFallLayout *flowLayout;

@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) WaterFallLayout *flowLayout;
@property (strong, nonatomic) NSMutableArray *goodsArray;

@end

@implementation ViewController

//懒加载
-(NSMutableArray *)goodsArray{
    if (!_goodsArray) {
        _goodsArray = [NSMutableArray array];
    }
    return _goodsArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSArray *goods = [Goods goodsWithIndex:0];
    [self.goodsArray addObjectsFromArray:goods];
    [self collectionSetting];
    
}
-(void)collectionSetting{
    self.flowLayout = [[WaterFallLayout alloc]init];
    self.flowLayout.columnCount = 2;
    self.flowLayout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
    self.flowLayout.delegate = self;
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 20, self.view.bounds.size.width, self.view.bounds.size.height-20) collectionViewLayout:self.flowLayout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:identifier];
    [self.view addSubview:self.collectionView];
}

#pragma mark - UICollectionView dataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.goodsArray.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    Goods *goods = self.goodsArray[indexPath.item];
    cell.goods = goods;
    
    return cell;
}

#pragma mark - WaterFallLayoutDelegate
-(CGFloat)waterfallLayout:(WaterFallLayout *)waterfallLayout itemHeightForWidth:(CGFloat)itemWidth atIndexPath:(NSIndexPath *)indexPath{
    
    Goods *goods = self.goodsArray[indexPath.item];
    CGFloat itemHeight = itemWidth * goods.h/goods.w;
    return itemHeight;
}


@end
