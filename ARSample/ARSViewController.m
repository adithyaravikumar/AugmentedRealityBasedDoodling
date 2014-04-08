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
#import "ARSBrushMenuView.h"
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
@property (nonatomic, strong) ARSBrushMenuView *arsBrushMenuView;
@property NSInteger colorSlideIndex;
@property NSInteger brushSlideIndex;
@property BOOL firstLoad;
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
    self.arsBrushMenuView = [[ARSBrushMenuView alloc] initWithFrame:CGRectMake(0, 410, self.view.frame.size.width, self.view.frame.size.height * 0.15)];
    
    //Set the orange brush as selected by default when entering the screen and set brush color to orange
    [self _pAddEventHandlersToButtons];
    [self.arsColorMenuView.orangeBrushButton setSelected:YES];
    [self _pUpdateBrushColor:TBNOrangeBrushColor];
    self.colorSlideIndex = 0;
    self.brushSlideIndex = 0;
    self.firstLoad = YES;
    [self.arsPaintingview setBackgroundColor:[UIColor clearColor]];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (![self.arsVideoView isDescendantOfView:self.view])
    {
        [self.view addSubview:self.arsVideoView];
    }
    
    [self.view addSubview:self.arsPaintingview];
    [self.view addSubview:self.arsDefaultMenuView];
    [self.arsDefaultMenuView layoutMenuItems];
}

- (void)viewDidAppear:(BOOL)animated
{
    if (!self.firstLoad) {
        [self.arsVideoView setupVideo];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)_pAddEventHandlersToButtons {
    
    //default menu view
    [self.arsDefaultMenuView.paintBucketButton addTarget:self action:@selector(_pPaintBucketButtonTouched:)forControlEvents:UIControlEventTouchUpInside];
    [self.arsDefaultMenuView.paintBrushButton addTarget:self action:@selector(_pPaintBrushButtonTouched:)forControlEvents:UIControlEventTouchUpInside];
    [self.arsDefaultMenuView.eraseButton addTarget:self action:@selector(_pEraseButtonTouched:)forControlEvents:UIControlEventTouchUpInside];
    [self.arsDefaultMenuView.shareButton addTarget:self action:@selector(_pShareButtonTouched:)forControlEvents:UIControlEventTouchUpInside];
    
    //color menu view
    [self.arsColorMenuView.orangeBrushButton addTarget:self action:@selector(_pOrangeBrushButtonTouched:)forControlEvents:UIControlEventTouchUpInside];
    [self.arsColorMenuView.greenBrushButton addTarget:self action:@selector(_pGreenBrushButtonTouched:)forControlEvents:UIControlEventTouchUpInside];
    [self.arsColorMenuView.purpleBrushButton addTarget:self action:@selector(_pPurpleBrushButtonTouched:)forControlEvents:UIControlEventTouchUpInside];
    [self.arsColorMenuView.yellowBrushButton addTarget:self action:@selector(_pYellowBrushButtonTouched:)forControlEvents:UIControlEventTouchUpInside];
    [self.arsColorMenuView.blueBrushButton addTarget:self action:@selector(_pBlueBrushButtonTouched:)forControlEvents:UIControlEventTouchUpInside];
    [self.arsColorMenuView.backButton addTarget:self action:@selector(_pColorSelectionBackButtonTouched:)forControlEvents:UIControlEventTouchUpInside];
    
    //brush menu view
    [self.arsBrushMenuView.particleButton addTarget:self action:@selector(_pParticleBrushButtonTouched:)forControlEvents:UIControlEventTouchUpInside];
    [self.arsBrushMenuView.blockButton addTarget:self action:@selector(_pBlockBrushButtonTouched:)forControlEvents:UIControlEventTouchUpInside];
    [self.arsBrushMenuView.discButton addTarget:self action:@selector(_pDiscBrushButtonTouched:)forControlEvents:UIControlEventTouchUpInside];
    [self.arsBrushMenuView.starButton addTarget:self action:@selector(_pStarBrushButtonTouched:)forControlEvents:UIControlEventTouchUpInside];
    [self.arsBrushMenuView.backButton addTarget:self action:@selector(_pBrushSelectionBackButtonTouched:)forControlEvents:UIControlEventTouchUpInside];
}

- (void)_pUpdateBrushColor:(NSUInteger)hexValue {
    CGColorRef color = [[UIColor colorWithHexValue:hexValue] CGColor];
    const CGFloat *components = CGColorGetComponents(color);
    // Defer to the OpenGL view to set the brush color
	[self.arsPaintingview setBrushColorWithRed:components[0] green:components[1] blue:components[2]];
}

#pragma mark - Event Handlers for the buttons

//COLOR MENU
- (void)_pOrangeBrushButtonTouched:(UIButton *) button {
    self.colorSlideIndex = 0;
    [self.arsColorMenuView slideColorBorderWithSlideIndex:self.colorSlideIndex];
    [self _pUpdateBrushColor:TBNOrangeBrushColor];
}


- (void)_pGreenBrushButtonTouched:(UIButton *) button {
    self.colorSlideIndex = 1;
    [self.arsColorMenuView slideColorBorderWithSlideIndex:self.colorSlideIndex];
    [self _pUpdateBrushColor:TBNGreenBrushColor];
}


- (void)_pPurpleBrushButtonTouched:(UIButton *) button {
    self.colorSlideIndex = 2;
    [self.arsColorMenuView slideColorBorderWithSlideIndex:self.colorSlideIndex];
    [self _pUpdateBrushColor:TBNPurpleBrushColor];
}


- (void)_pYellowBrushButtonTouched:(UIButton *) button {
    self.colorSlideIndex = 3;
    [self.arsColorMenuView slideColorBorderWithSlideIndex:self.colorSlideIndex];
    [self _pUpdateBrushColor:TBNYellowBrushColor];
}


- (void)_pBlueBrushButtonTouched:(UIButton *) button {
    self.colorSlideIndex = 4;
    [self.arsColorMenuView slideColorBorderWithSlideIndex:self.colorSlideIndex];
    [self _pUpdateBrushColor:TBNBlueBrushColor];
}


- (void)_pColorSelectionBackButtonTouched:(UIButton *) button {
    [self.arsColorMenuView removeLayout];
    [self.view removeConstraints:self.view.constraints];
    [self.arsColorMenuView removeFromSuperview];
    [self.view addSubview:self.arsDefaultMenuView];
    [self.arsDefaultMenuView layoutMenuItems];
}

//BRUSH MENU
- (void)_pParticleBrushButtonTouched:(UIButton *) button {
    self.brushSlideIndex = 0;
    [self.arsBrushMenuView slideColorBorderWithSlideIndex:self.brushSlideIndex];
    [self.arsPaintingview setBrushTextureWithTextureName:@"ParticleTexture.png"];
}

- (void)_pBlockBrushButtonTouched:(UIButton *) button {
    self.brushSlideIndex = 1;
    [self.arsBrushMenuView slideColorBorderWithSlideIndex:self.brushSlideIndex];
    [self.arsPaintingview setBrushTextureWithTextureName:@"BlockTexture.png"];
}

- (void)_pDiscBrushButtonTouched:(UIButton *) button {
    self.brushSlideIndex = 2;
    [self.arsBrushMenuView slideColorBorderWithSlideIndex:self.brushSlideIndex];
    [self.arsPaintingview setBrushTextureWithTextureName:@"DiscTexture.png"];
}

- (void)_pStarBrushButtonTouched:(UIButton *) button {
    self.brushSlideIndex = 3;
    [self.arsBrushMenuView slideColorBorderWithSlideIndex:self.brushSlideIndex];
    [self.arsPaintingview setBrushTextureWithTextureName:@"StarTexture.png"];
}

- (void)_pBrushSelectionBackButtonTouched:(UIButton *) button {
    [self.arsBrushMenuView removeLayout];
    [self.view removeConstraints:self.view.constraints];
    [self.arsBrushMenuView removeFromSuperview];
    [self.view addSubview:self.arsDefaultMenuView];
    [self.arsDefaultMenuView layoutMenuItems];
}

//DEFAULT MENU
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
        [self.arsColorMenuView layoutMenuButtons];
        [self.arsColorMenuView slideColorBorderWithSlideIndex:self.colorSlideIndex];
    }
}

