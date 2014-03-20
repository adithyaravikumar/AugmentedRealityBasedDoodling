//
//  ARSBrushMenuView.h
//  ARSample
//
//  Created by Adithya Ravikumar on 3/19/14.
//  Copyright (c) 2014 Nothing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ARSBrushMenuView : UIView

@property (nonatomic, strong, readonly) UIButton *particleButton;
@property (nonatomic, strong, readonly) UIButton *blockButton;
@property (nonatomic, strong, readonly) UIButton *discButton;
@property (nonatomic, strong, readonly) UIButton *starButton;
@property (nonatomic, strong, readonly) UIButton *backButton;

- (void)layoutMenuItems;
- (void) slideColorBorderWithSlideIndex: (NSUInteger) slideIndex;
- (void)removeLayout;

@end
