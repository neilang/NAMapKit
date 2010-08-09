#import "DemoViewController.h"

@implementation DemoViewController

@synthesize mapView;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	
	[mapView displayMap:[UIImage imageNamed:@"australia.png"]];
	
	// Set the background the same colour blue as the water
	mapView.backgroundColor = [UIColor colorWithRed:0.0f green:0.475f blue:0.761 alpha:1.0f];
	
	NAAnnotation * melbourne = [NAAnnotation annotationWithPoint:CGPointMake(543, 489)];
	melbourne.title = @"Melbourne";
	melbourne.subtitle = @"I have a subtitle";
	[mapView addAnnotation:melbourne];
	
	NAAnnotation * perth = [NAAnnotation annotationWithPoint:CGPointMake(63, 379)];
	perth.title = @"Perth";
	
	// Setting disclosure buttons doesn't currently work, hopefully this will be fixed update soon
	// perth.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
	
	[mapView addAnnotation:perth];
	
	NAAnnotation * brisbane = [NAAnnotation annotationWithPoint:CGPointMake(679, 302)];
	brisbane.title = @"Brisbane";
	[mapView addAnnotation:brisbane];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (void)dealloc {
    [super dealloc];
}

@end
