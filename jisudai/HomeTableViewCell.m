//
//  HomeTableViewCell.m
//  jisudai
//
//  Created by haodai on 16/4/14.
//  Copyright © 2016年 xiaoya. All rights reserved.
//

#import "HomeTableViewCell.h"
#import "HotBankView.h"
@implementation HomeTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTopArray:(NSArray *)topArray {
    if (topArray.count == 0) {
        return;
    }
    [self.contentView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    _topArray = topArray;
    NSLog(@"%d",[[[NSBundle mainBundle] loadNibNamed:@"HotBankView" owner:self options:nil] count]);
    for (int i = 0; i < 4; i ++) {
        HotBankView *hot = LoadNibWithName(@"HotBankView");
        hot.dic = topArray[i];
        hot.tag = 3000 + i;
        hot.frame = CGRectMake(i * SCREEN_WIDTH/4.f, 0, SCREEN_WIDTH/4, 114.f);
        [self.contentView addSubview:hot];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [hot addGestureRecognizer:tap];
    }
}

- (void)tap:(UIGestureRecognizer*)tap {
    if (self.tapBlock) {
        self.tapBlock(tap.view.tag - 3000);
    }
}

@end
