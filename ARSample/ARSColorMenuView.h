//
//  ARSColorMenuView.h
//

@interface ARSColorMenuView : UIView

@property (nonatomic, strong, readonly) UIButton *orangeBrushButton;

@property (nonatomic, strong, readonly) UIButton *greenBrushButton;

@property (nonatomic, strong, readonly) UIButton *purpleBrushButton;

@property (nonatomic, strong, readonly) UIButton *yellowBrushButton;

@property (nonatomic, strong, readonly) UIButton *blueBrushButton;

@property (nonatomic, strong, readonly) UIButton *backButton;

- (void) layoutMenuButtons;

- (void) slideColorBorderWithSlideIndex: (NSUInteger) slideIndex;

- (void)removeLayout;

@end
