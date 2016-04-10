//
//  UserViewController.m
//  jisudai
//
//  Created by haodai on 16/3/31.
//  Copyright © 2016年 xiaoya. All rights reserved.
//

#import "UserViewController.h"
#import "JCCBaseWebViewController.h"
#import "FeedBackViewController.h"
#import "AboutUsViewController.h"
#import "WXApi.h"
#import "JCCDefine.h"
#import "WXApiObject.h"

#define Target_iOS7   ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0f) ? YES : NO
#define mRateUrl      [NSString stringWithFormat:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@",@"1094308710"]
#define mRateUrl_iOS7 [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@",@"1094308710"]

@interface UserViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray *icons;
@end

@implementation UserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titles = [NSArray arrayWithObjects:@"征信查询",@"贷款计算器",@"分享",@"意见反馈",@"评分",@"关于我们", nil];
    self.icons = @[@"zhengxin",@"jisuanqi",@"fenxiang",@"yijian",@"score",@"aboutUs"];
    // Do any additional setup after loading the view.
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titles.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    ((UILabel*)[cell viewWithTag:101]).text = self.titles[indexPath.row];
    ((UIImageView*)[cell viewWithTag:100]).image = [UIImage imageNamed:[self.icons objectAtIndex:indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        JCCBaseWebViewController *web = [[JCCBaseWebViewController alloc] init];
        web.url = @"http://www.kuaicha.info/creditCB.action?appKey=e7cba276ade84d51b325e83fb810dae8&appName=jisudai&loginType=IDCARD_PASSWORD&callBackURL=http://www.51daikuan.org/index.php/Api/Index/up_credit";
        web.hidesBottomBarWhenPushed = YES;
        web.webTitle = @"征信查询";
        [self.navigationController pushViewController:web animated:YES];
    }else if(indexPath.row == 1) {
        JCCBaseWebViewController *web = [[JCCBaseWebViewController alloc] init];
        web.url = @"http://91jisudai.com/Mobile/jsq/city/beijing.html";
        web.hidesBottomBarWhenPushed = YES;
        web.webTitle = @"贷款计算器";
        [self.navigationController pushViewController:web animated:YES];
    }else if (indexPath.row == 2) {
        if ([WXApi isWXAppInstalled]) {
            UIAlertView *alertView = [[UIAlertView alloc] init];
            [alertView addButtonWithTitle:@"微信好友"];
            [alertView addButtonWithTitle:@"朋友圈"];
            [alertView addButtonWithTitle:@"取消"];
            alertView.delegate = self;
            [alertView show];
        }
    }else if(indexPath.row == 3) {
        FeedBackViewController *feedback = StoryBoardDefined(@"FeedBackViewController");
        feedback.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:feedback animated:YES];
    }else if(indexPath.row == 4) {
        NSURL *iTunesURL = [NSURL URLWithString:mRateUrl];
        if (Target_iOS7) {
            iTunesURL = [NSURL URLWithString:mRateUrl_iOS7];
        }
        [[UIApplication sharedApplication] openURL:iTunesURL];
    }else if(indexPath.row == 5) {
        AboutUsViewController *us = StoryBoardDefined(@"AboutUsViewController");
        us.hidesBottomBarWhenPushed = YES;
        us.title = @"关于我们";
        [self.navigationController pushViewController:us animated:YES];

    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        
        WXWebpageObject *ext = [WXWebpageObject object];
        ext.webpageUrl = @"http://interface.api.haodai.com/h5tuiguang/aff?ref=hd_11010999&sid=www.91jisudai.com&showhead=0";
        
        WXMediaMessage *message = [WXMediaMessage message];
        message.title = @"极速贷款，在线预约信用卡营销员";
        message.description = @"我找到一个可以快速申请贷款和信用卡的工具,赶快戳进来吧";
        message.mediaObject = ext;
        [message setThumbImage:[UIImage imageNamed:@"logo"]];
        
        SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
        req.message = message;
        req.scene = 0;
        [WXApi sendReq:req];
        
    }else if(buttonIndex == 1) {
    
        WXWebpageObject *ext = [WXWebpageObject object];
        ext.webpageUrl = @"http://interface.api.haodai.com/h5tuiguang/aff?ref=hd_11010999&sid=www.91jisudai.com&showhead=0";
        
        WXMediaMessage *message = [WXMediaMessage message];
        message.title = @"极速贷款，在线预约信用卡营销员";
        message.description = @"我找到一个可以快速申请贷款和信用卡的工具,赶快戳进来吧";
        message.mediaObject = ext;
        [message setThumbImage:[UIImage imageNamed:@"logo"]];
        
        SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
        req.message = message;
        req.scene = 1;
        
        [WXApi sendReq:req];

    }
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
