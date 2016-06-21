//
//  FamilyRole.h
//  huayoutong
//
//  Created by HeDongMing on 16/4/16.
//  Copyright © 2016年 HeDongMing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FamilyRole : NSObject
//家庭角色的ID
@property(strong,nonatomic)NSString *familyId;
//名称
@property(strong,nonatomic)NSString *familyName;
//头像
@property(strong,nonatomic)NSString *familyPhoto;
//关系
@property(strong,nonatomic)NSString *familyRelation;
//是否已经绑定
@property(assign,nonatomic)BOOL hasBind;

- (id)initRoleWithDict:(NSDictionary *)roleDict;
- (id)initRoleWithRole:(FamilyRole *)role;
@end
