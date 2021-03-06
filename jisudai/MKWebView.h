//
//  MKWebView.h
//  ZJT
//
//  Created by wangcy on 14-8-12.
//  Copyright (c) 2014年 zjt. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MKWebView;
@protocol MKWebViewDelegate <NSObject>
@optional
- (void)MKWebViewFinishContentHeight:(CGFloat)h;
- (void)webLoadFail;
- (void)webLinkTouch:(NSString*)url;
- (void)webBack;
- (void)webHome:(NSString*)url;
- (void)webCredit:(NSString*)url;

@end

@interface MKWebView : UIView <UIWebViewDelegate>
@property(nonatomic,strong)UIWebView *webView;
@property(nonatomic,weak)id <MKWebViewDelegate> delegate;
@property(nonatomic,assign)BOOL scroll;
@property(nonatomic,strong)NSString *url;
@property (nonatomic, assign) BOOL isSelectedCity;

- (id)initWithFrame:(CGRect)frame url:(NSString*)html type:(NSString *)type;

@end
