//
//  LoanDetailViewController.m
//  jisudai
//
//  Created by zhouyong on 16/4/29.
//  Copyright © 2016年 xiaoya. All rights reserved.
//

#import "LoanDetailViewController.h"
#import "LoanDetailTableViewCell.h"
#import "CommentTableViewCell.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "CommentViewController.h"
#import "MJRefresh.h"

@interface LoanDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *dataSource;
@property (nonatomic, assign)NSInteger currentPage;
@end

@implementation LoanDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [MobClick event:@"LoanDetail"];
    self.dataSource = [NSMutableArray arrayWithCapacity:1];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.title = [self.object objectForKey:@"name"];
    _currentPage = 1;
    [self feachData];
    WEAKSELF;
    self.tableView.mj_footer =  [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        STRONGSELF;
        [strongSelf feachData];
    }];

    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

- (void)feachData {
    [[HTTPRequestManager manager] POST:@"Comment" dictionary:@{@"hotLoanId":[self.object objectForKey:@"objectId"]}  page:_currentPage success:^(id responseObject) {
        _currentPage++;
        if ([self.tableView.mj_footer isRefreshing]) {
            [self.tableView.mj_footer endRefreshing];
            [self.dataSource addObjectsFromArray:responseObject];
        }else {
            [self.dataSource removeAllObjects];
            [self.dataSource addObjectsFromArray:responseObject];
        }
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        if ([self.tableView.mj_footer isRefreshing]) {
            [self.tableView.mj_footer endRefreshing];
        }
    } view:self.view progress:NO];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else if (section == 1) {
        return 1;
    }else if (section == 2) {
        return self.dataSource.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LoanDetailTableViewCell *cell = nil;
    if (indexPath.section == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"cell1"];
        cell.object = self.object;
    }else if (indexPath.section == 1) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"cell2"];
        cell.object = self.object;
    }else if (indexPath.section == 2) {
       CommentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell3"];
        cell.object = self.dataSource[indexPath.row];
       return cell;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 184.f;
    }else if(indexPath.section == 1) {
        return [tableView fd_heightForCellWithIdentifier:@"cell2" cacheByIndexPath:indexPath configuration:^(LoanDetailTableViewCell* cell) {
            cell.object = self.object;
        }];
    }else if (indexPath.section == 2) {
        return [tableView fd_heightForCellWithIdentifier:@"cell3" cacheByIndexPath:indexPath configuration:^(CommentTableViewCell* cell) {
            cell.object = self.dataSource[indexPath.row];
        }];
        return 80;
    }
    return 0;
}


- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return nil;
    }
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 30.f)];
    headView.backgroundColor = BackgroundColor;
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 200, 30.f)];
    lable.backgroundColor = [UIColor clearColor];
    lable.textColor = [UIColor blackColor];
    lable.font = [UIFont systemFontOfSize:14];
    if (section == 1) {
        lable.text = @"申请材料";
    }else if (section == 2) {
        lable.text = @"用户留言";
    }
    [headView addSubview:lable];
    return headView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return CGFLOAT_MIN;
    }else {
        return 30.f;
    }
}

- (IBAction)goLoan:(id)sender {
    [MobClick event:@"hotLoan" attributes:@{@"name":[self.object objectForKey:@"name"]}];
    if ([[self.object objectForKey:@"linkUrl"] isEqualToString:@"1"]) {
        [LoansSDK showLoanSdkView];
    }else {
      [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[[self.object objectForKey:@"linkUrl"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    }
}

- (IBAction)goComment:(id)sender {
    CommentViewController *comment = StoryBoardDefined(@"CommentViewController");
    comment.hotLoanId = [self.object objectForKey:@"objectId"];
    WEAKSELF;
    comment.block = ^() {
        _currentPage = 1;
        STRONGSELF;
        [strongSelf feachData];
    };
    [self.navigationController pushViewController:comment animated:YES];
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
