//
//  BookShelfTableViewCell.m
//  XTReader
//
//  Created by gao7 on 15/12/9.
//  Copyright © 2015年 gao7. All rights reserved.
//

#import "BookShelfTableViewCell.h"

@interface BookShelfTableViewCell ()

@property (nonatomic, readwrite, strong) UIImageView *novelImage;
@property (nonatomic, readwrite, strong) UILabel *titleLabel;
@property (nonatomic, readwrite, strong) UILabel *authorLabel;
@property (nonatomic, readwrite, strong) UILabel *readDetailLabel;


@end

@implementation BookShelfTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self != nil) {
        [self addView];
    }
    return self;
}

- (void)addView {
    _novelImage = [[UIImageView alloc] init];
    [self addSubview:_novelImage];
    
    
    _titleLabel = [[UILabel alloc] init];
//    _titleLabel.backgroundColor = [UIColor greenColor];
    _titleLabel.numberOfLines = 0;
    [self addSubview:_titleLabel];
    
    
    _authorLabel = [[UILabel alloc] init];
    [self addSubview:_authorLabel];
    
    
    _readDetailLabel = [[UILabel alloc] init];
    [self addSubview:_readDetailLabel];
    [self updateConstraints];
    
}

- (void)updateConstraints {
    
    [_novelImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(5);
        make.left.equalTo(self.mas_left).offset(10);
        make.bottom.equalTo(self.mas_bottom).offset(-5);
        make.width.mas_equalTo(54);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(5);
        make.left.equalTo(_novelImage.mas_right).offset(8);
        make.right.equalTo(self.mas_right).offset(-10);
//        make.height.mas_equalTo(20);
        make.bottom.equalTo(self.mas_bottom).offset(-5);
    }];
    
    [super updateConstraints];
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setNovelImage:(UIImage *)novelImage title:(NSString *)title {
    _novelImage.image = novelImage;
    _titleLabel.text = title;
}

@end
