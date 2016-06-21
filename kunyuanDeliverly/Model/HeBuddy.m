//
//  HeBuddy.m
//  huayoutong
//
//  Created by HeDongMing on 16/5/2.
//  Copyright © 2016年 HeDongMing. All rights reserved.
//

#import "HeBuddy.h"

@implementation HeBuddy

- (id)initBuddyWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        NSString *buddyID = [dict objectForKey:@"id"];
        if ([buddyID isMemberOfClass:[NSNull class]] || buddyID == nil) {
            buddyID = @"";
        }
        self.buddyID = [[NSString alloc] initWithFormat:@"%@",buddyID];
        
        NSString *showNoteName = [dict objectForKey:@"showNoteName"];
        if ([showNoteName isMemberOfClass:[NSNull class]] || showNoteName == nil) {
            showNoteName = @"";
        }
        self.showNoteName = [[NSString alloc] initWithFormat:@"%@",showNoteName];
        
        NSString *photo = [dict objectForKey:@"photo"];
        if ([photo isMemberOfClass:[NSNull class]] || photo == nil) {
            photo = @"";
        }
        if (![photo hasPrefix:@"http"]) {
            photo = [NSString stringWithFormat:@"%@/%@",HYTIMAGEURL,photo];
        }
        
        self.photo = [[NSString alloc] initWithFormat:@"%@",photo];
        
        NSString *relationId = [dict objectForKey:@"relationId"];
        if ([relationId isMemberOfClass:[NSNull class]] || relationId == nil) {
            relationId = @"";
        }
        self.relationId = relationId;
        
        BOOL friendState = [[dict objectForKey:@"friendState"] boolValue];
        self.friendState = friendState;
        
        NSString *nickName = [dict objectForKey:@"nickName"];
        if ([nickName isMemberOfClass:[NSNull class]] || nickName == nil) {
            nickName = @"";
        }
        self.nickName = nickName;
    }
    return self;
}

- (id)initBudDyWithBuddy:(HeBuddy *)buddy
{
    self = [super init];
    if (self) {
        NSString *buddyID = buddy.buddyID;
        if ([buddyID isMemberOfClass:[NSNull class]] || buddyID == nil) {
            buddyID = @"";
        }
        self.buddyID = [[NSString alloc] initWithFormat:@"%@",buddyID];
        
        NSString *showNoteName = buddy.showNoteName;
        if ([showNoteName isMemberOfClass:[NSNull class]] || showNoteName == nil) {
            showNoteName = @"";
        }
        self.showNoteName = [[NSString alloc] initWithFormat:@"%@",showNoteName];
        
        NSString *photo = buddy.photo;
        if ([photo isMemberOfClass:[NSNull class]] || photo == nil) {
            photo = @"";
        }
        if (![photo hasPrefix:@"http"]) {
            photo = [NSString stringWithFormat:@"%@/%@",HYTIMAGEURL,photo];
        }
        self.photo = [[NSString alloc] initWithFormat:@"%@",photo];
        
        self.relationId = buddy.relationId;
        
        self.friendState = buddy.friendState;
        
        self.nickName = buddy.nickName;
    }
    return self;
}

@end
