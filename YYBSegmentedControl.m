//
//  YYBSegmentedControl.m
//
//
//  Created by YYB on 20/10/11.
//  Copyright (c) 2020年 YYB All rights reserved.
//

#import "YYBSegmentedControl.h"

@interface YYBSegmentedControl ()

@property (nonatomic) UIView *bottomIndicatorView;
@property (nonatomic) NSMutableArray <UIButton *> *buttonArray;


@end

@implementation YYBSegmentedControl
-(void)addSegmentArray:(NSArray <NSString *> *)SegmentArray
{
    // 少于两项 segment 不画
    NSInteger segmentCount = SegmentArray.count;
    if (segmentCount < 2) {
        NSLog(@"SegmentArray's count musts more than one, but now is %ld", segmentCount);
        return;
    }
    // 所有标题总长度大于控件总宽度不画
    NSString *wholeString = [SegmentArray componentsJoinedByString:@""];
    CGSize size = [wholeString sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:self.fontSize]}];
    CGFloat stringLength = ceilf(size.width);
        if (stringLength > self.bounds.size.width) {
        NSLog(@"YYBSegmentedControl needs more wide!");
        return;
    }
    // 标题单边间隙
    CGFloat oneSideGap = (self.bounds.size.width - stringLength) / (SegmentArray.count * 2);
    // 存储下一次按钮frame 原点 X 值
    CGFloat buttonOriginX = 0;
    for (int i = 0; i < SegmentArray.count; i++) {
        NSString *title = SegmentArray[i];
        CGSize textSize = [title sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:self.fontSize]}];
        
        CGFloat textLength = ceilf(textSize.width);
        UIButton* button = [[UIButton alloc] initWithFrame:CGRectMake(buttonOriginX,
                                                                      0,
                                                                      textLength + oneSideGap * 2,
                                                                      self.bounds.size.height)];
        buttonOriginX = CGRectGetMaxX(button.frame);
        [button setTitle:SegmentArray[i] forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont systemFontOfSize:self.fontSize]];
        [button setTitleColor:self.titleColor forState:UIControlStateNormal];
        [button setTitleColor:self.selectedTitleColor forState:UIControlStateSelected];
        [button setTag:i];
        [button addTarget:self action:@selector(changeTheSegment:) forControlEvents:UIControlEventTouchUpInside];
        // 画底部指示视图
        if (i == 0) {
            [button.titleLabel setFont:[UIFont boldSystemFontOfSize:self.selectFontSize]];
            _bottomIndicatorView = [[UIView alloc]initWithFrame:CGRectMake(0, self.bounds.size.height - _indicatorHeight - _indicatorBottom, _indicatorWidth, _indicatorHeight)];
            _bottomIndicatorView.center = CGPointMake(button.center.x, _bottomIndicatorView.center.y);
            [_bottomIndicatorView setBackgroundColor:self.indicatorColor];
            if (_roundedIndicator) {
                _bottomIndicatorView.layer.cornerRadius = _indicatorHeight / 2.0;
            }
            [self addSubview:_bottomIndicatorView];
        }
        [self addSubview:button];
        [self.buttonArray addObject:button];
        // 画分割线
        if (self.showSeparator) {
            if (i < SegmentArray.count - 1) {
                UIView *separateView = [[UIView alloc] initWithFrame:CGRectMake(buttonOriginX, _separatorVerticalInset, 1, self.bounds.size.height - _indicatorHeight - _separatorVerticalInset * 2)];
                separateView.backgroundColor = self.separatorColor;
                [self addSubview:separateView];
            }
        }
    }
    [[self.buttonArray firstObject] setSelected:YES];
}

- (void)changeTheSegment:(UIButton*)button {
    [self selectSegment:button.tag animated:YES];
}

- (void)selectSegment:(NSInteger)segment animated:(BOOL)animated {
    if (_selectedSegment != segment) {
        UIButton *lastSelectedButton = self.buttonArray[_selectedSegment];
        [lastSelectedButton setSelected:NO];
        [lastSelectedButton.titleLabel setFont:[UIFont systemFontOfSize:self.fontSize]];
        UIButton *selectedButton = self.buttonArray[segment];
        [selectedButton setSelected:YES];
        [selectedButton.titleLabel setFont:[UIFont boldSystemFontOfSize:self.selectFontSize]];
        NSTimeInterval duration = 0;
        if (animated) duration = 0.3;
        [UIView animateWithDuration:duration animations:^{
            self.bottomIndicatorView.center = CGPointMake(selectedButton.center.x, self.bottomIndicatorView.center.y);
        }];
        _selectedSegment = segment;
        if (self.delegate && [self.delegate conformsToProtocol:@protocol(YYBSegmentedControlDelegate)]) {
            [self.delegate segumentSelectionChanged:_selectedSegment];
        }
    }
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self setDefaultValues];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setDefaultValues];
    }
    return self;
}

- (void)setDefaultValues {
    self.buttonArray = [NSMutableArray array];
    _selectedSegment = 0;
    self.fontSize = 26;
    self.titleColor = [UIColor grayColor];
    self.selectedTitleColor = [UIColor blackColor];
    self.backgroundColor = [UIColor whiteColor];
    self.separatorColor = [UIColor lightGrayColor];
    self.indicatorColor = [UIColor redColor];
    self.indicatorWidth = 26;
    self.indicatorHeight = 3;
    self.indicatorBottom = 0;
    self.roundedIndicator = YES;
}

@end
