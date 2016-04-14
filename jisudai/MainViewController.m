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
#import "ShanYinViewController.h"

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
    self.ads = @[@"banner1",@"banner2",@"banner3"];
    self.topArray = @[@{@"icon":@"xedk",@"title":@"小额贷款",@"des":@"上班族学生"},@{@"icon":@"dedk",@"title":@"大额贷款",@"des":@"企业房车贷"},@{@"icon":@"xyk",@"title":@"信用卡",@"des":@"省心省力"},@{@"icon":@"xindaijingli",@"title":@"信贷经理",@"des":@"入驻抢单"}];
    [_adImagePlayerView initWithCount:3 delegate:self];
//    self.tableView.separatorColor =  LineColor;
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

#pragma mark - 
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else if(section == 1) {
        return 3;
    }else if(section == 2) {
        return 3;
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
        };
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if(indexPath.section == 1) {
        if (indexPath.row == 0) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
            return cell;
        }else {
            HotLoanTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell3"];
            return cell;
        }
    }else if(indexPath.section == 2) {
        if (indexPath.row == 0) {
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell4"];
            return cell;
        }else {
            HotCreditTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell5"];
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
        return 70.f;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10.f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
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
        ShanYinViewController *web = [[ShanYinViewController alloc] init];
        web.url = XinJinBUSURL1;
        web.title = @"现金巴士";
         web.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:web animated:YES];
    }else if(index == 2) {
        ShanYinViewController *web = [[ShanYinViewController alloc] init];
        web.url = ShanYinURL;
        web.title = @"闪银";
         web.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:web animated:YES];
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
