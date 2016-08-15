//
//  HeBaseIconTitleTableCell.m
//  beautyContest
//
//  Created by Tony on 16/8/3.
//  Copyright © 2016年 iMac. All rights reserved.
//

#import "HeBaseIconTitleTableCell.h"

@implementation HeBaseIconTitleTableCell
@synthesize icon;
@synthesize topicLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cellSize:(CGSize)cellSize
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier cellSize:cellSize];
    if (self) {
        CGFloat iconH = 25;
        CGFloat iconW = 25;
        CGFloat iconX = 10;
        CGFloat iconY = (cellSize.height - iconH) / 2.0;
        icon = [[UIImageView alloc] init];
        icon.frame = CGRectMake(iconX, iconY, iconW, iconH);
        [self addSubview:icon];
        
        UIFont *textFont = [UIFont systemFontOfSize:16.0];
        
        CGFloat titleX = iconX + iconW + 10;
        CGFloat titleY = 0;
        CGFloat titleH = cellSize.height;
        CGFloat titleW = SCREENWIDTH - titleX - 10;
        topicLabel = [[UILabel alloc] init];
        topicLabel.textAlignment = NSTextAlignmentLeft;
        topicLabel.backgroundColor = [UIColor clearColor];
        topicLabel.text = @"";
        topicLabel.numberOfLines = 0;
        topicLabel.textColor = [UIColor blackColor];
        topicLabel.font = textFont;
        topicLabel.frame = CGRectMake(titleX, titleY, titleW, titleH);
        [self addSubview:topicLabel];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
