//
//  ARSColorMenuView.m
//

#import <QuartzCore/QuartzCore.h>
#import "UIColor+HexAdditions.h"
#import "ARSColorMenuConstants.h"
#import "ARSColorMenuView.h"

//Class Extension for forward declaration of methods
@interface ARSColorMenuView()

//Single point for initialization
- (void) _pStandardInitialization;

//Creates the menu buttons
- (void) _pInitializeMenuItems;

//Sets background images for the menu buttons
- (void) _pSetBackgroundImagesForMenuItems;

//Setup Autolayout details here
- (void) _pSetupLayoutAttributesForColorMenuView;

//Sets up Autolayout constraints for the buttons
- (void) _pSetupLayoutConstraintsForMenuItem:(UIView *) menuItem withHorizontalConstant:(CGFloat) horizontalConstant;


//Adds the buttons to the view
- (void) _pAddMenuItemsToView;

@property (nonatomic, strong, readwrite) UIImageView *colorSelectionBorderView;
@property (nonatomic, strong, readwrite) UIButton *orangeBrushButton;
@property (nonatomic, strong, readwrite) UIButton *greenBrushButton;
@property (nonatomic, strong, readwrite) UIButton *purpleBrushButton;
@property (nonatomic, strong, readwrite) UIButton *yellowBrushButton;
@property (nonatomic, strong, readwrite) UIButton *blueBrushButton;
@property (nonatomic, strong, readwrite) UIButton *backButton;

//Constraints for Color Border Selection view
@property (nonatomic, strong, readwrite) NSLayoutConstraint *colorSelectionBorderViewWidthConstraint;
@property (nonatomic, strong, readwrite) NSLayoutConstraint *colorSelectionBorderViewHeightConstraint;

@end

@implementation ARSColorMenuView

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
    [self setBackgroundColor:[UIColor colorWithHexValue:ColorMenuViewBackgroundColor alpha:0.7f]];
    [self _pInitializeMenuItems];
}

- (void) _pInitializeMenuItems
{
    self.colorSelectionBorderView = [[UIImageView alloc] init];
    self.orangeBrushButton = [[UIButton alloc] init];
    self.greenBrushButton = [[UIButton alloc] init];
    self.purpleBrushButton = [[UIButton alloc] init];
    self.yellowBrushButton = [[UIButton alloc] init];
    self.blueBrushButton = [[UIButton alloc] init];
    self.backButton = [[UIButton alloc] init];
    
    //Add the items to the view
    [self _pAddMenuItemsToView];
}

- (void) _pSetBackgroundImagesForMenuItems
{
    //COLOR SELECTION BORDER
    [self.colorSelectionBorderView setImage:[UIImage imageNamed:TBNColorSelectionBorderImagename]];
    
    //ORANGE BUTTON
    [self.orangeBrushButton setBackgroundImage:[UIImage imageNamed:FingerOrangeUpImageName] forState:UIControlStateNormal];
    
    //GREEN BUTTON
    [self.greenBrushButton setBackgroundImage:[UIImage imageNamed:FingerGreenUpImageName] forState:UIControlStateNormal];
    
    //PURPLE BUTTON
    [self.purpleBrushButton setBackgroundImage:[UIImage imageNamed:FingerPurpleUpImageName] forState:UIControlStateNormal];
    
    //YELLOW BUTTON
    [self.yellowBrushButton setBackgroundImage:[UIImage imageNamed:FingerYellowUpImageName] forState:UIControlStateNormal];
    
    //BLUE BUTTON
    [self.blueBrushButton setBackgroundImage:[UIImage imageNamed:FingerBlueUpImageName] forState:UIControlStateNormal];
    
    //BACK BUTTON
    [self.backButton setBackgroundImage:[UIImage imageNamed:BackButtonImageName] forState:UIControlStateNormal];
    
}

- (void) layoutMenuButtons
{
    //Setup Autolayout constraints for the buttons
    [self _pSetupLayoutAttributesForColorMenuView];
    
    //Setup Background Images for the buttons
    [self _pSetBackgroundImagesForMenuItems];
}

- (void)removeLayout
{
    [self removeConstraints:self.constraints];
}

