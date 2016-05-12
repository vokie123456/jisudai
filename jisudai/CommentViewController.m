//
//  CommentViewController.m
//  jisudai
//
//  Created by zhouyong on 16/4/29.
//  Copyright © 2016年 xiaoya. All rights reserved.
//

#import "CommentViewController.h"
#import "UITextView+Placeholder.h"

@interface CommentViewController ()<UIAlertViewDelegate,UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *content;
@property (weak, nonatomic) IBOutlet UIButton *problemBtn;
@property (nonatomic,strong)NSArray *array;
@property (nonatomic,strong)NSString *currentType;
@end

@implementation CommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"留言";
    _currentType = @"";
    _content.placeholder = @"请输入您的留言内容";
    _content.delegate = self;
    ViewBorderRadius(_content, 1, 1, LineColor);

    self.array = @[@"#被拒了#",@"#我批了#",@"#额度#",@"#放款速度#",@"#申请过程#",@"#催收还款#",@"#逾期#",@"#其他#"];
        
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)chooseProblem:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] init];
    [self.array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [alert addButtonWithTitle:obj];
    }];
    [alert addButtonWithTitle:@"取消"];
    alert.delegate = self;
    [alert show];
}

- (IBAction)sumbit:(id)sender {
    if (![_content hasText]) {
        mAlertView(@"", @"请输入您的留言内容");
        return;
    }
    if ([_currentType isEqualToString:@""]) {
         mAlertView(@"", @"请选择您的留言类型");
        return;
    }
   
    BmobObject  *Comment = [BmobObject objectWithClassName:@"Comment"];
    [Comment setObject:_content.text forKey:@"content"];
    //设置userName为小明
    [Comment setObject:_currentType forKey:@"type"];
    [Comment setObject:_hotLoanId forKey:@"hotLoanId"];
    //异步保存到服务器
    [Comment saveInBackgroundWithResultBlock:^(BOOL isSuccessful, NSError *error) {
        if (isSuccessful) {
            //创建成功后会返回objectId，updatedAt，createdAt等信息
            //创建对象成功，打印对象值
            NSLog(@"%@",Comment);
            if (self.block) {
                self.block();
            }
            [self.navigationController popViewControllerAnimated:YES];
            mAlertView(@"", @"感谢您的留言");
           
        } else if (error){
            //发生错误后的动作
            NSLog(@"%@",error);
        } else {
            NSLog(@"Unknow error");
        }
    }];
    
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex < self.array.count) {
        [_problemBtn setTitle:[self.array objectAtIndex:buttonIndex] forState:0];
        _currentType = [self.array objectAtIndex:buttonIndex];
    }
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
