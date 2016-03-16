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
    
    UITabBarItem *hotItem    = [self.tabBar.items objectAtIndex:0];
    UITabBarItem *allItem    = [self.tabBar.items objectAtIndex:1];
    UITabBarItem *personItem = [self.tabBar.items objectAtIndex:2];
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0f)  {
        self.tabBar.translucent = NO;
        [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:10],NSFontAttributeName, nil] forState:UIControlStateNormal];
//
        [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithHexColorString:@"00aaee"],NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
        [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithHexColorString:@"808080"],NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
        
        hotItem.image = [[UIImage imageNamed:@"homel"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        hotItem.selectedImage = [[UIImage imageNamed:@"homeh"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        allItem.image = [[UIImage imageNamed:@"cardl"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        allItem.selectedImage = [[UIImage imageNamed:@"cardh"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        
        personItem.image = [[UIImage imageNamed:@"myl"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        personItem.selectedImage = [[UIImage imageNamed:@"myh"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

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
