//
//  HotCreditTableViewCell.m
//  jisudai
//
//  Created by haodai on 16/4/14.
//  Copyright © 2016年 xiaoya. All rights reserved.
//

#import "HotCreditTableViewCell.h"
@interface HotCreditTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *tip;
@property (weak, nonatomic) IBOutlet UILabel *applyNum;

@end

@implementation HotCreditTableViewCell

- (void)awakeFromNib {
    _img.contentMode = UIViewContentModeScaleAspectFit;
    ViewBorderRadius(_tip, 2, 1, RGBCOLOR(80, 135, 229));
    _tip.textColor = RGBCOLOR(80, 135, 229);
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)setObject:(BmobObject *)object {
    if (object == nil) {
        return;
    }
    _object = object;
    [_img sd_setImageWithURL:[NSURL URLWithString:[[object objectForKey:@"imgUrl"] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    _name.text = [object objectForKey:@"name"];
    _tip.text = [object objectForKey:@"des"];
    NSMutableAttributedString *string1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"申请人数：%@",[object objectForKey:@"applyNum"]]];
    NSRange range1 = [[NSString stringWithFormat:@"申请人数：%@",[object objectForKey:@"applyNum"]] rangeOfString:[NSString stringWithFormat:@"%@",[object objectForKey:@"applyNum"]]];
    [string1 addAttribute:NSForegroundColorAttributeName  value:[UIColor colorWithHexColorString:@"f7636e"] range:range1];
    _applyNum.attributedText = string1;
}


@end
