//
//  JCCWebViewController.m
//  JCC
//
//  Created by zhouyong on 15/6/12.
//  Copyright (c) 2015年 jucaicun. All rights reserved.
//

#import "JCCBaseWebViewController.h"
#import "MKWebView.h"

@interface JCCBaseWebViewController ()<MKWebViewDelegate>
@property (nonatomic, strong) MKWebView *webView;
@end

@implementation JCCBaseWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//  那
    self.view.backgroundColor = [UIColor whiteColor];
    
    _webView = [[MKWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 5) url:_url type:@""];
    _webView.isSelectedCity = self.isSelectedCity;
    _webView.delegate = self;
    [self.view addSubview:_webView];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)webLinkTouch:(NSString *)url {
    JCCBaseWebViewController *web = [[JCCBaseWebViewController alloc] init];
    web.url = url;
    web.isSelectedCity = self.webView.isSelectedCity;
    web.hidesBottomBarWhenPushed = YES;
    __weak __typeof(self) weak = self;
    web.webHome = ^(NSString*url) {
        __strong __typeof(self) strongSelf = weak;
        strongSelf.webView.isSelectedCity = NO;
        [strongSelf.webView.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    };
    web.webCredit = ^(NSString*url) {
        __strong __typeof(self) strongSelf = weak;
        strongSelf.webView.isSelectedCity = NO;
        [strongSelf.webView.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    };
    web.back = ^(){
        __strong __typeof(self) strongSelf = weak;
        strongSelf.webView.isSelectedCity = NO;
    };
    [self.navigationController pushViewController:web animated:YES];
}

- (void)webBack {
    _isSelectedCity = NO;
    if (self.back) {
        self.back();
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)webHome:(NSString *)url {
    if (self.webHome) {
        self.webHome(url);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)webCredit:(NSString *)url {
    if (self.webCredit) {
        self.webCredit(url);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)webLoadFail {
    
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
