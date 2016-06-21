//
//  HeConvertToCommonEmoticonsHelper.h
//  huayoutong
//
//  Created by HeDongMing on 16/5/5.
//  Copyright © 2016年 HeDongMing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HeConvertToCommonEmoticonsHelper : NSObject<UIWebViewDelegate>
@property(strong,nonatomic) NSMutableArray *emojiArray;
@property(strong,nonatomic) NSMutableArray *textArray;
@property(strong,nonatomic) NSMutableDictionary *numberDict;
@property(strong,nonatomic) UIWebView *encodewebview;

- (NSString *)converUnicodeToChinese:(NSString *)unicodeString;
- (NSString *)converChineseToUnicode:(NSString *)chineseString;

+ (HeConvertToCommonEmoticonsHelper *)shareInstance;

@end
