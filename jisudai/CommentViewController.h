//
//  CommentViewController.h
//  jisudai
//
//  Created by zhouyong on 16/4/29.
//  Copyright © 2016年 xiaoya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JCCBaseViewController.h"

typedef void (^CommentBlock)(void);
@interface CommentViewController : JCCBaseViewController
@property (nonatomic,strong)NSString *hotLoanId;
@property (nonatomic,copy)CommentBlock block;

@end