//
//  HeBaseAlbumItem.h
//  huayoutong
//
//  Created by Tony on 16/3/9.
//  Copyright © 2016年 HeDongMing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeBaseAlbumItem : UIView
@property(strong,nonatomic)id imageSource;  //图片的资源，可以是图片url、图片的数据、或者直接是图片的nsurl
@property(strong,nonatomic)NSString *itemTitle; //本相册的标题
@property(strong,nonatomic)NSString *itemID; //本相册的ID
@property(assign,nonatomic)NSInteger photoCount; //本相册的相片数目

@end
