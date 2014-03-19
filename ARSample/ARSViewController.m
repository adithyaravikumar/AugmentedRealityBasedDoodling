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
#import "ARSDefaultMenuView.h"
#import "ARSVideoView.h"
#import "ARSPaintingView.h"
#import "ARSFlipsideViewController.h"

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
@property (nonatomic, strong) ARSDefaultMenuView *arsDefaultMenuView;
@end

@implementation ARSViewController

- (instancetype)init
{
    self = [super init];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.arsVideoView = [[ARSVideoView alloc] initWithFrame:self.view.frame];
    self.arsPaintingview = [[ARSPaintingView alloc] initWithFrame:self.view.frame];
    self.arsColorMenuView = [[ARSColorMenuView alloc] initWithFrame:CGRectMake(0, 410, self.view.frame.size.width, self.view.frame.size.height * 0.15)];
    self.arsDefaultMenuView = [[ARSDefaultMenuView alloc] initWithFrame:CGRectMake(0, 410, self.view.frame.size.width, self.view.frame.size.height * 0.15)];
    
    //Set the orange brush as selected by default when entering the screen and set brush color to orange
    [self _pAddEventHandlersToButtons];
    [self.arsColorMenuView.orangeBrushButton setSelected:YES];
    [self _pUpdateBrushColor:TBNOrangeBrushColor];
    
    [self.arsPaintingview setBackgroundColor:[UIColor clearColor]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.view addSubview:self.arsVideoView];
    [self.view addSubview:self.arsPaintingview];
    [self.view addSubview:self.arsDefaultMenuView];
    [self _pLayoutDefaultMenuView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)_pAddEventHandlersToButtons {
    [self.arsColorMenuView.orangeBrushButton addTarget:self action:@selector(_pOrangeBrushButtonTouched:)forControlEvents:UIControlEventTouchUpInside];
    [self.arsColorMenuView.greenBrushButton addTarget:self action:@selector(_pGreenBrushButtonTouched:)forControlEvents:UIControlEventTouchUpInside];
    [self.arsColorMenuView.purpleBrushButton addTarget:self action:@selector(_pPurpleBrushButtonTouched:)forControlEvents:UIControlEventTouchUpInside];
    [self.arsColorMenuView.yellowBrushButton addTarget:self action:@selector(_pYellowBrushButtonTouched:)forControlEvents:UIControlEventTouchUpInside];
    [self.arsColorMenuView.blueBrushButton addTarget:self action:@selector(_pBlueBrushButtonTouched:)forControlEvents:UIControlEventTouchUpInside];
    [self.arsColorMenuView.backButton addTarget:self action:@selector(_pBackButtonTouched:)forControlEvents:UIControlEventTouchUpInside];
    [self.arsDefaultMenuView.paintBucketButton addTarget:self action:@selector(_pPaintBucketButtonTouched:)forControlEvents:UIControlEventTouchUpInside];
    [self.arsDefaultMenuView.eraseButton addTarget:self action:@selector(_pEraseButtonTouched:)forControlEvents:UIControlEventTouchUpInside];
    [self.arsDefaultMenuView.shareButton addTarget:self action:@selector(_pShareButtonTouched:)forControlEvents:UIControlEventTouchUpInside];
}

- (void)_pLayoutColorMenuView {
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

- (void)_pLayoutDefaultMenuView {
//    [self.arsDefaultMenuView setTranslatesAutoresizingMaskIntoConstraints:NO];
//    
//    //Left Edge Constraint
//    [self.view addConstraint:[NSLayoutConstraint
//                              constraintWithItem:self.arsDefaultMenuView
//                              attribute:NSLayoutAttributeLeft
//                              relatedBy:NSLayoutRelationEqual
//                              toItem:self.view
//                              attribute:NSLayoutAttributeLeft
//                              multiplier:1.0f
//                              constant:0.0f]];
//    
//    //Bottom Edge Constraint
//    [self.view addConstraint:[NSLayoutConstraint
//                              constraintWithItem:self.arsDefaultMenuView
//                              attribute:NSLayoutAttributeBottom
//                              relatedBy:NSLayoutRelationEqual
//                              toItem:self.view
//                              attribute:NSLayoutAttributeBottom
//                              multiplier:1.0f
//                              constant:0.0f]];
//    
//    //Right Edge Constraint
//    [self.view addConstraint:[NSLayoutConstraint
//                              constraintWithItem:self.arsDefaultMenuView
//                              attribute:NSLayoutAttributeRight
//                              relatedBy:NSLayoutRelationEqual
//                              toItem:self.view
//                              attribute:NSLayoutAttributeRight
//                              multiplier:1.0f
//                              constant:0.0f]];
//    
//    //Height Constraint
//    [self.view addConstraint:[NSLayoutConstraint
//                              constraintWithItem:self.arsDefaultMenuView
//                              attribute:NSLayoutAttributeHeight
//                              relatedBy:NSLayoutRelationEqual
//                              toItem:self.view
//                              attribute:NSLayoutAttributeHeight
//                              multiplier:0.15f
//                              constant:0.0f]];
    
    //Layout the buttons inside the reader view
    [self.arsDefaultMenuView layoutMenuItems];
}

- (void)_pUpdateBrushColor:(NSUInteger)hexValue {
    CGColorRef color = [[UIColor colorWithHexValue:hexValue] CGColor];
    const CGFloat *components = CGColorGetComponents(color);
    // Defer to the OpenGL view to set the brush color
	[self.arsPaintingview setBrushColorWithRed:components[0] green:components[1] blue:components[2]];
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

- (void)_pPaintBucketButtonTouched:(UIButton *) button {
    if ([self.arsDefaultMenuView isDescendantOfView:self.view])
    {
        [self.arsDefaultMenuView removeLayout];
        [self.view removeConstraints:self.view.constraints];
        [self.arsDefaultMenuView removeFromSuperview];
    }
    
    if (![self.arsColorMenuView isDescendantOfView:self.view])
    {
        [self.view addSubview:self.arsColorMenuView];
        [self _pLayoutColorMenuView];
    }
    
    [self.arsColorMenuView setHidden:NO];
}

- (void)_pEraseButtonTouched:(UIButton *) button {
    [self.arsPaintingview erase];
}

- (void)_pShareButtonTouched:(UIButton *) button {
    [self loadLocation];
}

- (void)_pBackButtonTouched:(UIButton *) button {
    [self.arsColorMenuView removeLayout];
    [self.view removeConstraints:self.view.constraints];
    [self.arsColorMenuView removeFromSuperview];
    [self.view addSubview:self.arsDefaultMenuView];
    [self _pLayoutDefaultMenuView];
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
    
    [self.arsDefaultMenuView removeFromSuperview];
    [self.arsColorMenuView removeFromSuperview];
    [self.arsPaintingview removeFromSuperview];
    [self.arsVideoView removeFromSuperview];
    
	NSLog(@"Received location %@ with accuracy %f", lastLocation, accuracy);
	if(accuracy < 100.0) {
		[manager stopUpdatingLocation];
        ARSFlipsideViewController *arsFlipsideViewController = [[ARSFlipsideViewController alloc] initWithLocation:lastLocation andDisplayView:self.arsPaintingview];
        [self.navigationController pushViewController:arsFlipsideViewController animated:YES];
	}
}

@end
