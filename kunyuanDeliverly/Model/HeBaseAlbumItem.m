//
//  HeBaseAlbumItem.m
//  huayoutong
//
//  Created by Tony on 16/3/9.
//  Copyright © 2016年 HeDongMing. All rights reserved.
//

#define TITLEHEIGHT 20
#define IMAGEBLANKWIDTH 5
#define IMAGEBLANKHEIGHT 5

#import "HeBaseAlbumItem.h"

@interface HeBaseAlbumItem()
@property(strong,nonatomic)UIImageView *imageView;
@property(strong,nonatomic)UILabel *titleLabel;

@end

@implementation HeBaseAlbumItem

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:DEFAULTERRORIMAGE]];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.layer.masksToBounds = YES;
        [self addSubview:_imageView];
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont fontWithName:@"Helvetica" size:13.0];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.backgroundColor = [UIColor colorWithWhite:237.0 / 255.0 alpha:1.0];
        _titleLabel.textColor = [UIColor colorWithWhite:50.0 / 255.0 alpha:1.0];
        _titleLabel.text = @"未命名";
        [self addSubview:_titleLabel];
        
        self.layer.borderWidth = 1.0;
        self.layer.borderColor = [UIColor colorWithWhite:237.0 / 255.0 alpha:1.0].CGColor;
        self.layer.masksToBounds = YES;
        self.backgroundColor = [UIColor whiteColor];
        
    }
    return self;
}

- (void)setImageSource:(id)imageSource
{
    if ([imageSource isKindOfClass:[NSString class]]) {
        [_imageView sd_setImageWithURL:[NSURL URLWithString:imageSource] placeholderImage:_imageView.image];
    }
    else if ([imageSource isKindOfClass:[UIImage class]]){
        _imageView.image = imageSource;
    }
    else if ([imageSource isKindOfClass:[NSURL class]]){
        [_imageView sd_setImageWithURL:imageSource placeholderImage:_imageView.image];
    }
    _imageView.frame = CGRectMake(IMAGEBLANKWIDTH, IMAGEBLANKHEIGHT, CGRectGetWidth(self.frame) - 2 * IMAGEBLANKWIDTH, CGRectGetHeight(self.frame) - TITLEHEIGHT - 2 * IMAGEBLANKHEIGHT);
    
}

- (void)setItemTitle:(NSString *)itemTitle
{
    _titleLabel.text = itemTitle;
    _titleLabel.frame = CGRectMake(0, CGRectGetHeight(self.frame) - TITLEHEIGHT, CGRectGetWidth(self.frame), TITLEHEIGHT);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
