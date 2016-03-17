//
//  CreditMessageViewController.m
//  jisudai
//
//  Created by haodai on 16/3/17.
//  Copyright © 2016年 xiaoya. All rights reserved.
//

#import "CreditMessageViewController.h"
#import "MKWebView.h"
#import "JCCBaseWebViewController.h"

@interface CreditMessageViewController ()<MKWebViewDelegate>
@property (nonatomic, strong) MKWebView *webView;
@property (nonatomic, assign) BOOL loadFail;
@end

@implementation CreditMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _loadFail = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    _webView = [[MKWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 49) url:@"http://www.91jisudai.com/Mobile/newslist/" type:@"1"];
    _webView.delegate = self;
    [self.view addSubview:_webView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)webLoadFail {
    _loadFail = YES;
}

- (void)MKWebViewFinishContentHeight:(CGFloat)h {
    _loadFail = NO;
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    if (_webView && _loadFail) {
//         NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.91jisudai.com/Mobile/newslist/"] cachePolicy:NSURLRequestReloadRevalidatingCacheData timeoutInterval:60];
        [_webView.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.91jisudai.com/Mobile/newslist/"]]];
    }
}



- (void)webLinkTouch:(NSString*)url {
    JCCBaseWebViewController *web = [[JCCBaseWebViewController alloc] init];
    web.url = url;
    web.isSelectedCity = self.webView.isSelectedCity;
    web.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:web animated:YES];
}

- (void)webHome {
    self.tabBarController.selectedIndex = 0;
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
