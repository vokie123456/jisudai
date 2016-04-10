//
//  MKWebView.m
//  ZJT
//
//  Created by wangcy on 14-8-12.
//  Copyright (c) 2014年 zjt. All rights reserved.
//

#import "MKWebView.h"
#import "UIColor+Extend.h"
#import "KLReachabilityManager.h"

#define KTagActivitity 6666
@interface MKWebView ()
@property (nonatomic, strong) UIButton *back;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, strong) UIView *mast;

@end

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
        
         _type = [type integerValue];
        
        if (![html hasPrefix:@"http://www.91jisudai.com/Mobile/index"] && ![html hasPrefix:@"http://www.91jisudai.com/Mobile/creditcard"]) {
            if ([html hasPrefix:@"http://www.91jisudai.com/Mobile/creditredirect"]) {
                if ([html rangeOfString:@"bank_id/15"].length || [html rangeOfString:@"bank_id/1"].length ||[html rangeOfString:@"bank_id/43"].length || [html rangeOfString:@"bank_id/8"].length) {
                    UILabel *nav = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 44)];
                    nav.backgroundColor = [UIColor colorWithHexColorString:@"00d0df"];
                    nav.textAlignment = NSTextAlignmentCenter;
                    nav.textColor = [UIColor whiteColor];
                    nav.font = [UIFont systemFontOfSize:18];
                    [_webView.scrollView addSubview:nav];
                    if ([html rangeOfString:@"bank_id/15"].length ) {
                        nav.text = @"平安银行";
                        nav.frame = CGRectMake(0, 0, self.frame.size.width, 54);
                    }else if ([html rangeOfString:@"bank_id/1"].length) {
                        nav.text = @"招商银行";
                    }else if([html rangeOfString:@"bank_id/43"].length) {
                        nav.text = @"花旗银行";
                    }else if ([html rangeOfString:@"bank_id/8"].length) {
                        nav.text = @"浦发银行";
                    }
                }
            }
            _mast = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width - 80, 0, 80, 44)];
            _mast.backgroundColor = [UIColor colorWithHexColorString:@"00d0df"];
            _mast.hidden = YES;
            [_webView.scrollView addSubview:_mast];
        }

        
        if (![html hasPrefix:@"http://www.91jisudai.com/"]) {
            UILabel *nav = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 44)];
            nav.backgroundColor = [UIColor colorWithHexColorString:@"00d0df"];
            [_webView.scrollView addSubview:nav];
            if ([html hasPrefix:@"http://www.kuaicha.info"]) {
                nav.text = @"征信查询";
            }else if([html hasPrefix:@"http://interface.api.haodai.com"]){
                nav.text = @"申请贷款";
            }else if([html hasPrefix:@"http://91jisudai.com/Mobile/jsq"]) {
                nav.text = @"贷款计算器";
            }else {
                nav.text = @"申请信用卡";
                nav.frame = CGRectMake(0, 0, self.frame.size.width, 44);
            }
            nav.textAlignment = NSTextAlignmentCenter;
            nav.textColor = [UIColor whiteColor];
            nav.font = [UIFont systemFontOfSize:18];
        }
        
        
       
        if (_type == 2) {
            
        }else if (_type == 1) {
            _back = [UIButton buttonWithType:UIButtonTypeCustom];
            _back.frame = CGRectMake(0, 0, 100, 44);
            _back.backgroundColor = [UIColor colorWithHexColorString:@"00d0df"];
            _back.hidden = YES;
            [_webView.scrollView addSubview:_back];
        }else {
            _back = [UIButton buttonWithType:UIButtonTypeCustom];
            _back.frame = CGRectMake(0, 0, 44, 44);
            [_back setImage:[UIImage imageNamed:@"back1"] forState:0];
            _back.layer.masksToBounds = YES;
            _back.layer.cornerRadius = 5;
            _back.hidden = YES;
            [_back addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
            [_webView.scrollView addSubview:_back];
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
    if ([self.delegate respondsToSelector:@selector(webLoadFail)]) {
        [self.delegate webLoadFail];
    }
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
    _back.hidden = NO;
    _mast.hidden = NO;
     [webView stringByEvaluatingJavaScriptFromString:@"document.body.mat_top='';"];
    
    [webView stringByEvaluatingJavaScriptFromString:@"document.body.style.webkitTouchCallout='none';"];
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitUserSelect='none';"];
    // Disable callout
    [webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.style.webkitTouchCallout='none';"];
//    NSString *height_str= [webView stringByEvaluatingJavaScriptFromString: @"document.body.scrollHeight"];
//    CGFloat height = [height_str floatValue];
//
//    NSLog(@"height: %@//%f", [webView stringByEvaluatingJavaScriptFromString: @"document.body.scrollHeight"],webView.scrollView.contentSize.height);
//    if ([self.delegate respondsToSelector:@selector(MKWebViewFinishContentHeight:)]) {
//        [self.delegate MKWebViewFinishContentHeight:height];
//    }
    [[webView viewWithTag:KTagActivitity] removeFromSuperview];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSURL *requestURL =[request URL];
    NSLog(@"--%@--scheme:%@",[[requestURL relativeString] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding],[requestURL scheme]);
    if (([[requestURL scheme] isEqualToString:@"http"] || [[requestURL scheme] isEqualToString:@"https"] || [[requestURL scheme] isEqualToString: @"mailto" ])
        && (navigationType == UIWebViewNavigationTypeLinkClicked)) {
        
        KLReachabilityStatus stat = [KLReachabilityManager netWorkReachable];
        if (stat == KLReachabilityStatusUnknown || stat == KLReachabilityStatusNotReachable) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"您的网络不好" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            return NO;
        }

        NSString *url = [requestURL absoluteString];
        if ([url hasPrefix:@"http://www.91jisudai.com/Mobile/fastapply/"]) {
            url = @"http://interface.api.haodai.com/h5tuiguang/aff?ref=hd_11010999&sid=www.91jisudai.com&showhead=0";
        }
        if (_isSelectedCity) {
            if ([url hasPrefix:@"http://www.91jisudai.com/Mobile/index"] && [self.delegate  respondsToSelector:@selector(webHome:)]) {
                [self.delegate webHome:url];
                [self isSelectedCity:url];
                return NO;
            }else if([url hasPrefix:@"http://www.91jisudai.com/Mobile/creditcard"] && [self.delegate  respondsToSelector:@selector(webCredit:)]) {
                [self.delegate webCredit:url];
                [self isSelectedCity:url];
                return NO;
            }
        }else {
            [self isSelectedCity:url];
            if ([self.delegate respondsToSelector:@selector(webLinkTouch:)])
            {
                [self.delegate webLinkTouch:url];
                return NO;
            }
        }
        return YES;
    }
    return YES;
}

- (void)isSelectedCity:(NSString*)requestURL {
    if ([requestURL hasPrefix:@"http://www.91jisudai.com/Mobile/changecity/"]) {
        _isSelectedCity = YES;
    }else {
        _isSelectedCity = NO;
    }
}

- (void)back:(id)sender {
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


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex NS_DEPRECATED_IOS(2_0, 9_0) {
    if([self.delegate respondsToSelector:@selector(webLoadFail)]) {
        [self.delegate webLoadFail];
    }
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

