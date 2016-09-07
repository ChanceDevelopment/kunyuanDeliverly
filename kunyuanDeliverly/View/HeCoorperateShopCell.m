//
//  HeCoorperateShopCell.m
//  kunyuanDeliverly
//
//  Created by HeDongMing on 16/9/7.
//  Copyright © 2016年 iMac. All rights reserved.
//

#import "HeCoorperateShopCell.h"

@implementation HeCoorperateShopCell
@synthesize bgView;
@synthesize bannerImage;
@synthesize nameLabel;
@synthesize timeLabel;

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellSize:(CGSize)cellsize
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier cellSize:cellsize];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:237.0 / 255.0 alpha:1.0];
        
        CGFloat bgX = 10;
        CGFloat bgY = 10;
        CGFloat bgW = cellsize.width - 2 * bgX;
        CGFloat bgH = cellsize.height - 2 * bgY;
        bgView = [[UIView alloc] initWithFrame:CGRectMake(bgX, bgY, bgW, bgH)];
        bgView.backgroundColor = [UIColor whiteColor];
        bgView.layer.cornerRadius = 5.0;
        bgView.layer.masksToBounds = YES;
        [self addSubview:bgView];
        
        CGFloat imageX = CGRectGetMaxX(timeLabel.frame) + 5;
        CGFloat imageW = 60;
        CGFloat imageH = imageW;
        CGFloat imageY = (bgH - imageH) / 2.0;
        
        bannerImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"userDefalut_icon"]];
        bannerImage.frame = CGRectMake(imageX, imageY, imageW, imageH);
        bannerImage.contentMode = UIViewContentModeScaleAspectFill;
        bannerImage.layer.masksToBounds = YES;
        bannerImage.layer.cornerRadius = imageW / 2.0;
        bannerImage.layer.masksToBounds = YES;
        bannerImage.layer.borderColor = [UIColor whiteColor].CGColor;
        [bgView addSubview:bannerImage];
        
        CGFloat priceX = CGRectGetMaxX(bannerImage.frame) + 5;
        CGFloat priceY = imageY;
        CGFloat priceH = imageH / 2.0;
        CGFloat priceW = bgW - priceX - 10;
        nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(priceX, priceY, priceW, priceH)];
        nameLabel.backgroundColor = [UIColor clearColor];
        nameLabel.textColor = [UIColor blackColor];
        nameLabel.text = @"周黑鸭旗舰店";
        nameLabel.font = [UIFont systemFontOfSize:15.0];
        nameLabel.textAlignment = NSTextAlignmentLeft;
        [bgView addSubview:nameLabel];
        
        CGFloat timeX = CGRectGetMaxX(bannerImage.frame) + 5;;
        CGFloat timeY = CGRectGetMaxY(nameLabel.frame);
        CGFloat timeH = imageH / 2.0;
        CGFloat timeW = bgW - priceX - 10;
        timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(timeX, timeY, timeW, timeH)];
        timeLabel.backgroundColor = [UIColor clearColor];
        timeLabel.textColor = [UIColor grayColor];
        timeLabel.text = @"合作开始时间: 2016-04-22";
        timeLabel.numberOfLines = 0;
        timeLabel.font = [UIFont systemFontOfSize:15.0];
        timeLabel.textAlignment = NSTextAlignmentLeft;
        [bgView addSubview:timeLabel];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextFillRect(context, rect);
    
    //上分割线，
    CGContextSetStrokeColorWithColor(context, ([UIColor clearColor]).CGColor);
    CGContextStrokeRect(context, CGRectMake(0, -1, rect.size.width, 1));
    
    //下分割线
    CGContextSetStrokeColorWithColor(context, ([UIColor clearColor]).CGColor);
    CGContextStrokeRect(context, CGRectMake(0, rect.size.height, rect.size.width, 1));
}

@end
