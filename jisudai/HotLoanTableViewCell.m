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
    _num.text = [NSString stringWithFormat:@"申请人数：%@人",[dic objectForKey:@"applyNum"]];
    _rate.text = [dic objectForKey:@"rate"];
}

@end
