//
//  PhotoModel.h
//  huayoutong
//
//  Created by Tony on 16/4/22.
//  Copyright © 2016年 HeDongMing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhotoModel : NSObject
@property(strong,nonatomic)NSString *photoID;
@property(strong,nonatomic)NSString *photoName;
@property(strong,nonatomic)NSString *descr; //相片的描述
@property(strong,nonatomic)NSString *thumbLink;//缩略图
@property(strong,nonatomic)NSString *link;//原图


@end