- (void) _pSetupLayoutAttributesForColorMenuView
{
    [self _pSetupLayoutConstraintsForColorBorderViewWithHorizontalConstant:OrangeButtonWidthValue];
    
    [self _pSetupLayoutConstraintsForMenuItem:self.orangeBrushButton
                            withHorizontalConstant:OrangeButtonWidthValue];
    
    [self _pSetupLayoutConstraintsForMenuItem:self.greenBrushButton
                            withHorizontalConstant:GreenButtonWidthValue];
    
    [self _pSetupLayoutConstraintsForMenuItem:self.purpleBrushButton
                            withHorizontalConstant:PurpleButtonWidthValue];
    
    [self _pSetupLayoutConstraintsForMenuItem:self.yellowBrushButton
                            withHorizontalConstant:YellowButtonWidthValue];
    
    [self _pSetupLayoutConstraintsForMenuItem:self.blueBrushButton
                            withHorizontalConstant:BlueButtonWidthValue];
    
    [self _pSetupLayoutConstraintsForMenuItem:self.backButton
                       withHorizontalConstant:BackButtonWidthValue];
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

- (void) _pAddMenuItemsToView
{
    //Add the items to the view
    [self addSubview:self.orangeBrushButton];
    [self addSubview:self.greenBrushButton];
    [self addSubview:self.purpleBrushButton];
    [self addSubview:self.yellowBrushButton];
    [self addSubview:self.blueBrushButton];
    [self addSubview:self.backButton];
    [self addSubview:self.colorSelectionBorderView];
}

#pragma mark - Color Selection Border View Specific Methods

- (void) _pSetupLayoutConstraintsForColorBorderViewWithHorizontalConstant:(CGFloat) horizontalConstant
{
    //Turning off auto resizing translation
    [self.colorSelectionBorderView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    //Horizontal Constraint
    self.colorSelectionBorderViewWidthConstraint = [NSLayoutConstraint
                                                    constraintWithItem:self.colorSelectionBorderView
                                                    attribute:NSLayoutAttributeLeft
                                                    relatedBy:NSLayoutRelationEqual
                                                    toItem:self
                                                    attribute:NSLayoutAttributeLeft
                                                    multiplier:1.0
                                                    constant:horizontalConstant];
    
    self.colorSelectionBorderViewHeightConstraint = [NSLayoutConstraint
                                                     constraintWithItem:self.colorSelectionBorderView
                                                     attribute:NSLayoutAttributeCenterY
                                                     relatedBy:NSLayoutRelationEqual
                                                     toItem:self
                                                     attribute:NSLayoutAttributeCenterY
                                                     multiplier:1.0
                                                     constant:0.0];
    
    [self addConstraint:self.colorSelectionBorderViewWidthConstraint];
    [self addConstraint:self.colorSelectionBorderViewHeightConstraint];
    
    [self addConstraint:[NSLayoutConstraint
                        constraintWithItem:self.colorSelectionBorderView
                        attribute:NSLayoutAttributeWidth
                        relatedBy:NSLayoutRelationEqual
                        toItem:self
                        attribute:NSLayoutAttributeHeight
                        multiplier:0.5
                        constant:0.0]];
    
    [self addConstraint:[NSLayoutConstraint
                         constraintWithItem:self.colorSelectionBorderView
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
            layoutSpecifier = OrangeButtonWidthValue;
            break;
        case 1:
            layoutSpecifier = GreenButtonWidthValue;
            break;
        case 2:
            layoutSpecifier = PurpleButtonWidthValue;
            break;
        case 3:
            layoutSpecifier = YellowButtonWidthValue;
            break;
        case 4:
            layoutSpecifier = BlueButtonWidthValue;
            break;
        default:
            layoutSpecifier = OrangeButtonWidthValue;
            break;
    }
    ARSColorMenuView *__weak weakSelf = self;
    [UIView animateWithDuration:0.5f
                     animations:^{
                         weakSelf.colorSelectionBorderViewWidthConstraint.constant = layoutSpecifier;
                         [weakSelf layoutIfNeeded];
                     }];
}

@end
