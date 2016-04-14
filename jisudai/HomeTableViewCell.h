//
//  HomeTableViewCell.h
//  jisudai
//
//  Created by haodai on 16/4/14.
//  Copyright © 2016年 xiaoya. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^TapBlock)(NSInteger);
@interface HomeTableViewCell : UITableViewCell
@property (nonatomic, strong) NSArray *topArray;
@property (nonatomic, copy) TapBlock tapBlock;

@end
