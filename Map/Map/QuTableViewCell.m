//
//  QuTableViewCell.m
//  Map
//
//  Created by 汪杰 on 16/8/29.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "QuTableViewCell.h"

@implementation QuTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
        //label.numberOfLines=0;
        //label.lineBreakMode=UILineBreakModeCharacterWrap;
        [self.contentView addSubview:label];
        self.label=label;
        UIWebView *webview=[[UIWebView alloc]initWithFrame:CGRectMake(0, 60, 320, 240)];
        [self.contentView addSubview:webview];
        self.webview=webview;
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
