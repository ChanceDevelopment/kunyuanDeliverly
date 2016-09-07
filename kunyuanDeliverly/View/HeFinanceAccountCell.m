//
//  HeFinanceAccountCell.m
//  kunyuanseller
//
//  Created by Tony on 16/9/7.
//  Copyright © 2016年 iMac. All rights reserved.
//

#import "HeFinanceAccountCell.h"

@implementation HeFinanceAccountCell
@synthesize timeLabel;
@synthesize bannerImage;
@synthesize priceLabel;
@synthesize contentLabel;

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellSize:(CGSize)cellSize
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier cellSize:cellSize];
    if (self) {
        CGFloat timeX = 10;
        CGFloat timeY = 10;
        CGFloat timeH = cellSize.height - 2 * timeY;
        CGFloat timeW = 40;
        timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(timeX, timeY, timeW, timeH)];
        timeLabel.backgroundColor = [UIColor clearColor];
        timeLabel.textColor = [UIColor grayColor];
        timeLabel.text = @"08/09";
        timeLabel.numberOfLines = 0;
        timeLabel.font = [UIFont systemFontOfSize:13.0];
        timeLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:timeLabel];
        
        CGFloat imageX = CGRectGetMaxX(timeLabel.frame) + 5;
        CGFloat imageW = 80;
        CGFloat imageH = imageW;
        CGFloat imageY = (cellSize.height - imageH) / 2.0;
        
        bannerImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"comonDefaultImage"]];
        bannerImage.frame = CGRectMake(imageX, imageY, imageW, imageH);
        bannerImage.contentMode = UIViewContentModeScaleAspectFill;
        bannerImage.layer.masksToBounds = YES;
        bannerImage.layer.borderColor = [UIColor whiteColor].CGColor;
        [self addSubview:bannerImage];
        
        CGFloat priceX = CGRectGetMaxX(bannerImage.frame) + 5;
        CGFloat priceY = imageY;
        CGFloat priceH = imageH / 2.0;
        CGFloat priceW = SCREENWIDTH - priceX - 10;
        priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(priceX, priceY, priceW, priceH)];
        priceLabel.backgroundColor = [UIColor clearColor];
        priceLabel.textColor = [UIColor blackColor];
        priceLabel.text = @"+10.00";
        priceLabel.font = [UIFont systemFontOfSize:13.0];
        priceLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:priceLabel];
        
        CGFloat contentX = CGRectGetMaxX(bannerImage.frame) + 5;
        CGFloat contentY = CGRectGetMaxY(priceLabel.frame);
        CGFloat contentH = imageH / 2.0;
        CGFloat contentW = SCREENWIDTH - priceX - 10;
        contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(contentX, contentY, contentW, contentH)];
        contentLabel.numberOfLines = 2;
        contentLabel.backgroundColor = [UIColor clearColor];
        contentLabel.textColor = [UIColor grayColor];
        contentLabel.text = @"奶茶工坊配送到达，收取配送费+10";
        contentLabel.font = [UIFont systemFontOfSize:13.0];
        contentLabel.textAlignment = NSTextAlignmentLeft;
        [self addSubview:contentLabel];
        
    }
    return self;
}

@end
