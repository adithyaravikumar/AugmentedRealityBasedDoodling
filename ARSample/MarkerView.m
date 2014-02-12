#import "MarkerView.h"
#import "ARGeoCoordinate.h"

const float kWidth = 200.0f;
const float kHeight = 100.0f;

@interface MarkerView ()

@property (nonatomic, strong) UILabel *lblDistance;

@end


@implementation MarkerView

UITouch *touch;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (id)initWithCoordinate:(ARGeoCoordinate *)coordinate withDisplayView:(UIView *) displayView andDelegate:(id<MarkerViewDelegate>)delegate {
	if((self = [super initWithFrame:CGRectMake(0.0f, 0.0f, kWidth, kHeight)])) {
        
		_coordinate = coordinate;
		_delegate = delegate;
		
		self.displayImageview = displayView;
		
		[self addSubview:self.displayImageview];
        
		[self setBackgroundColor:[UIColor clearColor]];
	}

	return self;
}

- (void)drawRect:(CGRect)rect {
	[super drawRect:rect];
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    touch = [touches anyObject];
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	if(_delegate && [_delegate conformsToProtocol:@protocol(MarkerViewDelegate)]) {
		[_delegate didTouchMarkerView:self];
	}
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    
    CGRect theFrame = CGRectMake(0, 0, kWidth, kHeight);
    
	return CGRectContainsPoint(theFrame, point);
}

@end
