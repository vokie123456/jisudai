//
//  MainViewController.m
//  jisudai
//
//  Created by haodai on 16/3/14.
//  Copyright © 2016年 xiaoya. All rights reserved.
//

#import "MainViewController.h"
#import "HomeTableViewCell.h"
#import "ImagePlayerView.h"
#import "HotCreditTableViewCell.h"
#import "HotLoanTableViewCell.h"
#import "JCCBaseWebViewController.h"
#import <BmobSDK/BmobQuery.h>
#import "CreditManagerViewController.h"
#import "MJRefresh.h"
#import "LoanDetailViewController.h"
@interface MainViewController ()<UITableViewDataSource,UITableViewDelegate,ImagePlayerViewDelegate>
@property (weak, nonatomic) IBOutlet ImagePlayerView *adImagePlayerView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *ads;
@property (nonatomic, strong) NSArray *topArray;
@property (nonatomic, strong) NSArray *hotLoanArray;
@property (nonatomic, strong) NSArray *hotCreditArray;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //  那
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.backgroundView = nil;
    self.tableView.showsHorizontalScrollIndicator = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.backgroundColor = BackgroundColor;
    self.tableView.separatorColor = LineColor;
    self.adImagePlayerView.width = SCREEN_WIDTH;
    if (mIsPad) {
        self.adImagePlayerView.height = 330.f;
    }
    self.ads = @[@"banner1",@"banner2",@"banner3"];
    self.topArray = @[@{@"icon":@"xedk",@"title":@"小额贷款",@"des":@"上班族学生",@"lable":@"秒批"},@{@"icon":@"dedk",@"title":@"大额贷款",@"des":@"企业房车贷",@"lable":@"推荐"},@{@"icon":@"xyk",@"title":@"信用卡",@"des":@"省心省力",@"lable":@""},@{@"icon":@"xindaijingli",@"title":@"信贷经理",@"des":@"入驻抢单",@"lable":@""}];
    [_adImagePlayerView initWithCount:3 delegate:self];

    [self updateData];
    
    WEAKSELF;
    self.tableView.mj_header =  [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        STRONGSELF;
        [strongSelf updateData];
    }];

    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}



- (void)updateData {
    [[HTTPRequestManager manager] POST:@"HotLLoan1" dictionary:@{} page:1 success:^(id responseObject) {
        self.hotLoanArray = responseObject;
        [self.tableView reloadData];
        if ([self.tableView.mj_header isRefreshing]) {
            [self.tableView.mj_header endRefreshing];
        }
    } failure:^(NSError *error) {
        if ([self.tableView.mj_header isRefreshing]) {
            [self.tableView.mj_header endRefreshing];
        }
    } view:self.view progress:YES];
    
    [[HTTPRequestManager manager] POST:@"HotCredit" dictionary:@{} page:1 success:^(id responseObject) {
        self.hotCreditArray = responseObject;
        [self.tableView reloadData];
        if ([self.tableView.mj_header isRefreshing]) {
            [self.tableView.mj_header endRefreshing];
        }
    } failure:^(NSError *error) {
        if ([self.tableView.mj_header isRefreshing]) {
            [self.tableView.mj_header endRefreshing];
        }
    } view:self.view progress:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else if(section == 1) {
        return self.hotLoanArray.count + 1;
    }else if(section == 2) {
        return self.hotCreditArray.count + 1;
    }
    return 0;
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        HomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
        cell.topArray = self.topArray;
        WEAKSELF;
        cell.tapBlock = ^(NSInteger index) {
            STRONGSELF;
            [strongSelf enterWebView:index];
        };
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if(indexPath.section == 1) {
        if (indexPath.row == 0) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
            return cell;
        }else {
            HotLoanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell3"];
            cell.dic = self.hotLoanArray[indexPath.row - 1];
            return cell;
        }
    }else if(indexPath.section == 2) {
        if (indexPath.row == 0) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell4"];
            return cell;
        }else {
            HotCreditTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell5"];
            cell.object = self.hotCreditArray[indexPath.row - 1];
            return cell;
        }
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 114.f;
    }else if(indexPath.section == 1) {
        if (indexPath.row == 0) {
            return 40.f;
        }
        return 70.f;
    }else if(indexPath.section == 2) {
        if (indexPath.row == 0) {
            return 40.f;
        }
        return 90.f;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1 && indexPath.row != 0) {
        LoanDetailViewController *detail = StoryBoardDefined(@"LoanDetailViewController");
        detail.hidesBottomBarWhenPushed = YES;
        detail.object = self.hotLoanArray[indexPath.row - 1];
        [self.navigationController pushViewController:detail animated:YES];
    }else if (indexPath.section == 2 && indexPath.row != 0) {
        [MobClick event:@"hotCredit" attributes:@{@"name":[((BmobObject*)self.hotCreditArray[indexPath.row-1]) objectForKey:@"name"]}];
        JCCBaseWebViewController *web = [[JCCBaseWebViewController alloc] init];
        web.hidesBottomBarWhenPushed = YES;
        web.url = [[((BmobObject*)self.hotCreditArray[indexPath.row-1]) objectForKey:@"linkUrl"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [self.navigationController pushViewController:web animated:YES];
    }
}

#pragma mark -
- (void)imagePlayerView:(ImagePlayerView *)imagePlayerView loadImageForImageView:(UIImageView *)imageView index:(NSInteger)index {
    imageView.image = [UIImage imageNamed:self.ads[index]];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
}

- (void)imagePlayerView:(ImagePlayerView *)imagePlayerView didTapAtIndex:(NSInteger)index {
    NSLog(@"%d",index);
    if (index == 0) {
        JCCBaseWebViewController *web = [[JCCBaseWebViewController alloc] init];
        web.url = HaoDaiLoanURL;
        web.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:web animated:YES];
    }else if(index == 1) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[XinJinBUSURL1 stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    }else if(index == 2) {
      [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[ShanYinURL stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    }
}


- (void)enterWebView:(NSInteger)index {
    if (self.hotLoanArray.count == 0) {
        return;
    }
    if (index == 0) {
        LoanDetailViewController *web = StoryBoardDefined(@"LoanDetailViewController");
        web.object = self.hotLoanArray[0];
        web.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:web animated:YES];
    }else if (index == 1) {
        [MobClick event:@"dedk"];
        JCCBaseWebViewController *web = [[JCCBaseWebViewController alloc] init];
        web.hidesBottomBarWhenPushed = YES;
        web.url = HaoDaiLoanURL;
        [self.navigationController pushViewController:web animated:YES];
    }else if (index == 2) {
        JCCBaseWebViewController *web = [[JCCBaseWebViewController alloc] init];
        web.hidesBottomBarWhenPushed = YES;
        web.url = HaoDaiCreditURL;
        [self.navigationController pushViewController:web animated:YES];
    }else if (index == 3) {
        [MobClick event:@"CreditManager"];
        CreditManagerViewController *web = [[CreditManagerViewController alloc] init];
        web.url = XingDaiManagerURL;
        web.hidesBottomBarWhenPushed = YES;
        web.title = @"信贷经理入驻";
        [self.navigationController pushViewController:web animated:YES];
    }
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
