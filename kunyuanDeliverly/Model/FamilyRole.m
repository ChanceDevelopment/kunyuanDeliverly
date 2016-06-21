//
//  FamilyRole.m
//  huayoutong
//
//  Created by HeDongMing on 16/4/16.
//  Copyright © 2016年 HeDongMing. All rights reserved.
//  家庭成员角色的model

#import "FamilyRole.h"

@implementation FamilyRole

- (id)initRoleWithDict:(NSDictionary *)roleDict
{
    if (self = [super init]) {
        NSString *familyId = [roleDict objectForKey:@"familyId"];
        if ([familyId isMemberOfClass:[NSNull class]] || familyId == nil) {
            familyId = @"";
        }
        _familyId = [[NSString alloc] initWithString:familyId];
        
        NSString *familyName = [roleDict objectForKey:@"familyName"];
        if ([familyName isMemberOfClass:[NSNull class]] || familyName == nil) {
            familyName = @"";
        }
        _familyName = [[NSString alloc] initWithString:familyName];
        
        NSString *familyPhoto = [roleDict objectForKey:@"familyPhoto"];
        if ([familyPhoto isMemberOfClass:[NSNull class]] || familyPhoto == nil) {
            familyPhoto = @"";
        }
        _familyPhoto = [[NSString alloc] initWithFormat:@"%@/%@",HYTIMAGEURL,familyPhoto];
        
        NSString *familyRelation = [roleDict objectForKey:@"familyRelation"];
        if ([familyRelation isMemberOfClass:[NSNull class]] || familyRelation == nil) {
            familyRelation = @"";
        }
        _familyRelation = [[NSString alloc] initWithString:familyRelation];
        
        BOOL hasBind = [[roleDict objectForKey:@"hasBind"] boolValue];
        _hasBind = hasBind;
    }
    return self;
}

- (id)initRoleWithRole:(FamilyRole *)role
{
    if (self = [super init]) {

        _familyId = [[NSString alloc] initWithString:role.familyId];

        _familyName = [[NSString alloc] initWithString:role.familyName];
        
        _familyPhoto = [[NSString alloc] initWithString:role.familyPhoto];
        
        _familyRelation = [[NSString alloc] initWithString:role.familyRelation];
        
        _hasBind = role.hasBind;
    }
    return self;
}

@end
