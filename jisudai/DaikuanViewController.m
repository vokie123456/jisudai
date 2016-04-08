//
//  DaikuanViewController.m
//  jisudai
//
//  Created by haodai on 16/3/14.
//  Copyright © 2016年 xiaoya. All rights reserved.
//

#import "DaikuanViewController.h"
#import "MKWebView.h"
#import "JCCBaseWebViewController.h"

@interface DaikuanViewController ()<MKWebViewDelegate>
@property (nonatomic, strong) MKWebView *webView;
@property (nonatomic, assign) BOOL loadFail;

@end

@implementation DaikuanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //  那
    _loadFail = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    _webView = [[MKWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 49) url:@"http://interface.api.haodai.com/h5tuiguang/aff?ref=hd_11010999&sid=www.91jisudai.com&showhead=0" type:@"1"];
    _webView.delegate = self;
    _webView.webView.scrollView.scrollEnabled = YES;
    [self.view addSubview:_webView];
    // Do any additional setup after loading the view.
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
    if (_webView && _loadFail) {
//      NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.91jisudai.com/Mobile/fastapply/"] cachePolicy:NSURLRequestReloadRevalidatingCacheData timeoutInterval:60];
        [_webView.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://interface.api.haodai.com/h5tuiguang/aff?ref=hd_11010999&sid=www.91jisudai.com&showhead=0"]]];
    }
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

- (void)webLinkTouch:(NSString*)url {
    JCCBaseWebViewController *web = [[JCCBaseWebViewController alloc] init];
    web.url = url;
    web.isSelectedCity = self.webView.isSelectedCity;
     web.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:web animated:YES];
}

- (void)webHome:(NSString *)url {
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
