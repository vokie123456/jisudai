//
//  JCCWebViewController.h
//  JCC
//
//  Created by zhouyong on 15/6/12.
//  Copyright (c) 2015年 jucaicun. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "JCCBaseViewController.h"

@interface JCCBaseWebViewController : UIViewController
@property (nonatomic,strong)NSString *url;
@property (nonatomic,strong)NSString *webTitle;
@property (nonatomic,assign)BOOL showShare;//是否需要分享

@end
