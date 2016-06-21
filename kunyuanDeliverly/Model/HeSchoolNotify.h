//
//  HeSchoolNotify.h
//  huayoutong
//
//  Created by HeDongMing on 16/5/3.
//  Copyright © 2016年 HeDongMing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HeSchoolNotify : NSObject
@property(strong,nonatomic)NSString *content;
@property(strong,nonatomic)NSString *notificationSenderId;
@property(strong,nonatomic)NSString *notificationSenderName;
@property(strong,nonatomic)NSString *notificationCreateTime;
@property(assign,nonatomic)BOOL readed;
@property(strong,nonatomic)NSString *notifyID;

- (id)initNotificationWithDict:(NSDictionary *)notifyDict;
- (id)initNotificationWithNotification:(HeSchoolNotify *)notification;

@end
