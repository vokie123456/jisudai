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
@property (nonatomic, strong)  MKWebView *webView;
@end

@implementation DaikuanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //  那
    self.view.backgroundColor = [UIColor whiteColor];
    
   _webView = [[MKWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 49) url:@"http://www.91jisudai.com/Mobile/fastapply/" type:@"1"];
    _webView.delegate = self;
    _webView.webView.scrollView.scrollEnabled = NO;
    [self.view addSubview:_webView];
    // Do any additional setup after loading the view.
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)MKWebViewFinishContentHeight:(CGFloat)h {

}

- (void)webLinkTouch:(NSString*)url {
    JCCBaseWebViewController *web = [[JCCBaseWebViewController alloc] init];
    web.url = url;
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
