#import <MapKit/MapKit.h>
#import "ARKit.h"

@class ARSFlipsideViewController;

@interface ARSFlipsideViewController : UIViewController <ARLocationDelegate, ARDelegate, ARMarkerDelegate>

- (instancetype) initWithLocation:(CLLocation *) location andDisplayView:(UIView *) displayView;

@end
