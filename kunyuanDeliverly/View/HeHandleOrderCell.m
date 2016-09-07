//
//  HeOrderManagementCell.m
//  kunyuanseller
//
//  Created by Tony on 16/6/21.
//  Copyright © 2016年 iMac. All rights reserved.
//

#import "HeHandleOrderCell.h"
#import "UIButton+Bootstrap.h"
#import "MLLabel+Size.h"

#define TextLineHeight 1.2f

@implementation HeHandleOrderCell
@synthesize orderBgView;
@synthesize moneyLabel;
@synthesize distanceLabel;
@synthesize addressLabel;
@synthesize distributeAddressLabel;
@synthesize orderDict;
@synthesize orderState;

//@synthesize timeLabel;
//@synthesize nameLabel;
//@synthesize phoneLabel;
//@synthesize priceLabel;

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellSize:(CGSize)cellSize orderState:(NSInteger)state
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        orderState = state;
        
        self.backgroundColor = [UIColor colorWithWhite:237.0 / 255.0 alpha:1.0];
        
        CGFloat viewX = 10;
        CGFloat viewY = 10;
        CGFloat viewW = cellSize.width - 2 * viewX;
        CGFloat viewH = cellSize.height - 2 * viewY;
        
        orderBgView = [[UIView alloc] initWithFrame:CGRectMake(viewX, viewY, viewW, viewH)];
        orderBgView.backgroundColor = [UIColor whiteColor];
        orderBgView.layer.cornerRadius = 5.0;
        orderBgView.layer.masksToBounds = YES;
        [self addSubview:orderBgView];
        
        CGFloat headH = 90;
        
        CGFloat totalMoneyX = 0;
        CGFloat totalMoneyH = 30;
        CGFloat totalMoneyY = (headH - 2 * totalMoneyH) / 2.0;
        CGFloat totalMoneyW = viewW / 2.0;
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(totalMoneyX, totalMoneyY, totalMoneyW, totalMoneyH)];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textColor = [UIColor grayColor];
        titleLabel.font = [UIFont systemFontOfSize:17.0];
        titleLabel.text = @"收入";
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [orderBgView addSubview:titleLabel];
        
        moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(totalMoneyX, CGRectGetMaxY(titleLabel.frame), totalMoneyW, totalMoneyH)];
        moneyLabel.backgroundColor = [UIColor clearColor];
        moneyLabel.textColor = [UIColor redColor];
        moneyLabel.font = [UIFont systemFontOfSize:17.0];
        moneyLabel.text = @"8.0元";
        moneyLabel.textAlignment = NSTextAlignmentCenter;
        [orderBgView addSubview:moneyLabel];
        
        UILabel *titleLabel1 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(titleLabel.frame), totalMoneyY, totalMoneyW, totalMoneyH)];
        titleLabel1.backgroundColor = [UIColor clearColor];
        titleLabel1.textColor = [UIColor grayColor];
        titleLabel1.font = [UIFont systemFontOfSize:17.0];
        titleLabel1.text = @"配送距离";
        titleLabel1.textAlignment = NSTextAlignmentCenter;
        [orderBgView addSubview:titleLabel1];
        
        distanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(titleLabel.frame), CGRectGetMaxY(titleLabel1.frame), totalMoneyW, totalMoneyH)];
        distanceLabel.backgroundColor = [UIColor clearColor];
        distanceLabel.textColor = [UIColor grayColor];
        distanceLabel.font = [UIFont systemFontOfSize:17.0];
        distanceLabel.text = @"3.0公里";
        distanceLabel.textAlignment = NSTextAlignmentCenter;
        [orderBgView addSubview:distanceLabel];
        
        CGFloat middleX = viewW / 2.0 - 0.5;
        CGFloat middleY = 20;
        CGFloat middleW = 2;
        CGFloat middleH = headH - 2 * middleY;
        UIView *middleLine = [[UIView alloc] initWithFrame:CGRectMake(middleX, middleY, middleW, middleH)];
        middleLine.backgroundColor = [UIColor grayColor];
        [orderBgView addSubview:middleLine];
        
        CGFloat bottomX = 10;
        CGFloat bottomY = headH - 1;
        CGFloat bottomW = viewW - 2 * 10;
        CGFloat bottomH = 2;
        UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(bottomX, bottomY, bottomW, bottomH)];
        bottomLine.backgroundColor = APPDEFAULTORANGE;
        [orderBgView addSubview:bottomLine];
        
        CGFloat iconX = 10;
        CGFloat iconY = CGRectGetMaxY(bottomLine.frame) + 10;
        CGFloat iconW = 30;
        CGFloat iconH = iconW;
        
        UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(iconX, iconY, iconW, iconH)];
        iconView.image = [UIImage imageNamed:@"icon_get"];
        [orderBgView addSubview:iconView];
        
        iconY = CGRectGetMaxY(iconView.frame) + 10;
        UIImageView *iconView1 = [[UIImageView alloc] initWithFrame:CGRectMake(iconX, iconY, iconW, iconH)];
        iconView1.image = [UIImage imageNamed:@"icon_send"];
        [orderBgView addSubview:iconView1];
        
        //取餐地址
        CGFloat addressX = CGRectGetMaxX(iconView.frame) + 10;
        CGFloat addressY = CGRectGetMinY(iconView.frame);
        CGFloat addressH = iconH;
        CGFloat addressW = viewW - addressX - 10;
        addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(addressX, addressY, addressW, addressH)];
        addressLabel.backgroundColor = [UIColor clearColor];
        addressLabel.textColor = [UIColor blackColor];
        addressLabel.text = @"北京市大柳树富海中心4号楼304";
        addressLabel.font = [UIFont systemFontOfSize:16.0];
        addressLabel.textAlignment = NSTextAlignmentLeft;
        [orderBgView addSubview:addressLabel];
        
        //配送地址
        addressX = CGRectGetMaxX(iconView1.frame) + 5;
        addressY = CGRectGetMinY(iconView1.frame);
        distributeAddressLabel = [[UILabel alloc] initWithFrame:CGRectMake(addressX, addressY, addressW, addressH)];
        distributeAddressLabel.backgroundColor = [UIColor clearColor];
        distributeAddressLabel.textColor = [UIColor blackColor];
        distributeAddressLabel.text = @"大柳树富海中心4号楼304";
        distributeAddressLabel.font = [UIFont systemFontOfSize:16.0];
        distributeAddressLabel.textAlignment = NSTextAlignmentLeft;
        [orderBgView addSubview:distributeAddressLabel];
        
        CGFloat detailX = 30;
        CGFloat detailY = CGRectGetMaxY(distributeAddressLabel.frame) + 15;
        CGFloat detailW = viewW - 2 * detailX;
        CGFloat detailH = 40;
        UIButton *detailButton = [[UIButton alloc] initWithFrame:CGRectMake(detailX, detailY, detailW, detailH)];
        [detailButton infoStyle];
        switch (orderState) {
            case 1:
            {
                [detailButton setTitle:@"立即接单" forState:UIControlStateNormal];
                break;
            }
            case 2:
            {
                [detailButton setTitle:@"查看订单详情" forState:UIControlStateNormal];
                break;
            }
            case 3:
            {
                [detailButton setTitle:@"正在配送/订单详情" forState:UIControlStateNormal];
                break;
            }
            default:
                break;
        }
        
        [detailButton setBackgroundImage:[Tool buttonImageFromColor:[UIColor orangeColor] withImageSize:detailButton.frame.size] forState:UIControlStateNormal];
        [detailButton addTarget:self action:@selector(detailButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [orderBgView addSubview:detailButton];
        
    }
    return self;
}


- (void)detailButtonClick:(UIButton *)button
{
    NSLog(@"button = %@",button);
    [self routerEventWithName:@"detailOrder" userInfo:orderDict];
}

@end
