//
//  TvlistTableViewCell.m
//  Map
//
//  Created by 汪杰 on 16/8/30.
//  Copyright © 2016年 汪杰. All rights reserved.
//

#import "TvlistTableViewCell.h"

@implementation TvlistTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier: reuseIdentifier];
    if (self) {
        self.label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 320, 40)];
        [self.contentView addSubview:self.label];
        self.button=[[UIButton alloc]initWithFrame:CGRectMake(0, 50, 320, 25)];
        [self.button addTarget:self action:@selector(gointernet:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.button];
        
    }
    return self;
}
-(void)gointernet:(UIButton*)sender{
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:self.button.currentTitle]];
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
