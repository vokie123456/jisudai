//
//  LoanDetailTableViewCell.m
//  jisudai
//
//  Created by zhouyong on 16/4/29.
//  Copyright © 2016年 xiaoya. All rights reserved.
//

#import "LoanDetailTableViewCell.h"
#import "ASProgressPopUpView.h"

@interface LoanDetailTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *limit;
@property (weak, nonatomic) IBOutlet UILabel *average;
@property (weak, nonatomic) IBOutlet UILabel *deadline;
@property (weak, nonatomic) IBOutlet UILabel *rate;
@property (weak, nonatomic) IBOutlet ASProgressPopUpView *successRate;
@property (weak, nonatomic) IBOutlet UILabel *successRateLable;

@property (weak, nonatomic) IBOutlet UIButton *successBtn;
@property (weak, nonatomic) IBOutlet UIButton *failBtn;
@property (weak, nonatomic) IBOutlet UILabel *requirement;

@end

@implementation LoanDetailTableViewCell

- (void)awakeFromNib {
    // Initialization code
    ViewBorderRadius(_successBtn, 5, 1, LineColor);
    ViewBorderRadius(_failBtn, 5, 1, LineColor);
    ViewRadius(_successRate, 5);
    [_successBtn setTitleColor:Gray136 forState:0];
    [_successBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
   
    [_failBtn setTitleColor:Gray136 forState:0];
    [_failBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    
    _deadline.textColor = [UIColor colorWithHexColorString:@"ff2050"];
    _rate.textColor = [UIColor colorWithHexColorString:@"ff2050"];
    _requirement.textColor = Gray136;
    _requirement.font = [UIFont systemFontOfSize:14.f];
    _successRate.popUpViewAnimatedColors = @[[UIColor colorWithHexColorString:@"00d0df"]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setObject:(BmobObject *)object {
    _object = object;
    
    NSMutableAttributedString *string1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"放款：%@",[object objectForKey:@"limit"]]];
    NSRange range1 = [[NSString stringWithFormat:@"放款：%@",[object objectForKey:@"limit"]] rangeOfString:[NSString stringWithFormat:@"%@",[object objectForKey:@"limit"]]];
    [string1 addAttribute:NSForegroundColorAttributeName  value:[UIColor colorWithHexColorString:@"ff2050"] range:range1];
    
    NSMutableAttributedString *string2 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"平均：%@",[object objectForKey:@"limit_average"]]];
    NSRange range2 = [[NSString stringWithFormat:@"平均：%@",[object objectForKey:@"limit_average"]] rangeOfString:[NSString stringWithFormat:@"%@",[object objectForKey:@"limit_average"]]];
    [string2 addAttribute:NSForegroundColorAttributeName  value:[UIColor colorWithHexColorString:@"ff2050"] range:range2];

    _limit.attributedText = string1;
    _average.attributedText = string2;
    _rate.text = [object objectForKey:@"rate"];
    _deadline.text = [object objectForKey:@"deadline"];
    [self progress];
    _successRateLable.text = [NSString stringWithFormat:@"放款率：%.f%@",[[_object objectForKey:@"loanSpeed"] floatValue]*100,@"%"];
    
    
    NSMutableAttributedString *string3 = [[NSMutableAttributedString alloc] initWithString:[[object objectForKey:@"requirement"] stringByReplacingOccurrencesOfString:@";" withString:@"\n"]];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:5];
    [string3 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, string3.string.length)];
    _requirement.attributedText = string3;
}


- (void)progress
{
   
    float progress = _successRate.progress;
    if (progress < [[_object objectForKey:@"loanSpeed"] floatValue]) {
        
        progress += 0.01;
        
        [_successRate setProgress:progress animated:NO];
        
        [NSTimer scheduledTimerWithTimeInterval:0.005
                                         target:self
                                       selector:@selector(progress)
                                       userInfo:nil
                                        repeats:NO];
    }
}


- (IBAction)success:(UIButton*)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        _failBtn.selected  = NO;
        _failBtn.backgroundColor = [UIColor whiteColor];
        sender.backgroundColor = [UIColor colorWithHexColorString:@"ff2050"];
    }else {
        sender.backgroundColor = [UIColor whiteColor];
    }
}

- (IBAction)fail:(UIButton*)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        _successBtn.selected  = NO;
        _successBtn.backgroundColor = [UIColor whiteColor];
        sender.backgroundColor = [UIColor colorWithHexColorString:@"ff2050"];
    }else {
        sender.backgroundColor = [UIColor whiteColor];
    }
}


@end
