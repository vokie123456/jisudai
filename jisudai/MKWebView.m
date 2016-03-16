//
//  MKWebView.m
//  ZJT
//
//  Created by wangcy on 14-8-12.
//  Copyright (c) 2014年 zjt. All rights reserved.
//

#import "MKWebView.h"

#define KTagActivitity 6666


@implementation MKWebView
@synthesize webView = _webView;

- (id)initWithFrame:(CGRect)frame url:(NSString*)html type:(NSString *)type
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _webView = [[UIWebView alloc] initWithFrame:self.bounds];
        _webView.scrollView.showsHorizontalScrollIndicator = NO;
        _webView.scrollView.showsVerticalScrollIndicator = NO;
        _webView.delegate = self;
        _webView.scrollView.bounces = NO;
        _webView.scalesPageToFit = YES;
        [self addSubview:_webView];
        
        if ([type integerValue] == 1) {
            UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
            back.frame = CGRectMake(0, 0, 100, 44);
            back.backgroundColor = [UIColor clearColor];
            [_webView.scrollView addSubview:back];
        }else {
            UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
            back.frame = CGRectMake(0, 0, 80, 44);
            [back addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
            [_webView.scrollView addSubview:back];
        }
        
       
        
        //这里传来的数据有可能是网址
        if ([type isEqualToString:@"string"]) {
                if (html && ![html isEqualToString:@""]) {
                    [_webView loadHTMLString:html baseURL:nil];
                }
        }else {
                if (html && ![html isEqualToString:@""]) {
                    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:html]]];
                }
        }
    }
    return self;
}

- (void)setScroll:(BOOL)scroll {
    _scroll = scroll;
    if (scroll) {
        _webView.scrollView.scrollEnabled = YES;
    }else {
        _webView.scrollView.scrollEnabled = NO;
    }
}

- (void)setUrl:(NSString *)url {
    _url = url;
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_url]]];
}

#pragma mark -
#pragma mark - UIWebViewDelegate
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [[webView viewWithTag:KTagActivitity] removeFromSuperview];
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"加载失败请检查您的网络连接" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    UIActivityIndicatorView *_activity = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    _activity.center = webView.center;
    _activity.tag = KTagActivitity;
    _activity.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    [webView addSubview:_activity];
    [_activity startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSString *height_str= [webView stringByEvaluatingJavaScriptFromString: @"document.body.scrollHeight"];
    CGFloat height = [height_str floatValue];

    NSLog(@"height: %@//%f", [webView stringByEvaluatingJavaScriptFromString: @"document.body.scrollHeight"],webView.scrollView.contentSize.height);
    if ([self.delegate respondsToSelector:@selector(MKWebViewFinishContentHeight:)]) {
        [self.delegate MKWebViewFinishContentHeight:height];
    }
    [[webView viewWithTag:KTagActivitity] removeFromSuperview];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSURL *requestURL =[request URL];
    NSLog(@"--%@--scheme:%@",[[requestURL relativeString] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[requestURL scheme]);
    if (([[requestURL scheme] isEqualToString:@"http"] || [[requestURL scheme] isEqualToString:@"https"] || [[requestURL scheme] isEqualToString: @"mailto" ])
        && (navigationType == UIWebViewNavigationTypeLinkClicked)) {
       
        if ([[requestURL absoluteString] hasPrefix:@"http://www.91jisudai.com/Mobile/index"]) {
            if ([self.delegate respondsToSelector:@selector(webHome)]) {
                [self.delegate webHome];
            }
            return NO;
        }else {
            if ([self.delegate respondsToSelector:@selector(webLinkTouch:)]) {
                [self.delegate webLinkTouch:requestURL.absoluteString];
                return NO;
            }
        }
        return YES;
    }
    return YES;
}

- (void)back {
    if ([self.delegate respondsToSelector:@selector(webBack)]) {
        [self.delegate webBack];
    }
}

- (void)dealloc {
    _webView.delegate = nil;
    [_webView loadHTMLString:@"" baseURL:nil];
    [_webView stopLoading];
    [_webView removeFromSuperview];
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
    
@end

