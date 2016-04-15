//
//  HotBankView.m
//  creditManager
//
//  Created by haodai on 16/2/29.
//  Copyright © 2016年 haodai. All rights reserved.
//

#import "HotBankView.h"
@interface HotBankView ()
@property (weak, nonatomic) IBOutlet UIImageView *bankIcon;

@property (weak, nonatomic) IBOutlet UILabel *applyNum;
@property (weak, nonatomic) IBOutlet UIImageView *lableImg;
@property (weak, nonatomic) IBOutlet UILabel *lableContent;
@property (weak, nonatomic) IBOutlet UILabel *bankName;

@end

@implementation HotBankView
- (void)setDic:(NSDictionary *)dic {
    if (dic == nil) {
        return;
    }
    _dic = dic;
    _bankIcon.image = [UIImage imageNamed:[dic objectForKey:@"icon"]];
    _bankName.text = [dic objectForKey:@"title"];
    _applyNum.text = [dic objectForKey:@"des"];
    if ([[dic objectForKey:@"lable"] isEqualToString:@""]) {
        _lableContent.hidden = YES;
        _lableImg.hidden = YES;
    }else {
        _lableImg.hidden = NO;
        _lableContent.hidden = NO;
        _lableContent.text = [dic objectForKey:@"lable"];
    }
}



@end
