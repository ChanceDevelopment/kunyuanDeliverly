//
//  HeFinanceAccountCell.h
//  kunyuanseller
//
//  Created by Tony on 16/9/7.
//  Copyright © 2016年 iMac. All rights reserved.
//

#import "HeBaseTableViewCell.h"

@interface HeFinanceAccountCell : HeBaseTableViewCell
@property(strong,nonatomic)UILabel *timeLabel;
@property(strong,nonatomic)UIImageView *bannerImage;
@property(strong,nonatomic)UILabel *priceLabel;
@property(strong,nonatomic)UILabel *contentLabel;

@end
