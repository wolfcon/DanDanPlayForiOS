//
//  OtherSettingSwitchTableViewCell.m
//  DanDanPlayForiOS
//
//  Created by JimHuang on 2017/4/26.
//  Copyright © 2017年 JimHuang. All rights reserved.
//

#import "OtherSettingSwitchTableViewCell.h"

@interface OtherSettingSwitchTableViewCell ()

@end

@implementation OtherSettingSwitchTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.mas_offset(10);
        }];
        
        [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).mas_offset(10);
            make.left.mas_offset(10);
            make.bottom.mas_offset(-10);
        }];
        
        [self.aSwitch mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_equalTo(0);
            make.right.mas_offset(-10);
            make.left.equalTo(self.titleLabel.mas_right).mas_offset(10);
        }];
    }
    return self;
}

- (void)touchSwitch:(UISwitch *)sender {
    if (self.touchSwitchCallBack) {
        self.touchSwitchCallBack();
    }
}

#pragma mark - 懒加载
- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = NORMAL_SIZE_FONT;
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UILabel *)detailLabel {
    if (_detailLabel == nil) {
        _detailLabel = [[UILabel alloc] init];
        _detailLabel.font = SMALL_SIZE_FONT;
        _detailLabel.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_detailLabel];
    }
    return _detailLabel;
}

- (UISwitch *)aSwitch {
    if (_aSwitch == nil) {
        _aSwitch = [[UISwitch alloc] init];
        [_aSwitch addTarget:self action:@selector(touchSwitch:) forControlEvents:UIControlEventValueChanged];
        [self.contentView addSubview:_aSwitch];
    }
    return _aSwitch;
}

@end
