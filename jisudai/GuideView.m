//
//  GuideView.m
//  hunchelaila
//
//  Created by 侯文富 on 15/3/17.
//  Copyright (c) 2015年 百万新娘(北京)科技有限公司. All rights reserved.
//

#import "GuideView.h"
#define PageNumber 5
@implementation GuideView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.contentSize = CGSizeMake(SCREEN_WIDTH*PageNumber, 0);
        self.pagingEnabled = YES;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.bounces = YES;
        self.delegate = self;
        [self setupContentView];
    }
    return self;
}

- (void)setupContentView
{
    for (int i = 0; i < PageNumber; i ++) {
        UIImageView *imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*i, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        imageView1.backgroundColor = [UIColor clearColor];
        imageView1.userInteractionEnabled = YES;
        NSString *path = @"";
        if (IS_IPHONE_4_OR_LESS) {
            path = [NSString stringWithFormat:@"4_00%d",i+1];
        }else if (IS_IPHONE_5) {
            path = [NSString stringWithFormat:@"5_00%d",i+1];
        }else if (IS_IPHONE_6) {
            path = [NSString stringWithFormat:@"6_00%d",i+1];
        }else if (IS_IPHONE_6P) {
            path = [NSString stringWithFormat:@"6p_00%d",i+1];
        }
        imageView1.image = [UIImage imageNamed:path];
        
        if (i == PageNumber - 1) {
            _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
            _backButton.frame = CGRectMake((SCREEN_WIDTH - 100)/2, 0, 100, 34);
            [_backButton setTitle:@"立即体验" forState:0];
            _backButton.backgroundColor = [UIColor colorWithHexColorString:@"41558f"];
            [_backButton setTitleColor:[UIColor whiteColor] forState:0];
            _backButton.titleLabel.font = [UIFont systemFontOfSize:16];
            ViewRadius(_backButton, 5);
            _backButton.bottom =  SCREEN_HEIGHT - 20;
            [imageView1 addSubview:_backButton]; 
        }
         [self addSubview:imageView1];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.x > SCREEN_WIDTH * (PageNumber - 1) + 20) {
        [UIView animateWithDuration:2  animations:^{
            self.alpha = 0;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    }
}

@end
