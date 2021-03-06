//
//  HTTPRequestManager.m
//  hunchelaila
//
//  Created by zhouyong on 15-3-17.
//  Copyright (c) 2015年 百万新娘(北京)科技有限公司. All rights reserved.
//

#import "HTTPRequestManager.h"
#import "MBProgressHUD.h"
#import <BmobSDK/BmobQuery.h>
NSString *const HTTPServerError = @"服务器错误";
NSString *const HTTPConnectionError = @"网络连接失败";

@implementation HTTPRequestManager

+ (instancetype)manager {
    return [[self class] new];
}

- (void)POST:(NSString*)appendString
  dictionary:(NSDictionary*)parameters
        page:(NSInteger)page
     success:(void (^)(id responseObject))success
     failure:(void (^)(NSError *error))failure
        view:(UIView*)view
    progress:(BOOL)p {
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
    [view addSubview:hud];
    if (p) {
        [hud show:YES];
    }
    hud.removeFromSuperViewOnHide = YES;
    BmobQuery *bquery = [BmobQuery queryWithClassName:appendString];
    if (parameters.allKeys.count > 0) {
        [bquery whereKey:parameters.allKeys.firstObject equalTo:[parameters objectForKey:parameters.allKeys.firstObject]];
    }
    [bquery orderByDescending:@"updatedAt"];
    bquery.limit = 10;
    bquery.skip = bquery.limit * (page - 1);
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        if (error) {
            hud.mode = MBProgressHUDModeText;
            hud.labelText = HTTPServerError;
            [hud hide:YES afterDelay:1];
            if (failure) {
                failure(error);
            }
        }else {
            [hud hide:YES];
            if (array.count != 0) {
                if (success) {
                    success(array);
                }
            }
        }
    }];
}


@end
