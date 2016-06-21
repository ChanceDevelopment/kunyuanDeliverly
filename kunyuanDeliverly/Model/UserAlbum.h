//
//  UserAlbum.h
//  huayoutong
//
//  Created by HeDongMing on 16/4/22.
//  Copyright © 2016年 HeDongMing. All rights reserved.
//  用户相册：我的相册、班级相册、学校相册

#import <Foundation/Foundation.h>

@interface UserAlbum : NSObject
@property(strong,nonatomic)NSString *albumID;
@property(strong,nonatomic)NSString *albumName;

- (id)initAlbumWithDict:(NSDictionary *)dcit;

@end
