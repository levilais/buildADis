//
//  HudView.m
//  HudView
//


#import "HudView.h"
#import <QuartzCore/QuartzCore.h>


UIActivityIndicatorView *activityIndicatorView;
CATransition *animation;
CGPathRef HudViewNewPathWithRoundRect(CGRect rect, CGFloat cornerRadius)
{
	//
	// Create the boundary path
	//
	CGMutablePathRef path = CGPathCreateMutable();
	CGPathMoveToPoint(path, NULL,
					  rect.origin.x,
					  rect.origin.y + rect.size.height - cornerRadius);
	
	// Top left corner
	CGPathAddArcToPoint(path, NULL,
						rect.origin.x,
						rect.origin.y,
						rect.origin.x + rect.size.width,
						rect.origin.y,
						cornerRadius);
	
	// Top right corner
	CGPathAddArcToPoint(path, NULL,
						rect.origin.x + rect.size.width,
						rect.origin.y,
						rect.origin.x + rect.size.width,
						rect.origin.y + rect.size.height,
						cornerRadius);
	
	// Bottom right corner
	CGPathAddArcToPoint(path, NULL,
						rect.origin.x + rect.size.width,
						rect.origin.y + rect.size.height,
						rect.origin.x,
						rect.origin.y + rect.size.height,
						cornerRadius);
	
	// Bottom left corner
	CGPathAddArcToPoint(path, NULL,
						rect.origin.x,
						rect.origin.y + rect.size.height,
						rect.origin.x,
						rect.origin.y,
						cornerRadius);
	
	// Close the path at the rounded rect
	CGPathCloseSubpath(path);
	
	return path;
}

@implementation HudView
@synthesize loadingLabel,loadingView;

- (id)loadingViewInView:(UIView *)aSuperview text:(NSString*)hudText
{
	
	
	loadingView = [[HudView alloc] initWithFrame:CGRectMake(40, 220, 240,50 )];
	if (!loadingView)
	{
		return nil;
	}
	
	
	loadingView.opaque = NO;
	loadingView.autoresizingMask =0;
		//UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	//[aSuperview setUserInteractionEnabled:NO];
	[aSuperview addSubview:loadingView];
	


	const CGFloat DEFAULT_LABEL_WIDTH = 155;
	const CGFloat DEFAULT_LABEL_HEIGHT = 30;
	CGRect labelFrame = CGRectMake(60 ,  8, DEFAULT_LABEL_WIDTH, DEFAULT_LABEL_HEIGHT);
	loadingLabel =[[UILabel alloc]initWithFrame:labelFrame];
	
	loadingLabel.text = hudText;
	loadingLabel.textColor = [UIColor whiteColor];
	loadingLabel.backgroundColor = [UIColor clearColor];
	loadingLabel.textAlignment = UITextAlignmentCenter;
	loadingLabel.numberOfLines = 2;
	loadingLabel.font = [UIFont boldSystemFontOfSize:14];
	loadingLabel.autoresizingMask =
		UIViewAutoresizingFlexibleLeftMargin |
		UIViewAutoresizingFlexibleRightMargin |
		UIViewAutoresizingFlexibleTopMargin |
		UIViewAutoresizingFlexibleBottomMargin;
	[loadingView setBackgroundColor:[UIColor clearColor]];
    
	[loadingView addSubview:loadingLabel];
	activityIndicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(30, 10, 30,30)];
	[activityIndicatorView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
			//initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge]autorelease];
	[loadingView addSubview:activityIndicatorView];
	activityIndicatorView.autoresizingMask =
		UIViewAutoresizingFlexibleLeftMargin |
		UIViewAutoresizingFlexibleRightMargin |
		UIViewAutoresizingFlexibleTopMargin |
		UIViewAutoresizingFlexibleBottomMargin;
	[activityIndicatorView startAnimating];
	
	
	// Set up the fade-in animation
	animation = [CATransition animation];
	[animation setType:kCATransitionFade];
	[[aSuperview layer] addAnimation:animation forKey:@"layerAnimation"];
    loadingView.backgroundColor=[UIColor clearColor];
	loadingView.alpha = 1;
	return loadingView;
}


- (void)removeView
{
	
	UIView *aSuperview = [self superview];
	[super removeFromSuperview];
	[aSuperview setUserInteractionEnabled:YES];
	
	CATransition *animation = [CATransition animation];
	[animation setType:kCATransitionFade];
	
	[[aSuperview layer] addAnimation:animation forKey:@"layerAnimation"];
}

-(void)setUserInteractionEnabledForSuperview:(UIView *)aSuperview
{
	//loadingLabel.alpha = 0;
	[aSuperview setUserInteractionEnabled:YES];
	//[self setUserInteractionEnabled:YES];
	//[self.loadingView removeFromSuperview];
	
}
-(void)setUserInteractionEnabledNoForSuperview:(UIView *)aSuperview
{
	//loadingLabel.alpha = 0;
	[aSuperview setUserInteractionEnabled:NO];
	//[self setUserInteractionEnabled:YES];
	//[self.loadingView removeFromSuperview];
	
}

- (void)drawRect:(CGRect)rect
{
	rect.size.height -= 1;
	rect.size.width -= 1;
	
	const CGFloat RECT_PADDING = 8.0;
	rect = CGRectInset(rect, RECT_PADDING, RECT_PADDING);
	
	const CGFloat ROUND_RECT_CORNER_RADIUS = 8.0;
	CGPathRef roundRectPath = HudViewNewPathWithRoundRect(rect, ROUND_RECT_CORNER_RADIUS);
	
	CGContextRef context = UIGraphicsGetCurrentContext();

	const CGFloat BACKGROUND_OPACITY = 0.4f;
	CGContextSetRGBFillColor(context, 0, 0, 0, BACKGROUND_OPACITY);
	CGContextAddPath(context, roundRectPath);
	CGContextFillPath(context);

	const CGFloat STROKE_OPACITY = 0;
	CGContextSetRGBStrokeColor(context, 1, 1, 1, STROKE_OPACITY);
	CGContextAddPath(context, roundRectPath);
	CGContextStrokePath(context);
	
	CGPathRelease(roundRectPath);
}



@end
