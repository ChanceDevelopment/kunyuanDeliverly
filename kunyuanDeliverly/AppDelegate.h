//
//  AppDelegate.h
//  huayoutong
//
//  Created by HeDongMing on 16/2/23.
//  Copyright © 2016年 HeDongMing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Base/BMKBaseComponent.h>

static NSString *appKey = JPUSHAPPKEY;
static NSString *channel = @"App Store";  //下载的渠道
static BOOL isProduction = FALSE;

@interface AppDelegate : UIResponder <UIApplicationDelegate,BMKGeneralDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UIViewController *viewController;
@property (strong, nonatomic)NSOperationQueue *queue;


@end

