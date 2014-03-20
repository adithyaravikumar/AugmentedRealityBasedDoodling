//
//  ARSBrushMenuView.m
//  ARSample
//
//  Created by Adithya Ravikumar on 3/19/14.
//  Copyright (c) 2014 Nothing. All rights reserved.
//

#import "ARSBrushMenuView.h"
#import "ARSBrushMenuConstants.h"
#import "UIColor+HexAdditions.h"

@interface ARSBrushMenuView ()
@property (nonatomic, strong, readwrite) UIImageView *brushSelectionBorderView;
@property (nonatomic, strong, readwrite) UIButton *particleButton;
@property (nonatomic, strong, readwrite) UIButton *blockButton;
@property (nonatomic, strong, readwrite) UIButton *discButton;
@property (nonatomic, strong, readwrite) UIButton *starButton;
@property (nonatomic, strong, readwrite) UIButton *backButton;
//Constraints for Brush Border Selection view
@property (nonatomic, strong, readwrite) NSLayoutConstraint *brushSelectionBorderViewWidthConstraint;
@property (nonatomic, strong, readwrite) NSLayoutConstraint *brushSelectionBorderViewHeightConstraint;
@end

@implementation ARSBrushMenuView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self _pStandardInitialization];
    }
    return self;
}

- (void) _pStandardInitialization {
    [self setBackgroundColor:[UIColor colorWithHexValue:BrushMenuViewBackgroundColor alpha:0.7f]];
    [self _pInitializeMenuItems];
}

- (void)_pInitializeMenuItems
{
    self.particleButton = [[UIButton alloc] init];
    self.blockButton = [[UIButton alloc] init];
    self.discButton = [[UIButton alloc] init];
    self.starButton = [[UIButton alloc] init];
    self.backButton = [[UIButton alloc] init];
    self.brushSelectionBorderView = [[UIImageView alloc] init];
    
    [self addSubview:self.particleButton];
    [self addSubview:self.blockButton];
    [self addSubview:self.discButton];
    [self addSubview:self.starButton];
    [self addSubview:self.backButton];
    [self addSubview:self.brushSelectionBorderView];
}

- (void)_pSetBackgroundImagesForMenuItems
{
    [self.brushSelectionBorderView setImage:[UIImage imageNamed:BrushSelectionBorderImagename]];
    
    [self.particleButton setBackgroundImage:[UIImage imageNamed:ParticleButtonIcon] forState:UIControlStateNormal];
    
    [self.blockButton setBackgroundImage:[UIImage imageNamed:BlockButtonIcon] forState:UIControlStateNormal];
    
    [self.discButton setBackgroundImage:[UIImage imageNamed:DiscButtonIcon] forState:UIControlStateNormal];
    
    [self.starButton setBackgroundImage:[UIImage imageNamed:StarButtonIcon] forState:UIControlStateNormal];
    
    [self.backButton setBackgroundImage:[UIImage imageNamed:BrushBackButtonImageName] forState:UIControlStateNormal];
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
    [self _pSetupLayoutConstraintsForBrushBorderViewWithHorizontalConstant:ParticleButtonWidthValue];
    
    [self _pSetupLayoutConstraintsForMenuItem:self.particleButton
                       withHorizontalConstant:ParticleButtonWidthValue];
    
    [self _pSetupLayoutConstraintsForMenuItem:self.blockButton
                       withHorizontalConstant:BlockButtonWidthValue];
    
    [self _pSetupLayoutConstraintsForMenuItem:self.discButton
                       withHorizontalConstant:DiscButtonWidthValue];
    
    [self _pSetupLayoutConstraintsForMenuItem:self.starButton
                       withHorizontalConstant:StarButtonWidthValue];
    
    [self _pSetupLayoutConstraintsForMenuItem:self.backButton
                       withHorizontalConstant:BrushBackButtonWidthValue];
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
                         multiplier:0.5
                         constant:0.0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:menuItem
                         attribute:NSLayoutAttributeHeight
                         relatedBy:NSLayoutRelationEqual
                         toItem:self
                         attribute:NSLayoutAttributeHeight
                         multiplier:0.5
                         constant:0.0]];
    
}

#pragma mark - Color Selection Border View Specific Methods

- (void) _pSetupLayoutConstraintsForBrushBorderViewWithHorizontalConstant:(CGFloat) horizontalConstant
{
    //Turning off auto resizing translation
    [self.brushSelectionBorderView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    //Horizontal Constraint
    self.brushSelectionBorderViewWidthConstraint = [NSLayoutConstraint
                                                    constraintWithItem:self.brushSelectionBorderView
                                                    attribute:NSLayoutAttributeLeft
                                                    relatedBy:NSLayoutRelationEqual
                                                    toItem:self
                                                    attribute:NSLayoutAttributeLeft
                                                    multiplier:1.0
                                                    constant:horizontalConstant];
    
    self.brushSelectionBorderViewHeightConstraint = [NSLayoutConstraint
                                                     constraintWithItem:self.brushSelectionBorderView
                                                     attribute:NSLayoutAttributeCenterY
                                                     relatedBy:NSLayoutRelationEqual
                                                     toItem:self
                                                     attribute:NSLayoutAttributeCenterY
                                                     multiplier:1.0
                                                     constant:0.0];
    
    [self addConstraint:self.brushSelectionBorderViewWidthConstraint];
    [self addConstraint:self.brushSelectionBorderViewHeightConstraint];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.brushSelectionBorderView
                         attribute:NSLayoutAttributeWidth
                         relatedBy:NSLayoutRelationEqual
                         toItem:self
                         attribute:NSLayoutAttributeHeight
                         multiplier:0.5
                         constant:0.0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.brushSelectionBorderView
                         attribute:NSLayoutAttributeHeight
                         relatedBy:NSLayoutRelationEqual
                         toItem:self
                         attribute:NSLayoutAttributeHeight
                         multiplier:0.5
                         constant:0.0]];
}

- (void) slideColorBorderWithSlideIndex: (NSUInteger) slideIndex
{
    CGFloat layoutSpecifier;
    switch (slideIndex) {
        case 0:
            layoutSpecifier = ParticleButtonWidthValue;
            break;
        case 1:
            layoutSpecifier = BlockButtonWidthValue;
            break;
        case 2:
            layoutSpecifier = DiscButtonWidthValue;
            break;
        case 3:
            layoutSpecifier = StarButtonWidthValue;
            break;
        default:
            layoutSpecifier = ParticleButtonWidthValue;
            break;
    }
    ARSBrushMenuView *__weak weakSelf = self;
    [UIView animateWithDuration:0.5f
                     animations:^{
                         weakSelf.brushSelectionBorderViewWidthConstraint.constant = layoutSpecifier;
                         [weakSelf layoutIfNeeded];
                     }];
}

@end
