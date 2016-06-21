//
//  HeApplyBuddy.m
//  huayoutong
//
//  Created by Tony on 16/5/3.
//  Copyright © 2016年 HeDongMing. All rights reserved.
//

#import "HeApplyBuddy.h"

@implementation HeApplyBuddy

- (id)initBuddyWithDict:(NSDictionary *)dict
{
    self = [super initBuddyWithDict:dict];
    if (self) {
        NSString *sponNote = [dict objectForKey:@"sponNote"];
        if ([sponNote isMemberOfClass:[NSNull class]] || sponNote == nil) {
            sponNote = @"";
        }
        self.sponNote = [[NSString alloc] initWithFormat:@"%@",sponNote];
        
        NSString *sponNickName = [dict objectForKey:@"sponNickName"];
        if ([sponNickName isMemberOfClass:[NSNull class]] || sponNickName == nil) {
            sponNickName = @"";
        }
        self.sponNickName = [[NSString alloc] initWithFormat:@"%@",sponNickName];
        
        NSString *sponPhoto = [dict objectForKey:@"sponPhoto"];
        if ([sponPhoto isMemberOfClass:[NSNull class]] || sponPhoto == nil) {
            sponPhoto = @"";
        }
        if (![sponPhoto hasPrefix:@"http"]) {
            sponPhoto = [[NSString alloc] initWithFormat:@"%@/%@",HYTIMAGEURL,sponPhoto];
        }
        self.sponPhoto = [[NSString alloc] initWithFormat:@"%@",sponPhoto];
        
        
    }
    return self;
}

- (id)initBudDyWithBuddy:(HeApplyBuddy *)buddy
{
    self = [super initBudDyWithBuddy:buddy];
    if (self) {
        self.sponNote = buddy.sponNote;
        self.sponNickName = buddy.sponNickName;
        self.sponPhoto = buddy.sponPhoto;
    }
    return self;
}

@end
