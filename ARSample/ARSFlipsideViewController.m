#import "ARSFlipsideViewController.h"
#import "MarkerView.h"

NSString * const kPhoneKey = @"formatted_phone_number";
NSString * const kWebsiteKey = @"website";

const int kInfoViewTag = 1001;

@interface ARSFlipsideViewController () <MarkerViewDelegate>

@property (nonatomic, strong) AugmentedRealityController *arController;
@property (nonatomic, strong) CLLocation *userLocation;
@property (nonatomic, strong) UIView *displayView;

@end

@implementation ARSFlipsideViewController

- (instancetype) initWithLocation:(CLLocation *) location andDisplayView:(UIView *) displayView
{
    self = [super init];
    self.userLocation = location;
    self.displayView = displayView;
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

	if(!_arController) {
		_arController = [[AugmentedRealityController alloc] initWithView:[self view] parentViewController:self withDelgate:self];
	}
	
	[_arController setMinimumScaleFactor:0.5];
	[_arController setScaleViewsBasedOnDistance:YES];
	[_arController setRotateViewsBasedOnPerspective:YES];
	[_arController setDebugMode:NO];
    
    
}

- (void)viewWillAppear:(BOOL)animated {
	[self generateGeoLocations];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Actions

- (NSMutableArray *)generateGeoLocations {
	
	ARGeoCoordinate *coordinate = [ARGeoCoordinate coordinateWithLocation:self.userLocation locationTitle:@"CurrentLocation"];
    [coordinate calibrateUsingOrigin:self.userLocation];
    MarkerView *markerView = [[MarkerView alloc] initWithCoordinate:coordinate withDisplayView:self.displayView andDelegate:self];
    NSLog(@"Marker view %@", markerView);
    
    [coordinate setDisplayView:markerView];
    [_arController addCoordinate:coordinate];
    
    NSMutableArray *geoLocations = [[NSMutableArray alloc] init];
    [geoLocations addObject:coordinate];
    return geoLocations;
}

#pragma mark - ARLocationDelegate

-(NSMutableArray *)geoLocations {
	NSMutableArray *geoLocations = [self generateGeoLocations];
	return geoLocations;
}

- (void)locationClicked:(ARGeoCoordinate *)coordinate {
	NSLog(@"Tapped location %@", coordinate);
}

#pragma mark - ARDelegate

-(void)didUpdateHeading:(CLHeading *)newHeading {
	
}

-(void)didUpdateLocation:(CLLocation *)newLocation {
	
}

-(void)didUpdateOrientation:(UIDeviceOrientation)orientation {
	
}

#pragma mark - ARMarkerDelegate

-(void)didTapMarker:(ARGeoCoordinate *)coordinate {
}

- (void)didTouchMarkerView:(MarkerView *)markerView {
}

@end
