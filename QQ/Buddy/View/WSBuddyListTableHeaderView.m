//
//  WSBuddyListTableHeaderView.m
//  QQ
//
//  Created by weida on 16/1/25.
//  Copyright © 2016年 weida. All rights reserved.
//

#import "WSBuddyListTableHeaderView.h"

#define kBkColorLine          ([UIColor colorWithRed:0.918 green:0.918 blue:0.918 alpha:1])

@interface WSBuddyListTableHeaderView ()
{
    CALayer *_line;
    
    UILabel *_totalCount;
    
    UIButton *_button;
}
@end


@implementation WSBuddyListTableHeaderView

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self)
    {
        self.contentView.backgroundColor = [UIColor whiteColor];
        _line = [[CALayer alloc]init];
        _line.backgroundColor = kBkColorLine.CGColor;
        [self.contentView.layer addSublayer:_line];
        
        _totalCount = [[UILabel alloc]init];
        _totalCount.backgroundColor = [UIColor clearColor];
        _totalCount.textAlignment = NSTextAlignmentRight;
        _totalCount.font = [UIFont systemFontOfSize:10];
        [self.contentView.layer addSublayer:_totalCount.layer];
        
        _button = [[UIButton alloc]init];
        _button.backgroundColor = [UIColor clearColor];
        [_button setImage:[UIImage imageNamed:@"buddy_header_arrow"] forState:UIControlStateNormal];
        [_button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _button.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        _button.titleEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 50);
        _button.titleLabel.font = [UIFont systemFontOfSize:13];
        _button.imageView.contentMode =  UIViewContentModeScaleAspectFit;
        [_button addTarget:self action:@selector(showGroup:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_button];
    }
    return self;
}



-(void)layoutSubviews
{
    [super layoutSubviews];
    
    _line.frame = CGRectMake(0, 0, self.bounds.size.width, 0.6);
    
    CGFloat width = 40;
    CGFloat Offset = 15;
    _totalCount.frame = CGRectMake(self.bounds.size.width-width - Offset, 0,width, self.bounds.size.height);
    
    _button.frame = self.contentView.bounds;
}


#pragma mark - 事件处理

-(void)showGroup:(UIButton *)sender
{
    static BOOL lll;
    lll = !lll;
    [UIView animateWithDuration:0.5 animations:^
    {
        if (lll)
        {
            _button.imageView.transform = CGAffineTransformMakeRotation(M_PI_2);
        }else
        {
            _button.imageView.transform = CGAffineTransformIdentity;
        }
    }];
    
}

-(void)setSectionInfo:(id<NSFetchedResultsSectionInfo>)sectionInfo
{
    _sectionInfo = sectionInfo;
    
    _totalCount.text = [NSString stringWithFormat:@"100/%ld",[sectionInfo numberOfObjects]];
    
    [_button setTitle:[sectionInfo name] forState:UIControlStateNormal];

}

@end