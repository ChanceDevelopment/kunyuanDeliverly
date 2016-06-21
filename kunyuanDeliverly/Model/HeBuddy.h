//
//  HeBuddy.h
//  huayoutong
//
//  Created by HeDongMing on 16/5/2.
//  Copyright © 2016年 HeDongMing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HeBuddy : NSObject
@property(strong,nonatomic)NSString *buddyID;
@property(strong,nonatomic)NSString *nickName;
@property(strong,nonatomic)NSString *showNoteName;
@property(strong,nonatomic)NSString *photo;
@property(strong,nonatomic)NSString *relationId;
@property(assign,nonatomic)BOOL friendState;

- (id)initBuddyWithDict:(NSDictionary *)dict;
- (id)initBudDyWithBuddy:(HeBuddy *)buddy;

@end
