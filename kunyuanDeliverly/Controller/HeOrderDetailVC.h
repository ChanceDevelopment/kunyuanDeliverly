//
//  HeOrderDetailVC.h
//  kunyuanseller
//
//  Created by HeDongMing on 16/9/5.
//  Copyright © 2016年 iMac. All rights reserved.
//

#import "HeBaseViewController.h"

@interface HeOrderDetailVC : HeBaseViewController
@property(strong,nonatomic)NSDictionary *orderBaseDict;
@property(strong,nonatomic)NSDictionary *orderDetailDict;
@property(assign,nonatomic)NSInteger orderState;

@end
