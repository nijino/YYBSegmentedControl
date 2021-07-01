//
//  YYBSegmentedControl.h
//
//
//  Created by YYB on 20/10/11.
//  Copyright (c) 2020年 YYB All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YYBSegmentedControlDelegate <NSObject>

@optional
-(void)segumentSelectionChanged:(NSInteger)selection;
@end

@interface YYBSegmentedControl : UIView

@property(nonatomic,weak) id <YYBSegmentedControlDelegate> delegate;
@property(strong,nonatomic) IBInspectable UIColor* titleColor;// segment 标题颜色
@property(strong,nonatomic) IBInspectable UIColor* selectedTitleColor;// 选中后 segment 标题颜色
@property (nonatomic) IBInspectable UIColor *indicatorColor;// 指示器颜色
@property (nonatomic) IBInspectable UIColor *separatorColor;// 分割线颜色
@property (nonatomic) IBInspectable CGFloat fontSize;// segment 文字大小
@property (nonatomic) IBInspectable CGFloat selectFontSize;// 选中后 segment 文字大小
@property (nonatomic) IBInspectable CGFloat indicatorWidth;// 指示器宽度
@property (nonatomic) IBInspectable CGFloat indicatorHeight;// 指示器高度
@property (nonatomic) IBInspectable BOOL roundedIndicator;// 指示器是否圆角
@property (nonatomic) IBInspectable BOOL showSeparator;// 是否显示分割线
@property (nonatomic) IBInspectable CGFloat separatorVerticalInset;// 分割线垂直缩进
@property (nonatomic) IBInspectable CGFloat indicatorBottom;// 指示器距底边距
@property (nonatomic) NSInteger selectedSegment; // 已选择的 segment

-(void)addSegmentArray:(NSArray <NSString *> *)segmentArray;
-(void)selectSegment:(NSInteger)segment animated:(BOOL)animated;

@end
