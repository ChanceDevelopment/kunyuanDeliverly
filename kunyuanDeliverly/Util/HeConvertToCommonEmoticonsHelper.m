//
//  HeConvertToCommonEmoticonsHelper.m
//  huayoutong
//
//  Created by HeDongMing on 16/5/5.
//  Copyright © 2016年 HeDongMing. All rights reserved.
//

#import "HeConvertToCommonEmoticonsHelper.h"

static HeConvertToCommonEmoticonsHelper* sharedEmoticonsHelper = nil;

@implementation HeConvertToCommonEmoticonsHelper

+ (HeConvertToCommonEmoticonsHelper *)shareInstance
{
    if (sharedEmoticonsHelper == nil) {
        sharedEmoticonsHelper = [[HeConvertToCommonEmoticonsHelper alloc] init];
        sharedEmoticonsHelper.numberDict = [[NSMutableDictionary alloc] initWithCapacity:0];
        NSString *dataPath = [[NSBundle mainBundle] pathForResource:@"numberPlist" ofType:@"plist"];
        sharedEmoticonsHelper.numberDict = [[NSMutableDictionary alloc] initWithContentsOfFile:dataPath];
        
        
        dataPath = [[NSBundle mainBundle] pathForResource:@"emojiFaceArray" ofType:@"plist"];
        sharedEmoticonsHelper.emojiArray = [[NSMutableArray alloc] initWithContentsOfFile:dataPath];
        
        dataPath = [[NSBundle mainBundle] pathForResource:@"emojiArray" ofType:@"plist"];
        NSArray *emojiArray = [[NSArray alloc] initWithContentsOfFile:dataPath];
        [sharedEmoticonsHelper.emojiArray addObjectsFromArray:emojiArray];
        
        dataPath = [[NSBundle mainBundle] pathForResource:@"unicodeArray" ofType:@"plist"];
        sharedEmoticonsHelper.textArray = [[NSMutableArray alloc] initWithContentsOfFile:dataPath];
        
        dataPath = [[NSBundle mainBundle] pathForResource:@"textArray" ofType:@"plist"];
        NSArray *textArray = [[NSArray alloc] initWithContentsOfFile:dataPath];
        [sharedEmoticonsHelper.textArray addObjectsFromArray:textArray];
    }
    return sharedEmoticonsHelper;
}

- (NSString *)converUnicodeToChinese:(NSString *)unicodeString
{
    NSMutableString *mutable_unicodeStr = [[NSMutableString alloc] initWithString:unicodeString];
    
    NSArray *numberKeyArray = [sharedEmoticonsHelper.numberDict allKeys];
    NSArray *valueArray = [sharedEmoticonsHelper.numberDict allValues];
    
    for (int index = 0; index < [sharedEmoticonsHelper.emojiArray count]; index++) {
        NSString *textString = sharedEmoticonsHelper.textArray[index];
        NSString *emojiString = sharedEmoticonsHelper.emojiArray[index];
        
        NSRange range;
        range.location = 0;
        range.length = mutable_unicodeStr.length;
        
        [mutable_unicodeStr replaceOccurrencesOfString:textString withString:emojiString options:NSLiteralSearch range:range];
        
        range.location = 0;
        range.length = mutable_unicodeStr.length;
        if (index < [numberKeyArray count]) {
            NSString *numberKey = numberKeyArray[index];
            NSString *numberValue = valueArray[index];
            [mutable_unicodeStr replaceOccurrencesOfString:numberKey withString:numberValue options:NSLiteralSearch range:range];
        }
    }
    
    NSArray *unicode_arr = [mutable_unicodeStr componentsSeparatedByString:@"&#"];
    
    NSMutableString *mutableString = [[NSMutableString alloc] initWithCapacity:0];
    for(NSString *unicode in unicode_arr){
        if ([unicode hasSuffix:@";"]) {
            NSString *delete_unicode = [unicode stringByReplacingOccurrencesOfString:@";" withString:@""];
            NSString *originalString = [[NSString alloc] initWithString:unicode];
            char *c = malloc(3);
            int value = [delete_unicode intValue];
            NSInteger value1 = value  & 0x00FF;
            NSInteger value2 = value >> 8 & 0x00FF;
            if (value2 == 0) {
                value2 = value1;
                value1 = 0;
            }
            c[1] = value1;
            c[0] = value2;
            
//            c[2] = 0;
            NSString *str = [NSString stringWithCString:c encoding:NSUnicodeStringEncoding];
            if (str.length > 0 && delete_unicode.length <= 5) {
                NSString *subString = [str substringWithRange:NSMakeRange(0, 1)];
                mutableString = [NSMutableString stringWithFormat:@"%@%@",mutableString,subString];
            }
            else{
                if (delete_unicode.length <= 3) {
                    NSString *string = [NSString stringWithFormat:@"%s", c];
                    mutableString = [NSMutableString stringWithFormat:@"%@%@",mutableString,string];
                }
                else{
                    mutableString = [NSMutableString stringWithFormat:@"%@%@",mutableString,originalString];
                }
                
            }
            
            free(c);
        }
        else{
            NSArray *subArray = [unicode componentsSeparatedByString:@";"];
            for(NSString *v in subArray){
                NSString *originalString = [[NSString alloc] initWithString:v];
                char *c = malloc(2);
                int value = [v intValue];
                NSInteger value1 = value  & 0x00FF;
                NSInteger value2 = value >> 8 & 0x00FF;
                if (value2 == 0) {
                    value2 = value1;
                    value1 = 0;
                }
                c[1] = value1;
                c[0] = value2;
                
                NSString *str = [NSString stringWithCString:c encoding:NSUnicodeStringEncoding];
                if (str.length > 0 && originalString.length <= 5) {
                    NSString *subString = [str substringWithRange:NSMakeRange(0, 1)];
                    mutableString = [NSMutableString stringWithFormat:@"%@%@",mutableString,subString];
                }
                else{
                    if (originalString.length <= 2) {
                        NSString *string = [NSString stringWithFormat:@"%s", c];
                        mutableString = [NSMutableString stringWithFormat:@"%@%@",mutableString,string];
                    }
                    else{
                        mutableString = [NSMutableString stringWithFormat:@"%@%@",mutableString,originalString];
                    }
                }
                
                free(c);
            }
        }
    }
    NSString *resultString = [NSString stringWithFormat:@"%@",mutableString];
    return resultString;
}

