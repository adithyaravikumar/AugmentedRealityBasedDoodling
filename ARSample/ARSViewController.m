//
//  ARSViewController.m
//  ARSample
//
//  Created by Adithya Ravikumar on 12/8/13.
//  Copyright (c) 2013 Nothing. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "UIColor+HexAdditions.h"
#import "ARSViewController.h"
#import "ARSColorMenuView.h"
#import "ARSVideoView.h"
#import "ARSPaintingView.h"
#import "ARSFlipsideViewController.h"

#define kUpdateFrequency	60.0
#define kBrightness             1.0
#define kSaturation             0.45

#define kPaletteHeight			30
#define kPaletteSize			5
#define kMinEraseInterval		0.5

// Padding for margins
#define kLeftMargin				10.0
#define kTopMargin				10.0
#define kRightMargin			10.0

//Constant strings for the hexcode values of brush colors
NSUInteger const TBNOrangeBrushColor = 0xea5e35;
NSUInteger const TBNGreenBrushColor = 0x9ec33b;
NSUInteger const TBNPurpleBrushColor = 0x7c2981;
NSUInteger const TBNYellowBrushColor = 0xfaec00;
NSUInteger const TBNBlueBrushColor = 0x3353a3;

@interface ARSViewController ()<CLLocationManagerDelegate, MKMapViewDelegate>
@property (nonatomic, strong) ARSVideoView *arsVideoView;
@property (nonatomic, strong) ARSPaintingView *arsPaintingview;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) ARSColorMenuView *arsColorMenuView;
@end

@implementation ARSViewController

- (instancetype)init
{
    self = [super init];
    return self;
}

