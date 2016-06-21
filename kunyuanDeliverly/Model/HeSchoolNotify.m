//
//  HeSchoolNotify.m
//  huayoutong
//
//  Created by HeDongMing on 16/5/3.
//  Copyright © 2016年 HeDongMing. All rights reserved.
//

#import "HeSchoolNotify.h"

@implementation HeSchoolNotify


- (id)initNotificationWithDict:(NSDictionary *)notifyDict
{
    self = [super init];
    if (self) {
        NSString *content = notifyDict[@"content"];
        if ([content isMemberOfClass:[NSNull class]] || content == nil) {
            content = @"";
        }
        _content = [[NSString alloc] initWithFormat:@"%@",content];
        
        NSString *notificationSenderId = notifyDict[@"notificationSenderId"];
        if ([notificationSenderId isMemberOfClass:[NSNull class]] || notificationSenderId == nil) {
            notificationSenderId = @"";
        }
        _notificationSenderId = [[NSString alloc] initWithFormat:@"%@",notificationSenderId];
        
        NSString *notificationSenderName = notifyDict[@"notificationSenderName"];
        if ([notificationSenderName isMemberOfClass:[NSNull class]] || notificationSenderName == nil) {
            notificationSenderName = @"";
        }
        _notificationSenderName = [[NSString alloc] initWithFormat:@"%@",notificationSenderName];
        
        NSString *notificationCreateTime = notifyDict[@"notificationCreateTime"];
        if ([notificationCreateTime isMemberOfClass:[NSNull class]] || notificationCreateTime == nil) {
            notificationCreateTime = @"";
        }
        _notificationCreateTime = [[NSString alloc] initWithFormat:@"%@",notificationCreateTime];
        
        NSString *readed = notifyDict[@"readed"];
        if ([readed isMemberOfClass:[NSNull class]] || readed == nil) {
            readed = @"";
        }
        if ([readed compare:@"true" options:NSCaseInsensitiveSearch] == NSOrderedSame) {
            _readed = YES;
        }
        else{
            _readed = NO;
        }
        
        NSString *notifyID = notifyDict[@"notifyID"];
        if ([notifyID isMemberOfClass:[NSNull class]] || notifyID == nil) {
            notifyID = @"";
        }
        _notifyID = [[NSString alloc] initWithFormat:@"%@",notifyID];
    }
    return self;
}

- (id)initNotificationWithNotification:(HeSchoolNotify *)notification
{
    self = [super init];
    if (self) {
        _content = notification.content;
        _notificationSenderId = notification.notificationSenderId;
        _notificationSenderName = notification.notificationSenderName;
        _notificationCreateTime = notification.notificationCreateTime;
        _readed = notification.readed;
        _notifyID = notification.notifyID;
        
    }
    return self;
}
@end
