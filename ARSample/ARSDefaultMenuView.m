//
//  ARSDefaultMenuView.m
//  ARSample
//
//  Created by Adithya Ravikumar on 3/9/14.
//  Copyright (c) 2014 Nothing. All rights reserved.
//

#import "ARSDefaultMenuView.h"
#import "ARSDefaultMenuConstants.h"
#import "UIColor+HexAdditions.h"

@interface ARSDefaultMenuView ()
@property (nonatomic, strong, readwrite) UIButton *paintBucketButton;
@property (nonatomic, strong, readwrite) UIButton *paintBrushButton;
@property (nonatomic, strong, readwrite) UIButton *eraseButton;
@property (nonatomic, strong, readwrite) UIButton *shareButton;
@end

@implementation ARSDefaultMenuView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self _pStandardInitialization];
    }
    return self;
}

#pragma mark - Menu Items Specific Methods

- (void) _pStandardInitialization {
    [self setBackgroundColor:[UIColor colorWithHexValue:DefaultMenuViewBackgroundColor alpha:0.7f]];
    [self _pInitializeMenuItems];
}

- (void)_pInitializeMenuItems
{
    self.paintBucketButton = [[UIButton alloc] init];
    self.paintBrushButton = [[UIButton alloc] init];
    self.eraseButton = [[UIButton alloc] init];
    self.shareButton = [[UIButton alloc] init];
    
    [self addSubview:self.paintBucketButton];
    [self addSubview:self.paintBrushButton];
    [self addSubview:self.eraseButton];
    [self addSubview:self.shareButton];
}

- (void)_pSetBackgroundImagesForMenuItems
{
    [self.paintBucketButton setBackgroundImage:[UIImage imageNamed:PaintBucketIcon] forState:UIControlStateNormal];
    
    [self.paintBrushButton setBackgroundImage:[UIImage imageNamed:PaintBrushIcon] forState:UIControlStateNormal];
    
    [self.eraseButton setBackgroundImage:[UIImage imageNamed:EraseButtonIcon] forState:UIControlStateNormal];
    
    [self.shareButton setBackgroundImage:[UIImage imageNamed:ShareButtonIcon] forState:UIControlStateNormal];
    
}

- (void)layoutMenuItems
{
    [self _pSetupLayoutAttributesForDefaultMenuView];
    [self _pSetBackgroundImagesForMenuItems];
}

- (void)removeLayout
{
    [self removeConstraints:self.constraints];
}

- (void) _pSetupLayoutAttributesForDefaultMenuView
{
    [self _pSetupLayoutConstraintsForMenuItem:self.paintBucketButton
                       withHorizontalConstant:PaintBucketButtonWidthValue];
    
    [self _pSetupLayoutConstraintsForMenuItem:self.paintBrushButton
                       withHorizontalConstant:PaintBrushButtonWidthValue];
    
    [self _pSetupLayoutConstraintsForMenuItem:self.eraseButton
                       withHorizontalConstant:EraseButtonWidthValue];
    
    [self _pSetupLayoutConstraintsForMenuItem:self.shareButton
                       withHorizontalConstant:ShareButtonWidthValue];
}

- (void) _pSetupLayoutConstraintsForMenuItem:(UIView *) menuItem withHorizontalConstant:(CGFloat) horizontalConstant
{
    //Turning off auto resizing translation
    [menuItem setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    //Horizontal Constraint
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:menuItem
                         attribute:NSLayoutAttributeLeft
                         relatedBy:NSLayoutRelationEqual
                         toItem:self
                         attribute:NSLayoutAttributeLeft
                         multiplier:1.0
                         constant:horizontalConstant]];
    
    //Vertical Constraint
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:menuItem
                         attribute:NSLayoutAttributeCenterY
                         relatedBy:NSLayoutRelationEqual
                         toItem:self
                         attribute:NSLayoutAttributeCenterY
                         multiplier:1.0
                         constant:0.0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:menuItem
                         attribute:NSLayoutAttributeWidth
                         relatedBy:NSLayoutRelationEqual
                         toItem:self
                         attribute:NSLayoutAttributeHeight
                         multiplier:0.65
                         constant:0.0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:menuItem
                         attribute:NSLayoutAttributeHeight
                         relatedBy:NSLayoutRelationEqual
                         toItem:self
                         attribute:NSLayoutAttributeHeight
                         multiplier:0.65
                         constant:0.0]];
    
}

@end
