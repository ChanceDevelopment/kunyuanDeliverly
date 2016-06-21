//
//  UIImageUploader.m
//  何栋明
//
//  Created by Tony on 15/12/15.
//  Copyright © 2015年 iMac. All rights reserved.
//

#import "UIImageUploader.h"
#import "AFHTTPRequestOperationManager.h"


@implementation UIImageUploader
@synthesize uploadQueue;
@synthesize qn_upManager;

+ (id)sharedInstance
{
    static UIImageUploader *sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        sharedInstance = [[self alloc] init];
        sharedInstance.qn_upManager = [[QNUploadManager alloc] init];
    });
    return sharedInstance;
}

//保存还没有上传的图片在本地
- (void)save_unUploadImage:(NSDictionary *)imageDict savePath:(NSString *)filename
{
    NSString *unUploadPath = [Tool getUn_UploadPath];
    NSString *savePath = [unUploadPath stringByAppendingPathComponent:filename];
    BOOL succeed = [imageDict writeToFile:savePath atomically:YES];
    if (succeed) {
        NSLog(@"save succeed");
    }
    else{
        NSLog(@"save faild");
    }
}

//上传还没有上传的图片
- (void)upload_unFinishImage
{
    NSString *unUploadPath = [Tool getUn_UploadPath];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"filelist" ofType:@"plist"];
    NSArray *filePathArray = [[NSArray alloc] initWithContentsOfFile:filePath];
    
    for (NSInteger index = 0; index < [filePathArray count]; index++) {
        //相对路径
        NSString *relativeFilePath = filePathArray[index];
        //绝对路径
        NSString *absoluteFilePath = [unUploadPath stringByAppendingPathComponent:relativeFilePath];
        NSDictionary *uploadDict = [[NSDictionary alloc] initWithContentsOfFile:absoluteFilePath];
        [self qn_uploadImageToserverWithImageDict:uploadDict];
    }
}