- (void)_pPaintBrushButtonTouched:(UIButton *)button {
    if ([self.arsDefaultMenuView isDescendantOfView:self.view])
    {
        [self.arsDefaultMenuView removeLayout];
        [self.view removeConstraints:self.view.constraints];
        [self.arsDefaultMenuView removeFromSuperview];
    }
    
    if (![self.arsBrushMenuView isDescendantOfView:self.view])
    {
        [self.view addSubview:self.arsBrushMenuView];
        [self.arsBrushMenuView layoutMenuItems];
        [self.arsBrushMenuView slideColorBorderWithSlideIndex:self.brushSlideIndex];
    }
}

- (void)_pEraseButtonTouched:(UIButton *) button {
    [self.arsPaintingview erase];
}

- (void)_pShareButtonTouched:(UIButton *) button {
    [self loadLocation];
}

#pragma mark - Location Specific Methods

- (void) loadLocation
{
    [self setLocationManager:[[CLLocationManager alloc] init]];
	[self.locationManager setDelegate:self];
	[self.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
	[self.locationManager startUpdatingLocation];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
	CLLocation *lastLocation = [locations lastObject];
	CLLocationAccuracy accuracy = [lastLocation horizontalAccuracy];
    
    [self.arsDefaultMenuView removeFromSuperview];
    [self.arsColorMenuView removeFromSuperview];
    [self.arsPaintingview removeFromSuperview];
    
    [self.arsVideoView stopSession];
    
	NSLog(@"Received location %@ with accuracy %f", lastLocation, accuracy);
	if(accuracy < 100.0) {
		[manager stopUpdatingLocation];
        self.firstLoad = NO;
        ARSFlipsideViewController *arsFlipsideViewController = [[ARSFlipsideViewController alloc] initWithLocation:lastLocation andDisplayView:self.arsPaintingview];
        [self.navigationController pushViewController:arsFlipsideViewController animated:YES];
	}
}

@end
