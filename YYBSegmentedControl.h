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
@property(strong,nonatomic) IBInspectable UIColor* titleColor;
@property(strong,nonatomic) IBInspectable UIColor* selectedTitleColor;
@property (nonatomic) IBInspectable UIColor *indicatorColor;
@property (nonatomic) IBInspectable UIColor *separatorColor;
@property (nonatomic) IBInspectable CGFloat fontSize;
@property (nonatomic) IBInspectable CGFloat indicatorWidth;
@property (nonatomic) IBInspectable CGFloat indicatorHeight;
@property (nonatomic) IBInspectable CGFloat buttonAndIndicatorSpacing;
@property (nonatomic) IBInspectable BOOL makeIndicatorCornerRound;
@property (nonatomic) NSInteger selectedSegment;

-(void)addSegmentArray:(NSArray <NSString *> *)segmentArray;
-(void)selectSegment:(NSInteger)segment animated:(BOOL)animated;

@end

