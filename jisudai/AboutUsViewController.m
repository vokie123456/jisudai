//
//  AboutUsViewController.m
//  jisudai
//
//  Created by haodai on 16/4/1.
//  Copyright © 2016年 xiaoya. All rights reserved.
//

#import "AboutUsViewController.h"
#define mAPPVersion      [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
@interface AboutUsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *version;

@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _version.text = [NSString stringWithFormat:@"版本：%@",mAPPVersion];
}



@end
