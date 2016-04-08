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

#import "JCCDefine.h"

#define Target_iOS7   ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0f) ? YES : NO
#define mRateUrl      [NSString stringWithFormat:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=%@",@"1094308710"]
#define mRateUrl_iOS7 [NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@",@"1094308710"]

@interface UserViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray *icons;
@end

@implementation UserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titles = [NSArray arrayWithObjects:@"征信查询",@"意见反馈",@"评分",@"关于我们", nil];
    self.icons = @[@"zhengxin",@"yijian",@"score",@"aboutUs"];
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
    cell.textLabel.text = self.titles[indexPath.row];
    cell.imageView.image = [UIImage imageNamed:[self.icons objectAtIndex:indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 64.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        JCCBaseWebViewController *web = [[JCCBaseWebViewController alloc] init];
        web.hidesBottomBarWhenPushed = YES;
        web.url = @"http://www.kuaicha.info/creditCB.action?appKey=e7cba276ade84d51b325e83fb810dae8&appName=jisudai&loginType=IDCARD_PASSWORD&callBackURL=http://www.51daikuan.org/index.php/Api/Index/up_credit";
        web.hidesBottomBarWhenPushed = YES;
        web.webTitle = @"征信查询";
        [self.navigationController pushViewController:web animated:YES];
    }else if (indexPath.row == 1) {
        FeedBackViewController *feedback = StoryBoardDefined(@"FeedBackViewController");
        feedback.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:feedback animated:YES];
    }else if(indexPath.row == 2) {
        NSURL *iTunesURL = [NSURL URLWithString:mRateUrl];
        if (Target_iOS7) {
            iTunesURL = [NSURL URLWithString:mRateUrl_iOS7];
        }
        [[UIApplication sharedApplication] openURL:iTunesURL];
    }else if(indexPath.row == 3) {
        AboutUsViewController *us = StoryBoardDefined(@"AboutUsViewController");
        us.hidesBottomBarWhenPushed = YES;
        us.title = @"关于我们";
        [self.navigationController pushViewController:us animated:YES];
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
