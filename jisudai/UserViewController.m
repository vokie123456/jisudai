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
#import "CreditManagerViewController.h"
#import "MobClick.h"

#define Target_iOS7   ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0f) ? YES : NO

@interface UserViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray *icons;

@end

@implementation UserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorColor = [UIColor colorWithRed:224.f/255.f green:224.f/255.f blue:224.f/255.f alpha:1.0];
    self.titles = [NSArray arrayWithObjects:@"办卡进度",@"征信查询",@"贷款计算器",@"分享给好友",@"意见反馈",@"给个好评",@"关于我们", nil];
    self.icons = @[@"bankaProgress",@"zhengxin",@"jisuanqi",@"fenxiang",@"yijian",@"score",@"aboutUs"];
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
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    ((UILabel*)[cell viewWithTag:101]).text = self.titles[indexPath.row];
    ((UIImageView*)[cell viewWithTag:100]).image = [UIImage imageNamed:[self.icons objectAtIndex:indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 15.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        CreditManagerViewController *credit = [[CreditManagerViewController alloc] init];
        credit.url = BanKaProgress;
        credit.title = @"办卡进度";
        credit.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:credit animated:YES];
    }else if (indexPath.row == 1) {
        [MobClick event:@"zhengXingLook"];
        JCCBaseWebViewController *web = [[JCCBaseWebViewController alloc] init];
        web.url = ZhengXinURL;
        web.hidesBottomBarWhenPushed = YES;
        web.webTitle = @"征信查询";
        [self.navigationController pushViewController:web animated:YES];
    }else if(indexPath.row == 2) {
        [MobClick event:@"jsq"];
        CreditManagerViewController *web = [[CreditManagerViewController alloc] init];
        web.url = DaiKuanJSQURL;
        web.hidesBottomBarWhenPushed = YES;
        web.title = @"贷款计算器";
        [self.navigationController pushViewController:web animated:YES];
    }else if (indexPath.row == 3) {
        if ([WXApi isWXAppInstalled]) {
            UIAlertView *alertView = [[UIAlertView alloc] init];
            [alertView addButtonWithTitle:@"微信好友"];
            [alertView addButtonWithTitle:@"朋友圈"];
            [alertView addButtonWithTitle:@"取消"];
            alertView.delegate = self;
            [alertView show];
        }
    }else if(indexPath.row == 4) {
        [MobClick event:@"yijian"];
        FeedBackViewController *feedback = StoryBoardDefined(@"FeedBackViewController");
        feedback.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:feedback animated:YES];
    }else if(indexPath.row == 5) {
        [MobClick event:@"pingfen"];
        NSURL *iTunesURL = [NSURL URLWithString:mRateUrl];
        if (Target_iOS7) {
            iTunesURL = [NSURL URLWithString:mRateUrl_iOS7];
        }
        [[UIApplication sharedApplication] openURL:iTunesURL];
    }else if(indexPath.row == 6) {
        [MobClick event:@"aboutUs"];
        AboutUsViewController *us = StoryBoardDefined(@"AboutUsViewController");
        us.hidesBottomBarWhenPushed = YES;
        us.title = @"关于我们";
        [self.navigationController pushViewController:us animated:YES];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [MobClick event:@"shareFriend"];
        WXWebpageObject *ext = [WXWebpageObject object];
        ext.webpageUrl = APPDownAddress;
        WXMediaMessage *message = [WXMediaMessage message];
        message.title = @"极速贷款,在线预约信用卡营销员";
        message.description = @"我找到一个可以快速申请贷款和信用卡的工具,赶快戳进来吧";
        message.mediaObject = ext;
        [message setThumbImage:[UIImage imageNamed:@"logo"]];
        
        SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
        req.message = message;
        req.scene = 0;
        [WXApi sendReq:req];
    }else if(buttonIndex == 1) {
       [MobClick event:@"shareFriendCicle"];
        WXWebpageObject *ext = [WXWebpageObject object];
        ext.webpageUrl = APPDownAddress;
        WXMediaMessage *message = [WXMediaMessage message];
        message.title = @"极速贷款,在线预约信用卡营销员";
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
