//
//  CreditCardViewController.m
//  jisudai
//
//  Created by haodai on 16/3/14.
//  Copyright © 2016年 xiaoya. All rights reserved.
//

#import "CreditCardViewController.h"
#import "MKWebView.h"
#import "JCCBaseWebViewController.h"
@interface CreditCardViewController ()<MKWebViewDelegate>
@property (nonatomic, strong) MKWebView *webView;
@property (nonatomic, assign) BOOL loadFail;
@end

@implementation CreditCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //  那
    _loadFail = NO;
    self.view.backgroundColor = [UIColor whiteColor];
     
    _webView = [[MKWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 49) url:Rong360Credit type:@"1"];
    _webView.delegate = self;
    [self.view addSubview:_webView];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    if (_webView && _loadFail) {
        [_webView.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:Rong360Credit]]];
    }
}

- (void)webLoadFail {
    _loadFail = YES;
}

- (void)MKWebViewFinishContentHeight:(CGFloat)h {
    _loadFail = NO;
}

- (void)webLinkTouch:(NSString*)url {
    JCCBaseWebViewController *web = [[JCCBaseWebViewController alloc] init];
    web.url = url;
    web.isSelectedCity = self.webView.isSelectedCity;
    web.hidesBottomBarWhenPushed = YES;
    __weak __typeof(self) weak = self;
    web.webCredit = ^(NSString*url) {
        __strong __typeof(self) strongSelf = weak;
        strongSelf.webView.isSelectedCity = NO;
        [strongSelf.webView.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
        strongSelf.tabBarController.selectedIndex = 2;
    };
    web.back = ^ () {
        __strong __typeof(self) strongSelf = weak;
        strongSelf.webView.isSelectedCity = NO;
    };
    [self.navigationController pushViewController:web animated:YES];
}

- (BOOL)prefersStatusBarHidden
{
    // iOS7后,[[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
    // 已经不起作用了
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
