//
//  ShanYinViewController.m
//  jisudai
//
//  Created by haodai on 16/4/14.
//  Copyright © 2016年 xiaoya. All rights reserved.
//

#import "ShanYinViewController.h"

@interface ShanYinViewController ()<UIWebViewDelegate>
@property (nonatomic, strong) UIWebView *webView;
@end

@implementation ShanYinViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.hidesBottomBarWhenPushed = YES;
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 44)];
    _webView.scrollView.bounces = YES;
    _webView.delegate = self;
    [self.view addSubview:_webView];
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_url]]];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}


- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [[webView viewWithTag:3000] removeFromSuperview];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    UIActivityIndicatorView *_activity = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    _activity.center = webView.center;
    _activity.tag = 3000;
    _activity.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    [webView addSubview:_activity];
    [_activity startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSString *str = @"document.getElementsByClassName('mat_top')[0].remove();";
    [webView stringByEvaluatingJavaScriptFromString:str];
    [[webView viewWithTag:3000] removeFromSuperview];
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
    }
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