- (NSString *)converChineseToUnicode:(NSString *)chineseString
{
    NSMutableString *mutable_unicodeStr = [[NSMutableString alloc] initWithString:chineseString];
    
    //本地存在的emoji
//    NSMutableString *exit_deleteString = [[NSMutableString alloc] initWithCapacity:0];
//    for (int index = 0; index < [sharedEmoticonsHelper.emojiArray count]; index++) {
//        NSString *textString = sharedEmoticonsHelper.textArray[index];
//        NSString *emojiString = sharedEmoticonsHelper.emojiArray[index];
//        NSRange range = [chineseString rangeOfString:emojiString];
//        if (range.length != 0) {
//            [mutable_unicodeStr appendString:<#(nonnull NSString *)#>]
//        }
//        
//    }
    
    
    for (int index = 0; index < [sharedEmoticonsHelper.emojiArray count]; index++) {
        NSString *textString = sharedEmoticonsHelper.textArray[index];
        NSString *emojiString = sharedEmoticonsHelper.emojiArray[index];
        
        NSRange range;
        range.location = 0;
        range.length = mutable_unicodeStr.length;
        
//        if ([mutable_unicodeStr rangeOfString:emojiString].length != 0) {
//            NSString *string = [mutable_unicodeStr stringByReplacingOccurrencesOfString:emojiString withString:textString];
//            mutable_unicodeStr = [[NSMutableString alloc] initWithString:string];
//        }
        
        [mutable_unicodeStr replaceOccurrencesOfString:emojiString withString:textString options:NSLiteralSearch range:range];
        
//        range.location = 0;
//        range.length = mutable_unicodeStr.length;
//        if (index < [numberKeyArray count]) {
//            NSString *numberKey = numberKeyArray[index];
//            NSString *numberValue = valueArray[index];
//            [mutable_unicodeStr replaceOccurrencesOfString:numberValue withString:numberKey options:NSLiteralSearch range:range];
//        }
    }
    
    
    NSInteger stringLength = [mutable_unicodeStr length];
    NSMutableString *mutableString = [[NSMutableString alloc] initWithString:mutable_unicodeStr];
//    
//    for (int index = 0; index < stringLength; index++) {
//        NSString *subString = [mutable_unicodeStr substringWithRange:NSMakeRange(index, 1)];
//        NSString *originalString = [NSString stringWithFormat:@"%@",subString];
//        
//        const char *charSub = [subString cStringUsingEncoding:NSUnicodeStringEncoding];
//        char *expr = (char *)charSub;
//        NSInteger value1 = expr[0] & 0x00FF;
//        NSInteger value2 = expr[1] << 8 & 0xFF00;
//        if (value2 == 0) {
//            mutableString = [NSMutableString stringWithFormat:@"%@%@",mutableString,originalString];
//            continue;
//        }
//        else if (![originalString isEqualToString:@""]){
//            NSInteger value = value1 + value2;
//            NSString *valueString = [NSString stringWithFormat:@"&#%ld;",value];
//            mutableString = [NSMutableString stringWithFormat:@"%@%@",mutableString,valueString];
//        }
//        
//    }
    NSString *resultString = [NSString stringWithFormat:@"%@",mutableString];
    
    resultString = [resultString stringByReplacingOccurrencesOfString:@"\\" withString:@"\\\\"];
//    resultString = [self filterEmoji:resultString];
//    resultString = [sharedEmoticonsHelper converUnicodeToChinese:resultString];
    return resultString;
}

//过滤表情
- (NSString *)filterEmoji:(NSString *)string {
    NSUInteger len = [string lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    const char *utf8 = [string UTF8String];
    char *newUTF8 = malloc( sizeof(char) * len );
    int j = 0;
    
    //0xF0(4) 0xE2(3) 0xE3(3) 0xC2(2) 0x30---0x39(4)
    for ( int i = 0; i < len; i++ ) {
        unsigned int c = utf8;
        BOOL isControlChar = NO;
        if ( c == 4294967280 ||
            c == 4294967089 ||
            c == 4294967090 ||
            c == 4294967091 ||
            c == 4294967092 ||
            c == 4294967093 ||
            c == 4294967094 ||
            c == 4294967095 ||
            c == 4294967096 ||
            c == 4294967097 ||
            c == 4294967088 ) {
            i = i + 3;
            isControlChar = YES;
        }
        if ( c == 4294967266 || c == 4294967267 ) {
            i = i + 2;
            isControlChar = YES;
        }
        if ( c == 4294967234 ) {
            i = i + 1;
            isControlChar = YES;
        }
        if ( !isControlChar ) {
            newUTF8[j] = utf8;
            j++;
        }
    }
    newUTF8[j] = '\0';
    NSString *encrypted = [NSString stringWithCString:(const char*)newUTF8
                                             encoding:NSUTF8StringEncoding];
    free( newUTF8 );
    return encrypted;
}

@end
