//
//  ScrollViewButton.m
//  BuildADis
//
//  Created by USER USER on 9/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ScrollViewButton.h"


UIImageView *imageDoll7;
UIImageView *imageDoll8;
UIImageView *imageDoll6;
UIImageView *imageDoll5;
UIImageView *imageDoll4;

@implementation ScrollViewButton
@synthesize sv;
@synthesize btnImage;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    scrolling=[[TapScrollView alloc]initWithFrame:CGRectMake(0, 0, 320, 120)];
	[scrolling setScrollEnabled:YES];
    [scrolling setDelegate:self];
	[scrolling setContentSize:CGSizeMake(660,120)];
	[scrolling setPagingEnabled:YES];

    imageDoll7=[[UIImageView alloc]initWithFrame:CGRectMake(0, 50,60,60)];
	[imageDoll7 setUserInteractionEnabled:YES];
	UIImage *imageGirl7=[UIImage imageNamed:@"he.png"];
	[imageDoll7 setImage:imageGirl7];
	[scrolling addSubview:imageDoll7];
    
    imageDoll8=[[UIImageView alloc]initWithFrame:CGRectMake(110, 50,60,60)];
	[imageDoll8 setUserInteractionEnabled:YES];
	UIImage *imageGirl8=[UIImage imageNamed:@"she1.png"];
	[imageDoll8 setImage:imageGirl8];
	[scrolling addSubview:imageDoll8];
    
    imageDoll6=[[UIImageView alloc]initWithFrame:CGRectMake(220, 50,60,60)];
	[imageDoll6 setUserInteractionEnabled:YES];
	UIImage *imageGirl6=[UIImage imageNamed:@"they.png"];
	[imageDoll6 setImage:imageGirl6];
	[scrolling addSubview:imageDoll6];
    
    imageDoll5=[[UIImageView alloc]initWithFrame:CGRectMake(330, 50,60,60)];
	[imageDoll5 setUserInteractionEnabled:YES];
	UIImage *imageGirl5=[UIImage imageNamed:@"you.png"];
	[imageDoll5 setImage:imageGirl5];
	[scrolling addSubview:imageDoll5];
    
    imageDoll4=[[UIImageView alloc]initWithFrame:CGRectMake(440, 50,60,60)];
	[imageDoll4 setUserInteractionEnabled:YES];
	UIImage *imageGirl4=[UIImage imageNamed:@"yo-mama.png"];
	[imageDoll4 setImage:imageGirl4];
	[scrolling addSubview:imageDoll4];
    
    
    [self.view addSubview:scrolling];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    [self.navigationController setNavigationBarHidden:NO];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


-(void)touch
{
  
            
    //nslog(@"BtnClick the button sender ");
    
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	
       
    UITouch *touch = [[event allTouches] anyObject];
    CGPoint currentPoint =[touch locationInView:self.view];
    //nslog(@"the current point %f   %f",currentPoint.x,currentPoint.y);

	if ([touch view ]==imageDoll7) {
        
         //nslog(@"image the button sender ");
        
        imageDoll7.frame=CGRectMake(25, 70,30,30);
        UIImage *imageGirl7=[UIImage imageNamed:@"he.png"];
        [imageDoll7 setImage:imageGirl7];
     

    }
    
    if ([touch view ]==imageDoll8) {
        
        //nslog(@"image the button sender ");
        
        imageDoll8.frame=CGRectMake(130,70,30,30);
        UIImage *imageGirl7=[UIImage imageNamed:@"she1.png"];
        [imageDoll8 setImage:imageGirl7];
        
        
    }
    
    if ([touch view ]==imageDoll6) {
        
        //nslog(@"image the button sender ");
        
        imageDoll6.frame=CGRectMake(240, 70,30,30);
        UIImage *imageGirl7=[UIImage imageNamed:@"they.png"];
        [imageDoll6 setImage:imageGirl7];
        
        
    }
    
    if ([touch view ]==imageDoll5) {
        
        //nslog(@"image the button sender ");
        
        imageDoll5.frame=CGRectMake(350, 70,30,30);
        UIImage *imageGirl7=[UIImage imageNamed:@"you.png"];
        [imageDoll5 setImage:imageGirl7];
        
        
    }
    
    if ([touch view ]==imageDoll4) {
        
        //nslog(@"image the button sender ");
        
        imageDoll4.frame=CGRectMake(460, 70,30,30);
        UIImage *imageGirl7=[UIImage imageNamed:@"yo-mama.png"];
        [imageDoll4 setImage:imageGirl7];
        
        
    }
    //nslog(@"scrolling  %f",scrolling.contentSize.width);
    
    
    [scrolling setContentOffset:CGPointMake(100, 0)];
}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	 //nslog(@"touchesMoved");
    
}

- (void)touchesEnded: (NSSet *) touches withEvent: (UIEvent *) event 
{	
     //nslog(@"touchesEnded");
    UITouch *touch = [[event allTouches] anyObject];
	if ([touch view ]==imageDoll7) {
        
           imageDoll7.frame=CGRectMake(0, 50,60,60);
        UIImage *imageGirl7=[UIImage imageNamed:@"he.png"];
        [imageDoll7 setImage:imageGirl7];
        
        
    }
    
    if ([touch view ]==imageDoll8) {
        
         imageDoll8.frame=CGRectMake(110, 50,60,60);
        UIImage *imageGirl7=[UIImage imageNamed:@"she1.png"];
        [imageDoll8 setImage:imageGirl7];
        
        
    }
    
    if ([touch view ]==imageDoll6) {
        
        imageDoll6.frame=CGRectMake(220, 50,60,60);
        UIImage *imageGirl7=[UIImage imageNamed:@"they.png"];
        [imageDoll6 setImage:imageGirl7];
        
        
    }
    
    if ([touch view ]==imageDoll5) {
        
        imageDoll5.frame=CGRectMake(330, 50,60,60);
        UIImage *imageGirl7=[UIImage imageNamed:@"you.png"];
        [imageDoll5 setImage:imageGirl7];
        
        
    }
    
    if ([touch view ]==imageDoll4) {
        
         imageDoll4.frame=CGRectMake(440, 50,60,60);
        UIImage *imageGirl7=[UIImage imageNamed:@"yo-mama.png"];
        [imageDoll4 setImage:imageGirl7];
        
        
    }

	
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
