//
//  HomeScreenView.m
//  PicAPal
//
//  Created by USER USER on 8/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HomeScreenView.h"
#import "ShopView.h"
#import "PopulatorView.h"
#import "Reachability.h"
#import "UIDevice+Resolutions.h"
#import "ScrollViewButton.h"
#import "AppDelegate.h"
#import "SA_OAuthTwitterController.h"



int largeSize = 10, mediumSize = 20, smallSize = 30, imageWidthHeight = 50;
int preX=0;                     //For determining Scrolling direction.
BOOL CheckPopUp;
BOOL checkStore;

NSString *strURLShow;

BOOL showPopUpOneTime;
//UIbutton to show on Picker
UIButton *btn;

//Nsstring to get ip Address
NSString *address;

//mutable string to send string by a mail
NSMutableString *MailString;

// nsstring to get select subject and Selected target
NSString *strSubject,*strTarget;

//Bool for twitter Share
BOOL bool_TwitterShare;


@implementation HomeScreenView


@synthesize scrollViewTarget,scrollViewSubjects;
@synthesize pickerSubject;
@synthesize viewActionSheet, label, currentImage1, currentImage2,lblSubText;
@synthesize scrollView1, scrollView2;
@synthesize scrollViewCust1;
@synthesize scrollViewCust2;
@synthesize imageViewBanner,btnShop,btnShare,btnPopulatore;
@synthesize lblShowLine1,lblShowLine2;

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
    ///////======App delegate
    AppDelegate *delegateApp=(AppDelegate *)[UIApplication sharedApplication].delegate;
    
    [self performSelector:@selector(checkInAppPopUp) withObject:nil afterDelay:0.5];
    ///////======== Check iAd purchased or not
    
    
    if ([UIDevice currentResolution]==UIDevice_iPhoneTallerHiRes ) {
    }
    
    ////========= Add code for scrollview1  Code =========////////
    
    arrayOftargetImages = [[NSArray alloc] initWithObjects:                 //Initializing Images
                           [UIImage imageNamed:@"you.png"],
                           [UIImage imageNamed:@"he.png"],
                           [UIImage imageNamed:@"she1.png"],
                           [UIImage imageNamed:@"they.png"],
                           [UIImage imageNamed:@"yo-mama.png"], nil];
    
    
    arrayOfSubjectImages = [[NSArray alloc] initWithObjects: [UIImage imageNamed:@"fat.png"],[UIImage imageNamed:@"skinny.png"],[UIImage imageNamed:@"ugly.png"],[UIImage imageNamed:@"dumb.png"],[UIImage imageNamed:@"old.png"],[UIImage imageNamed:@"poor.png"],
                            [UIImage imageNamed:@"random.png"],nil];
    
    // add target text and subject texts
    arraytargetText=[[NSArray alloc]initWithObjects:@"You",@"He",@"She",@"They",@"Yo Mama",nil];
    arraySubjectText=[[NSArray alloc]initWithObjects:@"Fat",@"Skinny",@"Ugly",@"Dumb",@"Old",@"Poor",@"Random",nil];
    
    UILabel *lbl1=[[UILabel alloc]initWithFrame:CGRectMake(-200, 00, 1100, 02)];
    lbl1.backgroundColor=[UIColor blackColor];
    UILabel *lbl2=[[UILabel alloc]initWithFrame:CGRectMake(-200, 00, 1500, 02)];
    lbl2.backgroundColor=[UIColor blackColor];
    
    
    if ([UIDevice currentResolution]==UIDevice_iPhoneTallerHiRes ) {
        
        imageViewBanner.frame=CGRectMake(0, 0, 320, 140);
        btnPopulatore.frame=CGRectMake(83, 437,148 , 82);
        btnShare.frame=CGRectMake(20, 449, 55, 55);
        btnShop.frame=CGRectMake(245, 449, 55, 55);
        lblShowLine1.frame=CGRectMake(0, 275, 320, 2);
        lblShowLine2.frame=CGRectMake(0, 415, 320, 2);
        scrollViewCust1 =[[CustomScrollView alloc]initWithFrame:CGRectMake(0, 175, 320, 100)];
        scrollViewCust2 =[[CustomScrollView alloc]initWithFrame:CGRectMake(0, 313, 320, 102)];
    
        
    }else
    {
        imageViewBanner.frame=CGRectMake(0, 0, 320, 140);
        lblShowLine1.frame=CGRectMake(0, 245, 320, 2);
        lblShowLine2.frame=CGRectMake(0, 360, 320, 2);
        btnPopulatore.frame=CGRectMake(83, 363,148 , 82);
        btnShare.frame=CGRectMake(20, 375, 55, 55);
        btnShop.frame=CGRectMake(245, 376, 55, 55);
        scrollViewCust1 =[[CustomScrollView alloc]initWithFrame:CGRectMake(0, 145, 320, 100)];
        scrollViewCust2 =[[CustomScrollView alloc]initWithFrame:CGRectMake(0, 258, 320, 102)];
        
    }
    
    
    
    //scrollViewCust1 =[[CustomScrollView alloc]initWithFrame:CGRectMake(0, 110, 320, 100)];
    scrollViewCust1.backgroundColor=[UIColor  whiteColor];
    [scrollViewCust1 imageSizesSmall:50 Medium:50 LargeSize:70];
    [scrollViewCust1 addImageViewss:arrayOftargetImages withLabels:arraytargetText fontSize:12 labelAsHeader:NO DistanceBetweenImages:28];
    [scrollViewCust1 addSubview:lbl1];
    [scrollViewCust1 doCustomInitialization];
    [self.view addSubview:scrollViewCust1];
    
    ///scrollViewCust2 =[[CustomScrollView alloc]initWithFrame:CGRectMake(0, 223, 320, 102)];
    scrollViewCust2.backgroundColor=[UIColor  whiteColor];
    [scrollViewCust2 imageSizesSmall:50 Medium:50 LargeSize:70];
    [scrollViewCust2 addImageViewss:arrayOfSubjectImages withLabels:arraySubjectText fontSize:12 labelAsHeader:NO DistanceBetweenImages:28];
    [scrollViewCust2 addSubview:lbl2];
    [scrollViewCust2 doCustomInitialization];
    [self.view addSubview:scrollViewCust2];
    
    
    scrollView1=[[TapScrollView alloc]init];                //Initializing ScrollView1
    [scrollView1 setDelegate:self];
    scrollView1.frame = CGRectMake(0, 124, 320, 102);
    scrollView1.showsHorizontalScrollIndicator = NO;
    scrollView1.backgroundColor=[UIColor whiteColor];
    
    scrollView1.showsVerticalScrollIndicator = NO;
    scrollView1.tag = 1;
    
    scrollView2=[[TapScrollView alloc]init];                //Initializing ScroolView2
    [scrollView2 setDelegate:self];
    scrollView2.frame = CGRectMake(0, 245, 320, 102);
    scrollView2.showsHorizontalScrollIndicator = NO;
    scrollView2.backgroundColor=[UIColor whiteColor];
    scrollView2.showsVerticalScrollIndicator = NO;
    scrollView2.tag = 2;
    
    int x = 130;                                             //Temporary Variables
    int y = mediumSize;
    
    for (UIImage *image in arrayOftargetImages)                      //Adding Images to scrollviews
    {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.frame = CGRectMake(x, y, imageWidthHeight, imageWidthHeight);
        [scrollView1 addSubview:imageView];
        
        x = x + 100;
        scrollView1.contentSize = CGSizeMake(x+100, 100);
    }
    
    x = 130;                                             //Temporary Variables
    y = mediumSize;
    
    for (UIImage *image in arrayOfSubjectImages)                      //Adding Images to scrollviews
    {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        imageView.frame = CGRectMake(x, y, imageWidthHeight, imageWidthHeight);
        [scrollView2 addSubview:imageView];
        
        x = x + 100;
        scrollView2.contentSize = CGSizeMake(x+100, 100);
    }
    x = 118;
    y = 82;
    
    for (NSString *name in arraytargetText)                       //Adding Text to scrollviews
    {
        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(x, y, 80, 20)];
        label1.text = name;
        label1.textAlignment=UITextAlignmentCenter;
        label1.backgroundColor = [UIColor clearColor];
        label1.font=[UIFont systemFontOfSize:14];
        [scrollView1 addSubview:label1];
        x = x + 100;
    }
    x = 118;
    y = 82;
    for (NSString *name in arraySubjectText)                       //Adding Text to scrollviews
    {
        UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(x, y, 80, 20)];
        label2.text = name;
        label2.textAlignment=UITextAlignmentCenter;
        label2.backgroundColor = [UIColor clearColor];
        label2.font=[UIFont systemFontOfSize:14];
        [scrollView2 addSubview:label2];
        x = x + 100;
    }
    currentImage1 = [scrollView1.subviews objectAtIndex:0];
    currentImage2 = [scrollView2.subviews objectAtIndex:0];
    
    [currentImage1 setFrame:CGRectMake(currentImage1.frame.origin.x-(mediumSize-largeSize),
                                       currentImage1.frame.origin.y-(mediumSize-largeSize),
                                       imageWidthHeight+(mediumSize-largeSize)*2,
                                       imageWidthHeight+(mediumSize-largeSize)*2)];   //Setting current Image
    [currentImage2 setFrame:CGRectMake(currentImage2.frame.origin.x-(mediumSize-largeSize),
                                       currentImage2.frame.origin.y-(mediumSize-largeSize),
                                       imageWidthHeight+(mediumSize-largeSize)*2,
                                       imageWidthHeight+(mediumSize-largeSize)*2)];   //Setting current Image
    selectedIndexScrollView1 = 0;
    selectedIndexScrollView2 = 0;
    UITapGestureRecognizer *tapRecognizer1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];                                                //Adding Gesture Recognizer
    UITapGestureRecognizer *tapRecognizer2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];                                                //Adding Gesture Recognizer
    [scrollView1 addGestureRecognizer:tapRecognizer1];
    [scrollView2 addGestureRecognizer:tapRecognizer2];
    
    //[self.view addSubview:scrollView1];
    // [self.view addSubview:scrollView2];
    
    /////=========UIview to show action sheet ===========////////
    
    if ([UIDevice currentResolution]==UIDevice_iPhoneTallerHiRes ) {
        
        viewActionSheet=[[UIView alloc]initWithFrame:CGRectMake(0, 568, 320, 290)];
        
    }else
    {
        viewActionSheet=[[UIView alloc]initWithFrame:CGRectMake(0, 460, 320, 290)];
    }
    
    // viewActionSheet=[[UIView alloc]initWithFrame:CGRectMake(0, 460, 320, 290)];
    [viewActionSheet setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"pop_ups.png"]]];
    
    
    ////======= UIbutton to show share on facebok========//////
    
    UIButton *btnFaceBook=[UIButton buttonWithType:UIButtonTypeCustom];
    btnFaceBook.frame=CGRectMake(15, 15,290 , 50);
    [btnFaceBook addTarget:self action:@selector(PostingOnFacebookButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [btnFaceBook setImage:[UIImage imageNamed:@"fb.png"] forState:UIControlStateNormal];
    [viewActionSheet addSubview:btnFaceBook];
    
    
    ////======= UIbutton to show share on Twitter========//////
    UIButton *btnTwitter=[UIButton buttonWithType:UIButtonTypeCustom];
    btnTwitter.frame=CGRectMake(15, 75,290 , 50);
    [btnTwitter addTarget:self action:@selector(shareFeeds) forControlEvents:UIControlEventTouchUpInside];
    [btnTwitter setImage:[UIImage imageNamed:@"twitter.png"] forState:UIControlStateNormal];
    [viewActionSheet addSubview:btnTwitter];
    
    
    ////======= UIbutton to show share By a mail========//////
    UIButton *btnEmail=[UIButton buttonWithType:UIButtonTypeCustom];
    btnEmail.frame=CGRectMake(15, 135,290 , 50);
    [btnEmail addTarget:self action:@selector(showmailPicker) forControlEvents:UIControlEventTouchUpInside];
    [btnEmail setImage:[UIImage imageNamed:@"gmail.png"] forState:UIControlStateNormal];
    [viewActionSheet addSubview:btnEmail];
    
    
    ////======= UIbutton to Hide View========//////
    UIButton *btnCancel=[UIButton buttonWithType:UIButtonTypeCustom];
    btnCancel.frame=CGRectMake(20, 195,270 , 40);
    [btnCancel addTarget:self action:@selector(cancelView) forControlEvents:UIControlEventTouchUpInside];
    [btnCancel setImage:[UIImage imageNamed:@"cancle_btn.png"] forState:UIControlStateNormal];
    [viewActionSheet addSubview:btnCancel];
    //cancle_btn.png
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_texture.png"]]];
    
    [self.view addSubview:viewActionSheet];
}
-(void)checkInAppPopUp
{
    AppDelegate *delegateApp=(AppDelegate *)[UIApplication sharedApplication].delegate;
    
    
    for (int i=0; i<[delegateApp.arrayPopInfo count]; i++) {
        
        NSString *strShowPopUp=[NSString stringWithFormat:@"%@",[[delegateApp.arrayPopInfo objectAtIndex:i]objectForKey:@"Location"]];
        if ([strShowPopUp isEqualToString:@"Upon Loading"]) {
            
            NSString *strOneX=[[NSUserDefaults standardUserDefaults]objectForKey:@"key_onex"];
            
            NSString *strPreTarget = [[NSUserDefaults standardUserDefaults] objectForKey:@"target_upon"];
            
            NSString *strTarget = [[delegateApp.arrayPopInfo objectAtIndex:i]objectForKey:@"target"];
            
            NSString *strDuration = [[delegateApp.arrayPopInfo objectAtIndex:i]objectForKey:@"Duration"];
            
            if (![strOneX isEqualToString:@"1x"] || [strDuration isEqualToString:@"Every Time"] || ![strTarget isEqualToString:strPreTarget])
            {
                [[NSUserDefaults standardUserDefaults] setObject:strDuration forKey:@"key_onex"];
                [[NSUserDefaults standardUserDefaults] setObject:strTarget forKey:@"target_upon"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                NSString *strLink=[NSString stringWithFormat:@"%@",[[delegateApp.arrayPopInfo objectAtIndex:i]objectForKey:@"target"]];
                
                if ([strLink isEqualToString:@"Store"]) {
                    CheckPopUp=YES;
                    checkStore=YES;
                    UIAlertView*  alert=[[UIAlertView alloc]initWithTitle:[[delegateApp.arrayPopInfo objectAtIndex:i]objectForKey:@"subject"] message:[[delegateApp.arrayPopInfo objectAtIndex:i]objectForKey:@"text"] delegate:self cancelButtonTitle:@"No, Thanks" otherButtonTitles:@"Ok", nil];
                    alert.tag = i;
                    [alert show];
                    
                    
                }else
                {
                    CheckPopUp=YES;
                    strURLShow=[NSString stringWithFormat:@"%@",[[delegateApp.arrayPopInfo objectAtIndex:i]objectForKey:@"target"]];
                    UIAlertView*  alert=[[UIAlertView alloc]initWithTitle:[[delegateApp.arrayPopInfo objectAtIndex:i]objectForKey:@"subject"] message:[[delegateApp.arrayPopInfo objectAtIndex:i]objectForKey:@"text"] delegate:self cancelButtonTitle:@"No, Thanks" otherButtonTitles:@"Ok", nil];
                    alert.tag = i;
                    [alert show];
                    
                }
            }
        }
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    AppDelegate *delegateApp=(AppDelegate *)[UIApplication sharedApplication].delegate;
    
    if (delegateApp.checkForHoneScreen==YES) {
        
        /////=========UIview to show action sheet ===========////////
        
        if ([UIDevice currentResolution]==UIDevice_iPhoneTallerHiRes ) {
            
            viewActionSheet=[[UIView alloc]initWithFrame:CGRectMake(0, 568, 320, 290)];
            
        }else
        {
            viewActionSheet=[[UIView alloc]initWithFrame:CGRectMake(0, 460, 320, 290)];
        }
        
        [viewActionSheet setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"pop_ups.png"]]];
        
        ////======= UIbutton to show share on facebok========//////
        UIButton *btnFaceBook=[UIButton buttonWithType:UIButtonTypeCustom];
        btnFaceBook.frame=CGRectMake(15, 15,290 , 50);
        [btnFaceBook addTarget:self action:@selector(PostingOnFacebookButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        [btnFaceBook setImage:[UIImage imageNamed:@"fb.png"] forState:UIControlStateNormal];
        [viewActionSheet addSubview:btnFaceBook];
        
        
        ////======= UIbutton to show share on Twitter========//////
        UIButton *btnTwitter=[UIButton buttonWithType:UIButtonTypeCustom];
        btnTwitter.frame=CGRectMake(15, 75,290 , 50);
        [btnTwitter addTarget:self action:@selector(shareFeeds) forControlEvents:UIControlEventTouchUpInside];
        [btnTwitter setImage:[UIImage imageNamed:@"twitter.png"] forState:UIControlStateNormal];
        [viewActionSheet addSubview:btnTwitter];
        
        
        ////======= UIbutton to show share By a mail========//////
        UIButton *btnEmail=[UIButton buttonWithType:UIButtonTypeCustom];
        btnEmail.frame=CGRectMake(15, 135,290 , 50);
        [btnEmail addTarget:self action:@selector(showmailPicker) forControlEvents:UIControlEventTouchUpInside];
        [btnEmail setImage:[UIImage imageNamed:@"gmail.png"] forState:UIControlStateNormal];
        [viewActionSheet addSubview:btnEmail];
        
        
        ////======= UIbutton to Hide View========//////
        UIButton *btnCancel=[UIButton buttonWithType:UIButtonTypeCustom];
        btnCancel.frame=CGRectMake(20, 195,270 , 40);
        [btnCancel addTarget:self action:@selector(cancelView) forControlEvents:UIControlEventTouchUpInside];
        [btnCancel setImage:[UIImage imageNamed:@"cancle_btn.png"] forState:UIControlStateNormal];
        [viewActionSheet addSubview:btnCancel];
        
        
        delegateApp.checkForHoneScreen=NO;
        delegateApp.checkForPopulaterScreen=NO;
        ////========= Add code for scrollview1  Code =========////////
        [scrollViewCust1 removeFromSuperview];
        [scrollViewCust2 removeFromSuperview];
        arrayOftargetImages = [[NSArray alloc] initWithObjects:                 //Initializing Images
                               [UIImage imageNamed:@"you.png"],
                               [UIImage imageNamed:@"he.png"],
                               [UIImage imageNamed:@"she1.png"],
                               [UIImage imageNamed:@"they.png"],
                               [UIImage imageNamed:@"yo-mama.png"], nil];
        
        
        
        arrayOfSubjectImages = [[NSArray alloc] initWithObjects: [UIImage imageNamed:@"fat.png"],[UIImage imageNamed:@"skinny.png"],[UIImage imageNamed:@"ugly.png"],[UIImage imageNamed:@"dumb.png"],[UIImage imageNamed:@"old.png"],[UIImage imageNamed:@"poor.png"],
                                [UIImage imageNamed:@"random.png"],nil];
        
        // add target text and subject texts
        arraytargetText=[[NSArray alloc]initWithObjects:@"You",@"He",@"She",@"They",@"Yo Mama",nil];
        arraySubjectText=[[NSArray alloc]initWithObjects:@"Fat",@"Skinny",@"Ugly",@"Dumb",@"Old",@"Poor",@"Random",nil];
        
        UILabel *lbl1=[[UILabel alloc]initWithFrame:CGRectMake(-200, 00, 1100, 02)];
        lbl1.backgroundColor=[UIColor blackColor];
        UILabel *lbl2=[[UILabel alloc]initWithFrame:CGRectMake(-200, 00, 1500, 02)];
        lbl2.backgroundColor=[UIColor blackColor];
        
        
        
        if ([UIDevice currentResolution]==UIDevice_iPhoneTallerHiRes ) {
            
            imageViewBanner.frame=CGRectMake(0, 0, 320, 140);
            btnPopulatore.frame=CGRectMake(83, 437,148 , 82);
            btnShare.frame=CGRectMake(20, 449, 55, 55);
            btnShop.frame=CGRectMake(245, 449, 55, 55);
            lblShowLine1.frame=CGRectMake(0, 275, 320, 2);
            lblShowLine2.frame=CGRectMake(0, 415, 320, 2);
            scrollViewCust1 =[[CustomScrollView alloc]initWithFrame:CGRectMake(0, 175, 320, 100)];
            scrollViewCust2 =[[CustomScrollView alloc]initWithFrame:CGRectMake(0, 313, 320, 102)];
            
            
            
            
            
        }else
        {
            imageViewBanner.frame=CGRectMake(0, 0, 320, 140);
            lblShowLine1.frame=CGRectMake(0, 245, 320, 2);
            lblShowLine2.frame=CGRectMake(0, 360, 320, 2);
            btnPopulatore.frame=CGRectMake(83, 363,148 , 82);
            btnShare.frame=CGRectMake(20, 375, 55, 55);
            btnShop.frame=CGRectMake(245, 376, 55, 55);
            scrollViewCust1 =[[CustomScrollView alloc]initWithFrame:CGRectMake(0, 145, 320, 100)];
            scrollViewCust2 =[[CustomScrollView alloc]initWithFrame:CGRectMake(0, 258, 320, 102)];
            
            
            
        }
        
        
        
        //scrollViewCust1 =[[CustomScrollView alloc]initWithFrame:CGRectMake(0, 110, 320, 100)];
        scrollViewCust1.backgroundColor=[UIColor  whiteColor];
        [scrollViewCust1 imageSizesSmall:30 Medium:50 LargeSize:70];
        
        [scrollViewCust1 addImageViewss:arrayOftargetImages withLabels:arraytargetText fontSize:12 labelAsHeader:NO DistanceBetweenImages:28];
        
        [scrollViewCust1 addSubview:lbl1];
        [scrollViewCust1 doCustomInitialization];
        
        [self.view addSubview:scrollViewCust1];
        
        
        ///scrollViewCust2 =[[CustomScrollView alloc]initWithFrame:CGRectMake(0, 223, 320, 102)];
        scrollViewCust2.backgroundColor=[UIColor  whiteColor];
        [scrollViewCust2 imageSizesSmall:30 Medium:50 LargeSize:70];
        [scrollViewCust2 addImageViewss:arrayOfSubjectImages withLabels:arraySubjectText fontSize:12 labelAsHeader:NO DistanceBetweenImages:28];
        //   [scrollViewCust1 addImageViews:arrayOftargetImages withLabels:arraytargetText fontSize:14 labelAsHeader:NO DistanceBetweenImages:10];
        
        [scrollViewCust2 addSubview:lbl2];
        [scrollViewCust2 doCustomInitialization];
        [self.view addSubview:scrollViewCust2];
        [self.view addSubview:viewActionSheet];
    }
    
    [self.navigationController setNavigationBarHidden:YES];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

#pragma mark - to hide View of action sheet
-(void)cancelView
{
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.4];
    
    if ([UIDevice currentResolution]==UIDevice_iPhoneTallerHiRes ) {
        
        [viewActionSheet setFrame:CGRectMake(0  ,568,320,290)];
        
    }else{
        
        [viewActionSheet setFrame:CGRectMake(0  ,460,320,290)];
        
    }
    [UIView commitAnimations];
    
    
}


#pragma mark - Show Shop View
-(IBAction)shopView:(id)sender
{
    
    ShopView *shopView=[[ShopView alloc]init];
    [self presentModalViewController:shopView animated:YES];
    //    [self.navigationController pushViewController:shopView animated:YES];
    
}

#pragma mark - Show Populater Screen
-(IBAction)populaterView:(id)sender
{
    PopulatorView *populatorView=[[PopulatorView alloc]init];
    NSString *stringRemoveSpeace=[arraytargetText objectAtIndex:scrollViewCust1.currentIndex];
    
    
    //[arraytargetText objectAtIndex:scrollViewCust1.currentIndex]
    //stringTarget=[stringTarget stringByReplacingOccurrencesOfString:@" " withString:@""];
    populatorView.stringTarget = [stringRemoveSpeace stringByReplacingOccurrencesOfString:@" " withString:@""];
    populatorView.stringSubject = [arraySubjectText objectAtIndex:scrollViewCust2.currentIndex];
    
    
    AppDelegate *delegateApp=(AppDelegate *)[UIApplication sharedApplication].delegate;
    
    if (![delegateApp.saveTarget isEqualToString:populatorView.stringTarget] || ![delegateApp.saveSubject isEqualToString:populatorView.stringSubject]) {
        delegateApp.m_arrayInsults=nil;
        [delegateApp.m_arrayInsults removeAllObjects];
    }
    if (strTarget.length==0)
    {
        strTarget=[arraytargetText objectAtIndex:0];
    }
    
    if(strSubject.length==0)
    {
        strSubject=[arraySubjectText objectAtIndex:0];
    }
    
    showPopUpOneTime=YES;
    [self.navigationController pushViewController:populatorView animated:YES];
    
}


#pragma mark - Show Mail Composer

-(void)showmailPicker
{
	
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.4];
    if ([UIDevice currentResolution]==UIDevice_iPhoneTallerHiRes ) {
        
        [viewActionSheet setFrame:CGRectMake(0  ,568,320,290)];
        
    }else{
        
        [viewActionSheet setFrame:CGRectMake(0  ,460,320,290)];
        
    }
    [UIView commitAnimations];
    
	if ([MFMailComposeViewController canSendMail]) {
		
		[self performSelector:@selector(displayComposerSheet)];
		
	}else {
        //Email Config
		UIAlertView* alert=[[UIAlertView alloc]initWithTitle:@"Oops!" message:@"E_mail address not configured...! " delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
	}
}

- (NSString *)getIPAddress
{
	address = @"error";
	struct ifaddrs *interfaces = NULL;
	struct ifaddrs *temp_addr = NULL;
	int success = 0;
	
	// retrieve the current interfaces - returns 0 on success
	success = getifaddrs(&interfaces);
	if (success == 0)
	{
		// Loop through linked list of interfaces
		temp_addr = interfaces;
		while(temp_addr != NULL)
		{
			if(temp_addr->ifa_addr->sa_family == AF_INET)
			{
				// Check if interface is en0 which is the wifi connection on the iPhone
				if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"])
				{
					// Get NSString from C String
					address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
				}
			}
			
			temp_addr = temp_addr->ifa_next;
		}
	}
	
	// Free memory
	freeifaddrs(interfaces);
	
	return address;
}

- (void)Mail
{
	
	NSString *address1 = [self getIPAddress];
	
	
	if ([address1 isEqualToString:@"error"] == NO) {
		UIAlertView* alert=[[UIAlertView alloc]initWithTitle:@"Oops!" message:@"E_mail address not configured...! " delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
		[alert show];
        
		
	}else {
		
		Class mailClass = (NSClassFromString(@"MFMailComposeViewController"));
		
		if (mailClass != nil)
		{
			// We must always check whether the current device is configured for sending emails
			if ([mailClass canSendMail])
			{
                [self performSelector:@selector(displayComposerSheet)];
			}
			else
			{
				[self performSelector:@selector(launchMailAppOnDevice)];
			}
		}
		else
		{
            [self performSelector:@selector(launchMailAppOnDevice)];
		}
	}
}


-(void)displayComposerSheet
{
	MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
	picker.mailComposeDelegate = self;
	
	[picker setSubject:@"Build-A-Dis HD"];
    
    // Set up recipients
	NSArray *toRecipients = NULL;
	NSArray *ccRecipients = NULL;
	NSArray *bccRecipients = NULL;
	
    // Add To Cc or Bcc
	[picker setToRecipients:toRecipients];
	[picker setCcRecipients:ccRecipients];
	[picker setBccRecipients:bccRecipients];
	
    MailString=[[NSMutableString alloc]init];
    
    [MailString appendString:@"<html><body><br><img src='http://appvolks.com/css/images/build-a-dis_logo.png'/><br><br><a href='https://itunes.apple.com/us/app/build-a-dis-hd/id614141134?ls=1&mt=8'>Download Build-A-Dis Now!</a></br></body></html>"];
    //////////////===========////////////////
    
   	NSString *emailBody = MailString;
	[picker setMessageBody:emailBody isHTML:YES];
	[picker setEditing:YES];
	
    // Show mail composer
	[self presentModalViewController:picker animated:YES];
	
}

//Launch mail on device
-(void)launchMailAppOnDevice
{
	
	NSString *email = [NSString stringWithFormat:@"\t%@",MailString];
	email = [email stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:email]];
}

//Mail Composer delegate
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
	
	switch (result)
	{
		case MFMailComposeResultCancelled:
		{
            
        }
            break;
			
		case MFMailComposeResultSaved:
		{
            
		}
            break;
            
		case MFMailComposeResultSent:
			
			NSLog(@"------Hi");
            
			
			NSString *address = [self getIPAddress];
			
			if ([address isEqualToString:@"error"] == YES) {
                //Net not
                //				UIAlertView*  alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Mail sent successfully" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                //
                //                [alert show];
				break;
			}else {
                //				UIAlertView* alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Mail sent successfully" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                //
                //                [alert show];
				break;
			}
			
    }
	
	[self dismissModalViewControllerAnimated:YES];
}

#pragma mark - faceBook Share

-(void) facebookDidLoginSuccessfully:(BOOL)successfully{
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    if (successfully) {
        [self performSelector:@selector(showHUD)];
        NSMutableDictionary *imageDic= [[NSMutableDictionary alloc] init];
        NSString * resourcePath =[NSString stringWithFormat:@"http://appvolks.com/css/images/build-a-dis_logo.png"];
        
        //        UIImage *imageB=[UIImage imageNamed:@"build-a-dis_logo.png"];
        
        //        NSData *dataObj = UIImagePNGRepresentation(imageB);
        
        [imageDic setObject:resourcePath forKey:@"picture"];
        //nslog(@"resourcePath  %@",resourcePath);
        NSString *str;
        
        //        if (strSelectedComment.length!=0) {
        //
        //        }else
        //        {
        //            strSelectedComment=[NSString stringWithFormat:@"%@",[[arrayUpdatedAray objectAtIndex:0] objectForKey:@"key_Thought"]];
        //        }
        str=[NSString stringWithFormat:@"Hello Build-A-Dis"];
        
        
        [imageDic setObject:@"Download Build-A-Dis Now!" forKey:@"name"];
        [imageDic setObject:@"  " forKey:@"caption"];
        [imageDic setObject:@"  " forKey:@"description"];
        
        
        //  [imageDic setObject:[NSString stringWithFormat:@"%@",strSelectedComment] forKey:@"message"];
        [imageDic setObject:@"link" forKey:@"type"];
        [imageDic setObject:@"https://itunes.apple.com/us/app/build-a-dis-hd/id614141134?ls=1&mt=8" forKey:@"link"];
        //   [imageDic setObject:@"https://google.com" forKey:@"link"];
        //        NSString *links = @"{\"name\":\"App Store page\", \"link\": \"http://www.Pictergraphapp.com\"}";
        //        [imageDic setObject:links forKey:@"actions"];
        
        //        NSMutableDictionary *imageDic= [[NSMutableDictionary alloc] init];
        //        NSString * resourcePath =[NSString stringWithFormat:@"http://appvolks.com/css/images/app_icon_updated_114X114.png"];
        //        [imageDic setObject:resourcePath forKey:@"picture"];
        //        NSLog(@"resourcePath  %@",resourcePath);
        //        NSString *str;
        //        str=[NSString stringWithFormat:@"Hello Pick-Up-Pal"];
        //        [imageDic setObject:@"Download Pick-Up-Pal Now!" forKey:@"name"];
        //        [imageDic setObject:@"  " forKey:@"caption"];
        //        [imageDic setObject:@"  " forKey:@"description"];
        //        [imageDic setObject:@"link" forKey:@"type"];
        //        NSString *links = @"{\"name\":\"App Store page\", \"link\": \"http://www.Pictergraphapp.com\"}";
        //        [imageDic setObject:links forKey:@"actions"];
        
        [[FacebookController sharedController]setDelegate:self];
        [[FacebookController sharedController]publishStream:imageDic];
        
    }
    
}
-(void) facebookDidGetUid:(NSString*)uid successfully:(BOOL)successfully{
    
}
-(void) facebookDidGetFiends:(NSArray*)friends successfully:(BOOL)successfully{
    
}
-(void) facebookDidPublishSuccessfully:(BOOL)successfully{
    
    [self performSelector:@selector(killHUD)];
    if (successfully) {
        //        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@" " message:@"Message posted successfully" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        //
        //        [alert show];
        
        //[alertView release];
    }else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Error posting image on facebook" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alertView show];
        //[alertView release];
    }
    //[self hideIndicator];
    if ([[FacebookController sharedController]isLoggedIn]) {
        [[FacebookController sharedController]logout];
    }
    
    
}

-(void) facebookDidCloseErrorAlert{
    
}

-(void) facebookDidGetPic:(NSData*)pic successfully:(BOOL)successfully{
    
}
-(void)PostingOnFacebookButtonPressed{
    
    [self performSelector:@selector(cancelView)];
    
    if([[Reachability sharedReachability] internetConnectionStatus] !=ReachableViaWiFiNetwork && [[Reachability sharedReachability] internetConnectionStatus] !=ReachableViaCarrierDataNetwork) {
		
		UIAlertView*  alert=[[UIAlertView alloc]initWithTitle:@"Oops!" message:@"Internet connection is not detected " delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];
		return;
		
	}
    [[FacebookController sharedController]setDelegate:self];
    [[FacebookController sharedController]login];
    
}

#pragma mark - Show hud view
//to kill hud view
- (void) killHUD
{
	if(aHUD != nil ){
		[aHUD.loadingView removeFromSuperview];
		[aHUD setUserInteractionEnabledForSuperview:self.view];
		[aHUD setUserInteractionEnabledForSuperview:self.view];
        [self.navigationController.navigationBar setUserInteractionEnabled:YES];
        [self.view setUserInteractionEnabled:YES];
        aHUD = nil;
		[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
	}
}

//to show hud view
- (void) showHUD
{
	if(aHUD == nil)
	{
		aHUD = [[HudView alloc]init];
		[aHUD setUserInteractionEnabledForSuperview:self.view];
        [aHUD loadingViewInView:self.view text:@"Loading Please Wait...."];
        [self.navigationController.navigationBar setUserInteractionEnabled:NO];
		[self.view setUserInteractionEnabled:NO];
		[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
		
	}
}

#pragma mark - Twitter

-(void)shareFeeds
{
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.4];
    if ([UIDevice currentResolution]==UIDevice_iPhoneTallerHiRes ) {
        //nslog(@"UIDevice_iPhoneTallerHiRes ");
        
        [viewActionSheet setFrame:CGRectMake(0  ,568,320,290)];
        
    }else{
        
        [viewActionSheet setFrame:CGRectMake(0  ,460,320,290)];
        
    }
    [UIView commitAnimations];
    
    if([[Reachability sharedReachability] internetConnectionStatus] !=ReachableViaWiFiNetwork && [[Reachability sharedReachability] internetConnectionStatus] !=ReachableViaCarrierDataNetwork) {
		
		UIAlertView* alert=[[UIAlertView alloc]initWithTitle:@"Oops!" message:@"Internet connection is not detected " delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        
		[alert show];
        
		return;
		
	}
	
    [[TwitterHelper sharedController] setDelegate:self];
    [[TwitterHelper sharedController] authenticatePerson];
    
    bool_TwitterShare=YES;
}

- (void) storeCachedTwitterOAuthData: (NSString *) data forUsername: (NSString *) username {
	NSUserDefaults			*defaults = [NSUserDefaults standardUserDefaults];
	
    
    
	[defaults setObject: data forKey: @"authData"];
	[defaults synchronize];
}

- (NSString *) cachedTwitterOAuthDataForUsername: (NSString *) username {
	return [[NSUserDefaults standardUserDefaults] objectForKey: @"authData"];
}



#pragma  mark - show custom action sheet

-(IBAction)setLibraryAttributes
{
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.4];
    
    
    if ([UIDevice currentResolution]==UIDevice_iPhoneTallerHiRes ) {
        //nslog(@"UIDevice_iPhoneTallerHiRes ");
        
        [viewActionSheet setFrame:CGRectMake(0  ,258,320,290)];
        
    }else{
        [viewActionSheet setFrame:CGRectMake(0  ,170,320,290)];
        
    }
    
    
    [UIView commitAnimations];
}


#pragma mark - Show Rotation

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - To get rendam Number

-(int)randomNumber
{
	int number = (arc4random()%100)+1; //Generates Number from 1 to 100.
	return number;
}



# pragma mark Twitter helper delegate

-(void)TwitterLoad:(UIViewController *)controller{
    
    [self presentModalViewController:controller animated:YES];
}



-(void) TwitterDidLogin:(NSString*)authData userName:(NSString*)userName  successfully:(BOOL)successfully{
    if (successfully) {
        //nslog(@"sucesses");
        [self performSelector:@selector(callTwitter) withObject:nil afterDelay:2.0];
    }
}
-(void)callTwitter{
    
    NSString *str=[NSString stringWithFormat:@"this is tweet no. %d\nhttps://itunes.apple.com/us/app/build-a-dis-hd/id614141134?ls=1&mt=8",[self randomNumber]];
    //nslog(@"the str is %@",str);
    [[TwitterHelper sharedController] sendUpdate:str];
    //    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Message posted successfully" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    //    [alert show];
}

-(void) TwitterRequestSuccessfully:(BOOL)successfully{
    [[TwitterHelper sharedController] logOut];
}

-(void) getTwitterUserInfo{
    NSString *userInfoViaEmail = [[TwitterHelper sharedController] getUserInformationFor:[[TwitterHelper sharedController] getusername]];
    NSLog(@"User Info = %@",userInfoViaEmail);
    
}


#pragma Mark - Alert View delegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    AppDelegate *delegateApp=(AppDelegate *)[UIApplication sharedApplication].delegate;
    NSString *strButtonTitle=[alertView buttonTitleAtIndex:buttonIndex];
    if ([strButtonTitle isEqualToString:@"Ok"]) {
        
        if (checkStore==YES) {
            ShopView *sV=[[ShopView alloc]init];
            [self presentModalViewController:sV animated:YES];
            
            
        }else
        {
            NSString *urlstring = [[NSString alloc] initWithFormat:@"%@",[[delegateApp.arrayPopInfo objectAtIndex:alertView.tag]objectForKey:@"target"]];
            
            urlstring = [urlstring stringByReplacingOccurrencesOfString:@"https://" withString:@""];
            NSString *strURL = [NSString stringWithFormat:@"https://%@",urlstring];
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:strURL]];
            
            return;
        }
    }    
}

@end