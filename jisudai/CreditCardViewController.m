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

@end

@implementation CreditCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //  那
    self.view.backgroundColor = [UIColor whiteColor];
    
    MKWebView *webView = [[MKWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 49) url:@"http://www.91jisudai.com/Mobile/creditcard/" type:@"1"];
    webView.delegate = self;
    [self.view addSubview:webView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)MKWebViewFinishContentHeight:(CGFloat)h {
    
}

- (void)webLinkTouch:(NSString*)url {
    JCCBaseWebViewController *web = [[JCCBaseWebViewController alloc] init];
    web.url = url;
    web.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:web animated:YES];
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
