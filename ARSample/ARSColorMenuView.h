//
//  ARSColorMenuView.h
//

@interface ARSColorMenuView : UIView

/**
 Orange Brush Button
 
 @property orangeBrushButton
 @type UIButton
 **/
@property (nonatomic, strong, readonly) UIButton *orangeBrushButton;

/**
 Green Brush Button
 
 @property greenBrushButton
 @type UIButton
 **/
@property (nonatomic, strong, readonly) UIButton *greenBrushButton;

/**
 Purple Brush Button
 
 @property purpleBrushButton
 @type UIButton
 **/
@property (nonatomic, strong, readonly) UIButton *purpleBrushButton;

/**
 Purple Brush Button
 
 @property purpleBrushButton
 @type UIButton
 **/
@property (nonatomic, strong, readonly) UIButton *yellowBrushButton;

/**
 Blue Brush Button
 
 @property blueBrushButton
 @type UIButton
 **/
@property (nonatomic, strong, readonly) UIButton *blueBrushButton;

/**
 Lays out the buttons in this view
 
 @method layoutMenuButtons
 @return {void}
 **/
- (void) layoutMenuButtons;

/**
 Performs custom animation during color selection
 
 @method slideColorBorderWithSlideIndex
 @param {NSUInteger} slideIndex
 @return {void}
 **/
- (void) slideColorBorderWithSlideIndex: (NSUInteger) slideIndex;

@end
