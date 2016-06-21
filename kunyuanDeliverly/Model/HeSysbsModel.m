//
//  HeSysbsModel.m
//  huayoutong
//
//  Created by HeDongMing on 16/3/2.
//  Copyright © 2016年 HeDongMing. All rights reserved.
//

#import "HeSysbsModel.h"

static HeSysbsModel* sharedModel = nil;

@implementation HeSysbsModel

+ (HeSysbsModel *)getSysModel
{
    if (sharedModel == nil) {
        sharedModel = [[HeSysbsModel alloc] init];
        sharedModel.user = [[User alloc] init];
        sharedModel.albumArray = [[NSArray alloc] init];
    }
    return sharedModel;
}

@end
