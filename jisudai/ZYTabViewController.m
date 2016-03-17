//
//  ZYTabViewController.m
//  EngineeringStructure
//
//  Created by haodai on 15/9/16.
//  Copyright (c) 2015年 haodai. All rights reserved.
//

#import "ZYTabViewController.h"
#import "UIColor+Extend.h"

@interface ZYTabViewController ()

@end

@implementation ZYTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITabBarItem *home    = [self.tabBar.items objectAtIndex:0];
    UITabBarItem *loan = [self.tabBar.items objectAtIndex:1];
    UITabBarItem *creditCard = [self.tabBar.items objectAtIndex:2];
    UITabBarItem *creditMessage = [self.tabBar.items objectAtIndex:3];
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0f)  {
        self.tabBar.translucent = NO;
        [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:10],NSFontAttributeName, nil] forState:UIControlStateNormal];
//
        [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithRed:27.f/255.f green:200.f/255.f blue:217.f/255.f alpha:1.0],NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
        [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithHexColorString:@"808080"],NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
        
        home.image = [[UIImage imageNamed:@"home"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        home.selectedImage = [[UIImage imageNamed:@"home_s"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        loan.image = [[UIImage imageNamed:@"daikuan"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        loan.selectedImage = [[UIImage imageNamed:@"daikuan_s"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        creditCard.image = [[UIImage imageNamed:@"credit"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        creditCard.selectedImage = [[UIImage imageNamed:@"credit_s"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        creditMessage.image = [[UIImage imageNamed:@"zixun"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        creditMessage.selectedImage = [[UIImage imageNamed:@"zixun_s"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    }
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
