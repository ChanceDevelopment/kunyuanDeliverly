//
//  HeTabBarVC.h
//  huayoutong
//
//  Created by HeDongMing on 16/3/2.
//  Copyright © 2016年 HeDongMing. All rights reserved.
//

#import "HeBaseViewController.h"
#import "RDVTabBarController.h"
#import "HeOrderManagementVC.h"
#import "HeUserVC.h"
#import "HeBalanceVC.h"
#import "HeFinanceAccountVC.h"

@interface HeTabBarVC : RDVTabBarController<UIAlertViewDelegate>
@property(strong,nonatomic)HeOrderManagementVC *orderManagementVC;
@property(strong,nonatomic)HeFinanceAccountVC *balanceVC;
@property(strong,nonatomic)HeUserVC *userVC;

@end
