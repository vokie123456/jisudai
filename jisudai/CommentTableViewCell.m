//
//  CommentTableViewCell.m
//  jisudai
//
//  Created by zhouyong on 16/4/29.
//  Copyright © 2016年 xiaoya. All rights reserved.
//

#import "CommentTableViewCell.h"

@interface  CommentTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *type;
@property (weak, nonatomic) IBOutlet UILabel *content;

@end

@implementation CommentTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setObject:(BmobObject *)object {
    _object = object;
    _type.text = [object objectForKey:@"type"];
    _content.text = [object objectForKey:@"content"];
}

@end