- (void) loadView
{
    [super loadView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.arsVideoView = [[ARSVideoView alloc] initWithFrame:self.view.frame];
    self.arsPaintingview = [[ARSPaintingView alloc] initWithFrame:self.view.frame];
    self.arsColorMenuView = [[ARSColorMenuView alloc] init];
    
    //Set the orange brush as selected by default when entering the screen and set brush color to orange
    [self _pAddEventHandlersToReaderMenuButtons];
    [self.arsColorMenuView.orangeBrushButton setSelected:YES];
    [self _pUpdateBrushColor:TBNOrangeBrushColor];
    
    [self.view addSubview:self.arsVideoView];
    [self.view addSubview:self.arsPaintingview];
    [self.view addSubview:self.arsColorMenuView];
    [self.arsPaintingview setBackgroundColor:[UIColor clearColor]];
    [self _pLayoutReadermenuView];
    [self loadButtons];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)_pAddEventHandlersToReaderMenuButtons {
    [self.arsColorMenuView.orangeBrushButton addTarget:self action:@selector(_pOrangeBrushButtonTouched:)forControlEvents:UIControlEventTouchUpInside];
    [self.arsColorMenuView.greenBrushButton addTarget:self action:@selector(_pGreenBrushButtonTouched:)forControlEvents:UIControlEventTouchUpInside];
    [self.arsColorMenuView.purpleBrushButton addTarget:self action:@selector(_pPurpleBrushButtonTouched:)forControlEvents:UIControlEventTouchUpInside];
    [self.arsColorMenuView.yellowBrushButton addTarget:self action:@selector(_pYellowBrushButtonTouched:)forControlEvents:UIControlEventTouchUpInside];
    [self.arsColorMenuView.blueBrushButton addTarget:self action:@selector(_pBlueBrushButtonTouched:)forControlEvents:UIControlEventTouchUpInside];
}

- (void)_pLayoutReadermenuView {
    [self.arsColorMenuView setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    //Left Edge Constraint
    [self.view addConstraint:[NSLayoutConstraint
                              constraintWithItem:self.arsColorMenuView
                              attribute:NSLayoutAttributeLeading
                              relatedBy:NSLayoutRelationEqual
                              toItem:self.view
                              attribute:NSLayoutAttributeLeading
                              multiplier:1.0f
                              constant:0.0f]];
    
    //Bottom Edge Constraint
    [self.view addConstraint:[NSLayoutConstraint
                              constraintWithItem:self.arsColorMenuView
                              attribute:NSLayoutAttributeBottom
                              relatedBy:NSLayoutRelationEqual
                              toItem:self.view
                              attribute:NSLayoutAttributeBottom
                              multiplier:1.0f
                              constant:0.0f]];
    
    //Right Edge Constraint
    [self.view addConstraint:[NSLayoutConstraint
                              constraintWithItem:self.arsColorMenuView
                              attribute:NSLayoutAttributeTrailing
                              relatedBy:NSLayoutRelationEqual
                              toItem:self.view
                              attribute:NSLayoutAttributeTrailing
                              multiplier:1.0f
                              constant:0.0f]];
    
    //Height Constraint
    [self.view addConstraint:[NSLayoutConstraint
                              constraintWithItem:self.arsColorMenuView
                              attribute:NSLayoutAttributeHeight
                              relatedBy:NSLayoutRelationEqual
                              toItem:self.view
                              attribute:NSLayoutAttributeHeight
                              multiplier:0.15f
                              constant:0.0f]];
    
    //Layout the buttons inside the reader view
    [self.arsColorMenuView layoutMenuButtons];
}

- (void) loadButtons
{
    UIButton *clearButton = [[UIButton alloc] initWithFrame:CGRectMake(1, 1, 100, 50)];
    [clearButton setTitle:@"Clear" forState:UIControlStateNormal];
    [clearButton addTarget:self action:@selector(eraseView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:clearButton];
    
    UIButton *publishButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width-110, 1, 100, 50)];
    [publishButton setTitle:@"Publish" forState:UIControlStateNormal];
    [publishButton addTarget:self action:@selector(loadLocation) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:publishButton];
}

- (void)_pUpdateBrushColor:(NSUInteger)hexValue {
    CGColorRef color = [[UIColor colorWithHexValue:hexValue] CGColor];
    const CGFloat *components = CGColorGetComponents(color);
    // Defer to the OpenGL view to set the brush color
	[self.arsPaintingview setBrushColorWithRed:components[0] green:components[1] blue:components[2]];
}

// Called when receiving the "shake" notification; plays the erase sound and redraws the view
- (void)eraseView
{
	[self.arsPaintingview erase];
}

#pragma mark - Event Handlers for the buttons

- (void)_pOrangeBrushButtonTouched:(UIButton *) button {
    [self.arsColorMenuView slideColorBorderWithSlideIndex:0];
    [self _pUpdateBrushColor:TBNOrangeBrushColor];
}


- (void)_pGreenBrushButtonTouched:(UIButton *) button {
    [self.arsColorMenuView slideColorBorderWithSlideIndex:1];
    [self _pUpdateBrushColor:TBNGreenBrushColor];
}


- (void)_pPurpleBrushButtonTouched:(UIButton *) button {
    [self.arsColorMenuView slideColorBorderWithSlideIndex:2];
    [self _pUpdateBrushColor:TBNPurpleBrushColor];
}


- (void)_pYellowBrushButtonTouched:(UIButton *) button {
    [self.arsColorMenuView slideColorBorderWithSlideIndex:3];
    [self _pUpdateBrushColor:TBNYellowBrushColor];
}


- (void)_pBlueBrushButtonTouched:(UIButton *) button {
    [self.arsColorMenuView slideColorBorderWithSlideIndex:4];
    [self _pUpdateBrushColor:TBNBlueBrushColor];
}

#pragma mark - Location Specific Methids

- (void) loadLocation
{
    [self setLocationManager:[[CLLocationManager alloc] init]];
	[self.locationManager setDelegate:self];
	[self.locationManager setDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
	[self.locationManager startUpdatingLocation];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
	CLLocation *lastLocation = [locations lastObject];
	CLLocationAccuracy accuracy = [lastLocation horizontalAccuracy];
	NSLog(@"Received location %@ with accuracy %f", lastLocation, accuracy);
	if(accuracy < 100.0) {
		[manager stopUpdatingLocation];
        ARSFlipsideViewController *arsFlipsideViewController = [[ARSFlipsideViewController alloc] initWithLocation:lastLocation andDisplayView:self.arsPaintingview];
        [self.navigationController pushViewController:arsFlipsideViewController animated:YES];
	}
}

@end
