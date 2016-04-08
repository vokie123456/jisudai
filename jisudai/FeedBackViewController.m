//
//  FeedBackViewController.m
//  creditManager
//
//  Created by haodai on 16/3/21.
//  Copyright © 2016年 haodai. All rights reserved.
//

#import "FeedBackViewController.h"
#import "UITextView+Placeholder.h"
#import "ZYTextField.h"
#import "JCCDefine.h"
#import <BmobSDK/BmobObject.h>

@interface FeedBackViewController ()<UITextViewDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet ZYTextField *qq;
@property (weak, nonatomic) IBOutlet ZYTextField *mail;

@end

@implementation FeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _textView.placeholder = @"请详细描述您的问题或建议，我们将及时跟进与解决!";
    _textView.delegate = self;
    ViewBorderRadius(_textView, 1, 1, LineColor);
    _qq.removeView = self.view;
    _qq.enableKeyBoardHeight = YES;
    _qq.delegate = self;
    _mail.removeView = self.view;
    _mail.enableKeyBoardHeight = YES;
    _mail.delegate = self;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];
}

#pragma mark -
- (IBAction)submit:(id)sender {
    if (![_textView hasText]) {
        mAlertView(@"", @"请输入您的反馈信息");
        return;
    }
    if (![_qq hasText] && ![_mail hasText]) {
        mAlertView(@"", @"请至少留下一种联系方式");
        return;
    }
    BmobObject  *feedBack = [BmobObject objectWithClassName:@"FeedBack"];
    [feedBack setObject:_textView.text forKey:@"content"];
    //设置userName为小明
    [feedBack setObject:_qq.text forKey:@"qq"];
    //设置cheatMode为NO
    [feedBack setObject:_mail.text forKey:@"mail"];

    //异步保存到服务器
    [feedBack saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        if (isSuccessful) {
            //创建成功后会返回objectId，updatedAt，createdAt等信息
            //创建对象成功，打印对象值
            NSLog(@"%@",feedBack);
            
        } else if (error){
            //发生错误后的动作
            NSLog(@"%@",error);
        } else {
            NSLog(@"Unknow error");
        }
    }];
    mAlertView(@"", @"感谢您的反馈");
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"]) {
        [self.view endEditing:YES];
    }
     return YES;
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([string isEqualToString:@"\n"]) {
        [self.view endEditing:YES];
    }
    return YES;
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
