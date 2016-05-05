//
//  HotLoanTableViewCell.m
//  jisudai
//
//  Created by haodai on 16/4/14.
//  Copyright © 2016年 xiaoya. All rights reserved.
//

#import "HotLoanTableViewCell.h"

@interface HotLoanTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *num;
@property (weak, nonatomic) IBOutlet UILabel *rate;
@property (weak, nonatomic) IBOutlet UILabel *limit;

@end

@implementation HotLoanTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDic:(BmobObject *)dic {
    _dic = dic;
    [_img sd_setImageWithURL:[NSURL URLWithString:[[dic objectForKey:@"imgUrl"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    _name.text = [dic objectForKey:@"name"];
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"人申请数：%@人",[dic objectForKey:@"applyNum"]]];
    NSRange range = [[NSString stringWithFormat:@"人申请数：%@人",[dic objectForKey:@"applyNum"]] rangeOfString:[NSString stringWithFormat:@"%@人",[dic objectForKey:@"applyNum"]]];
    [string addAttribute:NSForegroundColorAttributeName  value:[UIColor colorWithHexColorString:@"ff2050"] range:range];
    _num.attributedText = string;
    
    NSMutableAttributedString *string1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"月利率：%@",[dic objectForKey:@"rate"]]];
    NSRange range1 = [[NSString stringWithFormat:@"月利率：%@",[dic objectForKey:@"rate"]] rangeOfString:[NSString stringWithFormat:@"%@",[dic objectForKey:@"rate"]]];
    [string1 addAttribute:NSForegroundColorAttributeName  value:[UIColor colorWithHexColorString:@"ff2050"] range:range1];
    _rate.attributedText = string1;
    
    _limit.text = [NSString stringWithFormat:@"额度：%@",[dic objectForKey:@"limit"]];
}

@end
