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

@end

@implementation JCCBaseWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//  那
    self.view.backgroundColor = [UIColor whiteColor];
    
    MKWebView *webView = [[MKWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 5) url:_url type:@""];
    webView.delegate = self;
    [self.view addSubview:webView];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)webLinkTouch:(NSString *)url {
    JCCBaseWebViewController *web = [[JCCBaseWebViewController alloc] init];
    web.url = url;
    web.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:web animated:YES];
}

- (void)webBack {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)webHome {
    [self.navigationController popToRootViewControllerAnimated:YES];
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
