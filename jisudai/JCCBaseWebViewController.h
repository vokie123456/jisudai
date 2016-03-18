//
//  JCCWebViewController.h
//  JCC
//
//  Created by zhouyong on 15/6/12.
//  Copyright (c) 2015年 jucaicun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MKWebView.h"

//#import "JCCBaseViewController.h"
typedef void (^BlockWebHome)(NSString*);
typedef void (^BlockWebCredit)(NSString*);
typedef void (^BlockBackHome)(void);

@interface JCCBaseWebViewController : UIViewController
@property (nonatomic,strong)NSString *url;
@property (nonatomic,strong)NSString *webTitle;
@property (nonatomic,assign)BOOL showShare;//是否需要分享
@property (nonatomic, copy) BlockWebHome webHome;
@property (nonatomic, copy) BlockWebCredit webCredit;
@property (nonatomic, assign) BOOL isSelectedCity;
@property (nonatomic, copy) BlockBackHome back;

@end
