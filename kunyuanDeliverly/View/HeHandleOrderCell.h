//
//  HeHandleOrderCell.h
//  kunyuanseller
//
//  Created by HeDongMing on 16/9/5.
//  Copyright © 2016年 iMac. All rights reserved.
//

#import "HeBaseTableViewCell.h"


@interface HeHandleOrderCell : HeBaseTableViewCell
@property(strong,nonatomic)UIView *orderBgView;
@property(strong,nonatomic)UILabel *moneyLabel;
@property(strong,nonatomic)UILabel *distanceLabel;
@property(strong,nonatomic)UILabel *addressLabel;
@property(strong,nonatomic)UILabel *distributeAddressLabel;

@property(strong,nonatomic)NSDictionary *orderDict;

@property(assign,nonatomic)NSInteger orderState; // 1:抢单 2:已完成 3:配送中
//@property(strong,nonatomic)UILabel *timeLabel;
//@property(strong,nonatomic)UILabel *nameLabel;
//@property(strong,nonatomic)UILabel *phoneLabel;
//@property(strong,nonatomic)UILabel *priceLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellSize:(CGSize)cellSize orderState:(NSInteger)state;
@end
