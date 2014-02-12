//
//  ARSViewController.m
//  ARSample
//
//  Created by Adithya Ravikumar on 12/8/13.
//  Copyright (c) 2013 Nothing. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "ARSViewController.h"
#import "ARSVideoView.h"
#import "ARSPaintingView.h"
#import "ARSFlipsideViewController.h"


#define kBrightness             1.0
#define kSaturation             0.45

#define kPaletteHeight			30
#define kPaletteSize			5
#define kMinEraseInterval		0.5

// Padding for margins
#define kLeftMargin				10.0
#define kTopMargin				10.0
#define kRightMargin			10.0

@interface ARSViewController ()<CLLocationManagerDelegate, MKMapViewDelegate>
@property (nonatomic, strong) ARSVideoView *arsVideoView;
@property (nonatomic, strong) ARSPaintingView *arsPaintingview;
@property (nonatomic, strong) CLLocationManager *locationManager;
@end

@implementation ARSViewController

- (void) loadView
{
    [super loadView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.arsVideoView = [[ARSVideoView alloc] initWithFrame:self.view.frame];
    self.arsPaintingview = [[ARSPaintingView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:self.arsVideoView];
    [self.view addSubview:self.arsPaintingview];
    [self.arsPaintingview setBackgroundColor:[UIColor clearColor]];
    [self loadSegmentedcontrol];
    [self loadButtons];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) loadSegmentedcontrol
{
    // Create a segmented control so that the user can choose the brush color.
	UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:
											[NSArray arrayWithObjects:
                                             [UIImage imageNamed:@"Red.png"],
                                             [UIImage imageNamed:@"Yellow.png"],
                                             [UIImage imageNamed:@"Green.png"],
                                             [UIImage imageNamed:@"Blue.png"],
                                             [UIImage imageNamed:@"Purple.png"],
                                             nil]];
    // Compute a rectangle that is positioned correctly for the segmented control you'll use as a brush color palette
    CGRect rect = [[UIScreen mainScreen] bounds];
	CGRect frame = CGRectMake(rect.origin.x + kLeftMargin, rect.size.height - kPaletteHeight - kTopMargin, rect.size.width - (kLeftMargin + kRightMargin), kPaletteHeight);
	segmentedControl.frame = frame;
	// When the user chooses a color, the method changeBrushColor: is called.
	[segmentedControl addTarget:self action:@selector(changeBrushColor:) forControlEvents:UIControlEventValueChanged];
	// Make sure the color of the color complements the black background
	segmentedControl.tintColor = [UIColor darkGrayColor];
	// Set the third color (index values start at 0)
	segmentedControl.selectedSegmentIndex = 2;
	
	// Add the control to the window
	[self.view addSubview:segmentedControl];
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

// Change the brush color
- (void)changeBrushColor:(id)sender
{
	// Define a new brush color
    CGColorRef color = [UIColor colorWithHue:(CGFloat)[sender selectedSegmentIndex] / (CGFloat)kPaletteSize
                                  saturation:kSaturation
                                  brightness:kBrightness
                                       alpha:1.0].CGColor;
    const CGFloat *components = CGColorGetComponents(color);
    
	// Defer to the OpenGL view to set the brush color
	[self.arsPaintingview setBrushColorWithRed:components[0] green:components[1] blue:components[2]];
    
}

// Called when receiving the "shake" notification; plays the erase sound and redraws the view
- (void)eraseView
{
	[self.arsPaintingview erase];
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