//上传图片到自己的图片服务器
- (void)localServer_uploadImageToserverWithImageDict:(NSDictionary *)imageDict
{
    NSString *uploadUrl = nil;
    NSDictionary *params = nil;
    NSData *woodImgData = nil;
    NSString *fileName = nil;
    NSString *typeStr = @"image/png";
    NSString *serverReceiveKey = @"image";
    AFHTTPRequestOperationManager *client = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:BASEURL]];
    [client POST:uploadUrl parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        /*
         32          此方法参数
         33          1. 要上传的[二进制数据]
         34          2. 对应网站上[upload.php中]处理文件的[字段"file1"]
         35          3. 要保存在服务器上的[文件名]
         36          4. 上传文件的[mimeType]
         */
        [formData appendPartWithFileData:woodImgData name:serverReceiveKey fileName:fileName mimeType:typeStr];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //            [self hideHud];
        NSString *responseString = operation.responseString;
        NSDictionary *respondDict = [responseString objectFromJSONString];
        NSInteger statueCode = [[respondDict objectForKey:@"code"] integerValue];
        if (statueCode == REQUESTCODE_SUCCEED) {
            
            return;
        }
        else{
            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

//上传图片到七牛
- (void)qn_uploadImageToserverWithImageDict:(NSDictionary *)imageDict
{
    NSData *imageData = nil;
    NSString *uploadKey = nil;
    NSString *uploadToken = nil;
    [self uploadImage:imageData key:uploadKey token:uploadToken filename:nil typeId:nil];
}

//上传单张图片到七牛
//@typeID 相册的ID
//@imageData 图片数据
//@uploadKey 上传的key
//@token 上传的token，服务器获取
//@filename 图片的文件名字
- (void)uploadImage:(NSData *)imageData key:(NSString *)uploadKey token:(NSString *)token filename:(NSString *)filename typeId:(NSString *)typeID{
    
    QNUploadOption *uploadOption = [[QNUploadOption alloc] initWithMime:@"image/png" progressHandler:^(NSString *key, float percent) {
        NSLog(@"percent == %.2f", percent);
        
    }
                                                                 params:nil
                                                               checkCrc:NO
                                                     cancellationSignal:nil];
   

    [self.qn_upManager putData:imageData key:uploadKey token:token complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
        NSLog(@"key = %@,resp = %@",key,resp);
        if (filename) {
            [self uploadPhotoToQNWithFileName:filename link:uploadKey typeId:typeID];
        }
        else{
            //图片上传成功，发出通知
            [[NSNotificationCenter defaultCenter] postNotificationName:UPLOADIMAGESUCCEED_NOTIFICATION object:self];
        }
        
    }
                option:uploadOption];
}

//上传照片到七牛 UPLOAD_PHOTO_CLOUND
//typeId：相册的ID
- (void)uploadPhotoToQNWithFileName:(NSString *)fileName link:(NSString *)link typeId:(NSString *)typeId
{
    NSString *uploadPath = [NSString stringWithFormat:@"%@%@",BASEURL,UPLOAD_PHOTO_CLOUND];
    if (typeId == nil) {
        typeId = @"";
    }
    if (typeId == nil) {
        typeId = @"";
    }
    NSString *t_token = [HeSysbsModel getSysModel].user.usertoken;
    NSDictionary *uploadParams = @{@"typeId":typeId,@"fileName":fileName,@"uploadtext":@"",@"link":link,@"t_token":t_token};
    [AFHttpTool requestWihtMethod:RequestMethodTypePost url:uploadPath params:uploadParams success:^(AFHTTPRequestOperation* operation,id response){
        
        NSString *respondString = [[NSString alloc] initWithData:operation.responseData encoding:NSUTF8StringEncoding];
        NSDictionary *respondDict = [respondString objectFromJSONString];
        NSString *result = [respondDict objectForKey:@"result"];
        if ([result isEqualToString:@"success"]) {
            //图片上传成功，发出通知
            [[NSNotificationCenter defaultCenter] postNotificationName:UPLOADIMAGESUCCEED_NOTIFICATION object:self];
        }
        else{
            
        }
    } failure:^(NSError *error){
        
    }];
}

- (void)uploadImageWithImageArray:(NSArray *)imageArray upLoadUrl:(NSString *)uploadURL newsReceiver:(id<ReceiveProtocol>)receiver
{
    for (int i = 0; i < [imageArray count]; i++) {
        UIImage *image = [imageArray objectAtIndex:i];
        NSData *woodImgData = UIImagePNGRepresentation(image);
        NSString *typeStr = @"image/png";
        
        NSDate *senddate=[NSDate date];
        NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
        [dateformatter setDateFormat:@"YYYYMMddhhmmss"];
        NSString *timeStr   = [dateformatter stringFromDate:senddate];
        NSString *imageStr = [NSString stringWithFormat:@"%@sell_headImage.png",timeStr];
        NSArray *array = [imageStr componentsSeparatedByString:@":"];
        NSMutableString *mutableString = [[NSMutableString alloc] initWithCapacity:0];
        for (NSString *str in array) {
            [mutableString appendString:str];
        }
        [self uploadOneFileData:woodImgData imgType:typeStr imgName:mutableString upLoadUrl:uploadURL newsReceiver:receiver];
    }
}
//提交上传
-(void)uploadOneFileData:(NSData *)woodImgData imgType:(NSString*)typeStr imgName:(NSString *)fileName upLoadUrl:uploadURL  newsReceiver:(id<ReceiveProtocol>)receiver{
    if (woodImgData) {
        //上传图片文件
        
        AFHTTPRequestOperationManager *client = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:BASEURL]];
        [client POST:uploadURL parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
            
            /*
             32          此方法参数
             33          1. 要上传的[二进制数据]
             34          2. 对应网站上[upload.php中]处理文件的[字段"file1"]
             35          3. 要保存在服务器上的[文件名]
             36          4. 上传文件的[mimeType]
             */
            [formData appendPartWithFileData:woodImgData name:@"pic" fileName:fileName mimeType:typeStr];
        } success:^(AFHTTPRequestOperation *operation, id responseObject) {
            //            [self hideHud];
            NSString *responseString = operation.responseString;
            NSString *fileName = responseString;
            if ([fileName isMemberOfClass:[NSNull class]] || fileName == nil) {
                //                [self showHint:@"上传头像失败"];
                [receiver uploadImageResult:NO imageAddress:nil];
            }
            else{
                [receiver uploadImageResult:YES imageAddress:responseString];
            }
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [receiver uploadImageResult:NO imageAddress:nil];
            //            [self hideHud];
            //            [self showHint:ERRORREQUESTTIP];
        }];
        
//        NSURLRequest *request = [client multipartFormRequestWithMethod:@"POST" path:uploadURL parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
//            
//            /*
//             32          此方法参数
//             33          1. 要上传的[二进制数据]
//             34          2. 对应网站上[upload.php中]处理文件的[字段"file1"]
//             35          3. 要保存在服务器上的[文件名]
//             36          4. 上传文件的[mimeType]
//             */
//            [formData appendPartWithFileData:woodImgData name:@"pic" fileName:fileName mimeType:typeStr];
//        }];
//        // 3. operation包装的urlconnetion
//        AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
//        [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
////            [self hideHud];
//            NSString *responseString = operation.responseString;
//            NSString *fileName = responseString;
//            if ([fileName isMemberOfClass:[NSNull class]] || fileName == nil) {
////                [self showHint:@"上传头像失败"];
//                [receiver uploadImageResult:NO imageAddress:nil];
//            }
//            else{
//                [receiver uploadImageResult:YES imageAddress:responseString];
//            }
//        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//            [receiver uploadImageResult:NO imageAddress:nil];
////            [self hideHud];
////            [self showHint:ERRORREQUESTTIP];
//        }];
//        [client.operationQueue addOperation:op];
    }
}

@end
