
//
//  UserAlbum.m
//  huayoutong
//
//  Created by HeDongMing on 16/4/22.
//  Copyright © 2016年 HeDongMing. All rights reserved.
//

#import "UserAlbum.h"

@implementation UserAlbum

- (id)initAlbumWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        NSString *idstr = dict[@"id"];
        if ([idstr isMemberOfClass:[NSNull class]] || idstr == nil) {
            idstr = @"";
        }
        _albumID = [[NSString alloc] initWithString:idstr];
        NSString *name = dict[@"name"];
        if ([name isMemberOfClass:[NSNull class]] || name == nil) {
            name = @"";
        }
        _albumName = [[NSString alloc] initWithString:name];
    }
    return self;
}

@end
