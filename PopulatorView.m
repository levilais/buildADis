//
//  PopulatorView.m
//  PicAPal
//
//  Created by USER USER on 8/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PopulatorView.h"
#import "ShopView.h"
#import "Reachability.h"
#import "AppDelegate.h"
#import "SA_OAuthTwitterController.h"
#import "SDZDeviceService.h"
#import "SDZServices.h"
#import "UIDevice+Resolutions.h"
#import "APPObject.h"

extern BOOL showPopUpOneTime;
NSString *CheckPopUpShowOrNot;

//Nsstring to get ip Address
NSString *address;

//mutable string to send string by a mail
NSMutableString *MailString;

//nsstring to selected comment
NSString *strSelectedComment;

//To Check twitter Share
BOOL twitterShare;

//To check Store or URL
BOOL checkAlertStore;

//String for URl;
NSString *stringForURL;
// nsstring to get select subject and Selected target
extern NSString *strSubject,*strTarget;

// To get length of scrollview
double scrollViewContextX;

//Bool To chack popup will show or not
BOOL  showPopUp;


@implementation PopulatorView



@synthesize btnHome,btnShop,btnActionSheet;
@synthesize pickerViewtext;
@synthesize viewActionSheet;
@synthesize scrollView1;
@synthesize stringTarget, stringSubject;
@synthesize arrayUpdatedAray;
@synthesize lblLineOne,lblLineTwo,btnPopulatorIcon,imageViewBanner;

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
    
    //======= Check String =======//
    strSelectedComment = @"";
    checkPurchased=NO;
    scrollView1=[[TapScrollView alloc]init];
    /////=========UIview to show action sheet ===========////////
    
    if ([UIDevice currentResolution]==UIDevice_iPhoneTallerHiRes ) {
        
        viewActionSheet=[[UIView alloc]initWithFrame:CGRectMake(0, 568, 320, 290)];
        
    }else{
        viewActionSheet=[[UIView alloc]initWithFrame:CGRectMake(0, 460, 320, 290)];
        
    }
    
    //  viewActionSheet=[[UIView alloc]initWithFrame:CGRectMake(0, 460, 320, 290)];
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
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_texture.png"]]];
    
    
    if ([UIDevice currentResolution]==UIDevice_iPhoneTallerHiRes ) {
        
        imageViewBanner.frame=CGRectMake(0, 0,320,150 );
        btnHome.frame=CGRectMake(20, 155,50,50 );
        lblLineOne.frame=CGRectMake(0, 235,320,2 );
        lblLineTwo.frame=CGRectMake(0, 367,320,2 );
        btnActionSheet.frame=CGRectMake(20,435,55,55 );
        btnPopulatorIcon.frame=CGRectMake(115, 414,90,90 );
        btnShop.frame=CGRectMake(245, 435,55,55 );
        
        
    }else{
        imageViewBanner.frame=CGRectMake(0, 0,320,140 );
        btnHome.frame=CGRectMake(20, 140,50,50 );
        lblLineOne.frame=CGRectMake(0, 200,320,2 );
        lblLineTwo.frame=CGRectMake(0, 332,320,2 );
        btnActionSheet.frame=CGRectMake(20,365,55,55 );
        btnPopulatorIcon.frame=CGRectMake(115, 344,90,90 );
        btnShop.frame=CGRectMake(245, 365,55,55 );
        
    }
    
    
    
    
    
}


-(void)viewWillAppear:(BOOL)animated
{
    AppDelegate *delegateApp=(AppDelegate *)[UIApplication sharedApplication].delegate;
    
    if (hasStarted==NO) {
        hasStarted=YES;
        [delegateApp showAd];
    }
    if (delegateApp.checkForPopulaterScreen==YES) {
        
        if ([UIDevice currentResolution]==UIDevice_iPhoneTallerHiRes ) {
            delegateApp.checkForPopulaterScreen=NO;
            imageViewBanner.frame=CGRectMake(0, 0,320,150 );
            btnHome.frame=CGRectMake(20, 155,50,50 );
            lblLineOne.frame=CGRectMake(0, 235,320,2 );
            lblLineTwo.frame=CGRectMake(0, 367,320,2 );
            btnActionSheet.frame=CGRectMake(20,435,55,55 );
            btnPopulatorIcon.frame=CGRectMake(115, 414,90,90 );
            btnShop.frame=CGRectMake(245, 435,55,55 );
            
            
        }
        else{
            
            imageViewBanner.frame=CGRectMake(0, 0,320,140 );
            btnHome.frame=CGRectMake(20, 140,50,50 );
            lblLineOne.frame=CGRectMake(0, 200,320,2 );
            lblLineTwo.frame=CGRectMake(0, 332,320,2 );
            btnActionSheet.frame=CGRectMake(20,365,55,55 );
            btnPopulatorIcon.frame=CGRectMake(115, 344,90,90 );
            btnShop.frame=CGRectMake(245, 365,55,55 );
            
        }
    }
    
    NSString *strDataBase;
    
    if (arrayToShowData==nil) {
        arrayToShowData=[[NSMutableArray alloc]init];
    }
    if (arrayUpdatedAray==nil) {
        arrayUpdatedAray=[[NSMutableArray alloc]init];
    }
    //    arrayToShowData=[[NSMutableArray alloc]init];
    //    arrayUpdatedAray=[[NSMutableArray alloc]init];
    if ([stringSubject isEqualToString:@"Random"]) {
        
        strDataBase=[NSString stringWithFormat:@"select * from BuildADisTable where Target='%@' AND IsActive='Yes'",stringTarget];
        
    }else
    {
        strDataBase=[NSString stringWithFormat:@"select * from BuildADisTable where Subject='%@' AND Target='%@' AND IsActive='Yes'",stringSubject,stringTarget];
        
    }
    [self performSelector:@selector(getAllThought:) withObject:strDataBase];
    [self.navigationController setNavigationBarHidden:YES];
    
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

#pragma mark - Get thought from data base
-(void)getAllThought:(NSString *)str{
    
    AppDelegate *delegateApp=(AppDelegate *)[UIApplication sharedApplication].delegate;
    
    if (delegateApp.m_arrayInsults.count >0) {
        
    }else
    {
        sqlite3  *database=[AppDelegate getNewDBConnection];
        
        sqlite3_stmt *compiledStatement;
        
        if(sqlite3_prepare_v2(database, [str UTF8String], -1, &compiledStatement, NULL) == SQLITE_OK)
            
        {
            
            while(sqlite3_step(compiledStatement) == SQLITE_ROW)
                
            {
                
                NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
                
                // Read the data from the result row
                
                
                NSString *strThoughtID = nil;
                
                strThoughtID=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 2)];
                
                NSString *strThought=nil;
                
                strThought=[NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 3)];
                
                [dictionary setObject:strThoughtID forKey :@"key_ThoughtID"];
                
                [dictionary setObject:strThought forKey :@"key_Thought"];
                
                [arrayToShowData addObject:dictionary];
                
            }
            
        }
        sqlite3_finalize(compiledStatement);
        sqlite3_close(database);
        NSUInteger count = [arrayToShowData count];
        for (NSUInteger i = 0; i < count; ++i) {
            // Select a random element between i and end of array to swap with.
            int nElements = count - i;
            int n = (arc4random() % nElements) + i;
            [arrayToShowData exchangeObjectAtIndex:i withObjectAtIndex:n];
        }
        
    }
    //////=====Add label to scrollview======/////
    
    if (arrayUpdatedAray!=nil) {
        
        arrayUpdatedAray=nil;
        [arrayUpdatedAray removeAllObjects];
        
    }
    
    
    if (delegateApp.m_arrayInsults.count >0) {
        
        arrayUpdatedAray=delegateApp.m_arrayInsults;
    }   else
    {
        
        arrayUpdatedAray=arrayToShowData;
    }
    [scrollView1 removeFromSuperview];
    
    [scrollView1 setDelegate:self];
    
    if ([UIDevice currentResolution]==UIDevice_iPhoneTallerHiRes ) {
        
        scrollView1.frame = CGRectMake(0, 237, 320, 130);
        
    }else{
        scrollView1.frame = CGRectMake(0, 202, 320, 130);
        
    }
    
    
    
    
    scrollView1.showsHorizontalScrollIndicator = NO;
    scrollView1.showsVerticalScrollIndicator = NO;
    scrollView1.pagingEnabled=YES;
    // scrollView1.scrollEnabled=NO;
    scrollView1.backgroundColor=[UIColor whiteColor];
    scrollView1.contentSize=CGSizeMake(0, 0);
    
    [self.view addSubview:scrollView1];
    [self.view setClipsToBounds:YES];
    [self.view addSubview:viewActionSheet];
    
    
    int CordX=20;
    int CordY=10;
    arrayToShowData=nil;
    [arrayToShowData removeAllObjects];
    for (UIView *subview in [scrollView1 subviews]) {
        
        [subview removeFromSuperview];
        
    }
    
    for (int k=0; k<[arrayUpdatedAray count]; k++) {
        UIButton *lblInsult=[UIButton buttonWithType:UIButtonTypeCustom];
        lblInsult.frame=CGRectMake(CordX, CordY, 280,110 );
        [lblInsult setTitle:[[arrayUpdatedAray objectAtIndex:k]objectForKey:@"key_Thought"] forState:UIControlStateNormal];
        [lblInsult setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [lblInsult.titleLabel setLineBreakMode:UILineBreakModeWordWrap];
        [lblInsult.titleLabel setFont:[UIFont boldSystemFontOfSize:15]];
        [lblInsult.titleLabel setTextAlignment:UITextAlignmentCenter];
        //   lblInsult.text=[[arrayUpdatedAray objectAtIndex:k]objectForKey:@"key_Thought"];
        [scrollView1 addSubview:lblInsult];
        
        if (k==0) {
            CordX=CordX+320;
        }else
        {
            int m =k+1;
            CordX=20+320*m;
            
        }
    }
    /////=====Save data to check is previous selected data or not
    delegateApp.saveTarget=[NSString stringWithFormat:@"%@",stringTarget];
    delegateApp.saveSubject=[NSString stringWithFormat:@"%@",stringSubject];
    
    
    
    scrollView1.contentSize=CGSizeMake(320*[arrayUpdatedAray count], 130);
    int selectedIndex;
    if (delegateApp.intScrollOffset >0) {
        selectedIndex=delegateApp.intScrollOffset-1;
    }else
    {
        
        selectedIndex=delegateApp.intScrollOffset;
        
    }
    
    
    if (delegateApp.m_arrayInsults.count >0) {
        
        [scrollView1 setContentOffset:CGPointMake(scrollView1.contentOffset.x+ 320 *selectedIndex,
                                                  scrollView1.contentOffset.y) animated:NO];
        strSelectedComment=[NSString stringWithFormat:@"%@",[[arrayUpdatedAray objectAtIndex:selectedIndex] objectForKey:@"key_Thought"]];
    }
    delegateApp.m_arrayInsults=arrayUpdatedAray;
    scrollViewContextX=320*[arrayUpdatedAray count];
}


-(void)ScrollViewData
{
    
    
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


#pragma mark - To go back on home screen
-(IBAction)homeView:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Show Shop view
-(IBAction)shopView:(id)sender
{
    ShopView *shopView=[[ShopView alloc]init];
    [self presentModalViewController:shopView animated:YES];
    //    [self.navigationController pushViewController:shopView animated:YES];
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
    
    //String to send in mail
    
    if (strSelectedComment.length!=0) {
        
    }else
    {
        strSelectedComment=[NSString stringWithFormat:@"%@",[[arrayUpdatedAray objectAtIndex:0] objectForKey:@"key_Thought"]];
        
    }
    [MailString appendString:strSelectedComment];
    
    [MailString appendString:@"\n\n"];
    
    [MailString appendString:@"<html><body>	<br><br><img src='http://appvolks.com/css/images/build-a-dis_logo.png'/><br><br><a href='https://itunes.apple.com/us/app/build-a-dis-hd/id614141134?ls=1&mt=8'>Download Build-A-Dis Now!</a></br></body></html>"];
    //
    //    NSString *stradd2=[NSString stringWithFormat:@"<html><body><p>You be the <font size=\"6\"><b>P</b></font>resident <font size=\"6\"><b>O</b></font>f <font size=\"6\"><b>T</b></font>he <font size=\"6\"><b>U</b></font>nited<font size=\"6\"><b>S</b></font>tates—POTUS</p></body></html>"];
    //
    //<a href="">Go</a>
    //    UIImage *pic = [UIImage imageNamed:@"build-a-dis_logo.png"];
    //    NSData *exportData = UIImageJPEGRepresentation(pic ,1.0);
    //    NSString *strFileName=@"Hello ";
    //    [picker addAttachmentData:exportData mimeType:@"image/jpg" fileName:strFileName];
    [MailString appendString:@"\n\n"];
    
    
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
                //				UIAlertView*  alert=[[UIAlertView alloc]initWithTitle:@"" message:@"Mail sent successfully" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                //
                //                [alert show];
				break;
			}else {
                NSString *strTwi=@"Email";
                CheckPopUpShowOrNot=@"Email";
                
                [self loadAdRequest ];
                
                //                [[NSUserDefaults standardUserDefaults] setObject:strTwi forKey:@"key_ShareFromEmail"];// [[NSUserDefaults standardUserDefaults] setObject:strTwi forKey:@"key_ShareFromFacebook"];// [[NSUserDefaults standardUserDefaults] setObject:strTwi forKey:@"key_ShareFromTwitter"];
                [self toGetPreview:@"Email" jokeInsult:strSelectedComment];
                
				break;
			}
    }
	
	[self dismissModalViewControllerAnimated:YES];
	
}



#pragma mark - faceBook Share

-(void)PostingOnFacebookButtonPressed{
    
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
    [[FacebookController sharedController]setDelegate:self];
    [[FacebookController sharedController]login];
}

-(void) facebookDidLoginSuccessfully:(BOOL)successfully{
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    if (successfully) {
        [self performSelector:@selector(showHUD)];
        NSMutableDictionary *imageDic= [[NSMutableDictionary alloc] init];
        NSString * resourcePath =[NSString stringWithFormat:@"http://appvolks.com/css/images/build-a-dis_logo.png"];
        
        UIImage *imageB=[UIImage imageNamed:@"build-a-dis_logo.png"];
        
        NSData *dataObj = UIImagePNGRepresentation(imageB);
        
        [imageDic setObject:resourcePath forKey:@"picture"];
        //nslog(@"resourcePath  %@",resourcePath);
        NSString *str;
        
        if (strSelectedComment.length!=0) {
            
        }else
        {
            strSelectedComment=[NSString stringWithFormat:@"%@",[[arrayUpdatedAray objectAtIndex:0] objectForKey:@"key_Thought"]];
        }
        str=[NSString stringWithFormat:@"Hello  Build-A-Dis"];
        
        
        [imageDic setObject:@"Download Build-A-Dis Now!" forKey:@"name"];
        [imageDic setObject:@"  " forKey:@"caption"];
        [imageDic setObject:@"  " forKey:@"description"];
        
        [imageDic setObject:[NSString stringWithFormat:@"%@",strSelectedComment] forKey:@"message"];
        [imageDic setObject:@"link" forKey:@"type"];
        [imageDic setObject:@"https://itunes.apple.com/us/app/build-a-dis-hd/id614141134?ls=1&mt=8" forKey:@"link"];
        //   [imageDic setObject:@"https://google.com" forKey:@"link"];
        //        NSString *links = @"{\"name\":\"App Store page\", \"link\": \"http://www.Pictergraphapp.com\"}";
        //        [imageDic setObject:links forKey:@"actions"];
        
        [[FacebookController sharedController]setDelegate:self];
        [[FacebookController sharedController] publishStream:imageDic];
        [self loadAdRequest];
        
    }
}
-(void) facebookDidGetUid:(NSString*)uid successfully:(BOOL)successfully{
    
}
-(void) facebookDidGetFiends:(NSArray*)friends successfully:(BOOL)successfully{
    
}
-(void) facebookDidPublishSuccessfully:(BOOL)successfully{
    
    
    [self performSelector:@selector(killHUD)];
    if (successfully) {
        
        
        [self performSelector:@selector(showHUD)];
        /// [self performSelector:@selector(toGetPreview)];
        //        NSString *strTwi=@"FaceBook";
        CheckPopUpShowOrNot=@"FaceBook";
        //  [[NSUserDefaults standardUserDefaults] setObject:strTwi forKey:@"key_ShareFromFacebook"];// [[NSUserDefaults standardUserDefaults] setObject:strTwi forKey:@"key_ShareFromTwitter"];
        [self toGetPreview:@"FaceBook" jokeInsult:strSelectedComment];
        
    }else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Error posting image on facebook" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alertView show];
        
    }
    //[self hideIndicator];
    if ( [[FacebookController sharedController] isLoggedIn]) {
        [[FacebookController sharedController]logout];
    }
    
    
}

-(void) facebookDidCloseErrorAlert{
    
}

-(void) facebookDidGetPic:(NSData*)pic successfully:(BOOL)successfully{
    
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
        [aHUD loadingViewInView:self.view text:@"Sharing Please Wait...."];
        [self.navigationController.navigationBar setUserInteractionEnabled:NO];
		[self.view setUserInteractionEnabled:NO];
		[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
		
	}
}


#pragma mark - Twitter Sharing

///to share feed on twitter

#pragma mark - Twitter

///to share feed on twitter

-(void)shareFeeds
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.4];
    if ([UIDevice currentResolution]==UIDevice_iPhoneTallerHiRes ) {
        //nslog(@"UIDevice_iPhoneTallerHiRes ");
        
        [viewActionSheet setFrame:CGRectMake(0  ,568,320,290)];
        
    }else{
        [viewActionSheet setFrame:CGRectMake(0  ,460,320,290)];
        
    }    [UIView commitAnimations];
    
    if([[Reachability sharedReachability] internetConnectionStatus] !=ReachableViaWiFiNetwork && [[Reachability sharedReachability] internetConnectionStatus] !=ReachableViaCarrierDataNetwork) {
		
		UIAlertView* alert=[[UIAlertView alloc]initWithTitle:@"Oops!" message:@"Internet connection is not detected " delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        
		[alert show];
        
		return;
		
	}
    [[TwitterHelper sharedController] setDelegate:self];
    [[TwitterHelper sharedController] authenticatePerson];
    
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



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


#pragma mark - To get rendam Number

-(int)randomNumber:(int)num
{
	int number = (arc4random()%num)+1; //Generates Number from 1 to 100.
	return number;
}

-(void)loadAdRequest{
    AppDelegate *delegateApp=(AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegateApp showAd];
}
-(void)loadAds{
    if (counter==6||counterPage==5) {
        counter=0;
        counterPage=0;
        [self loadAdRequest];
    }
    
}
#pragma mark - Change Insult

-(IBAction)rotateInsult:(id)sender
{
    counter++;
    [self loadAds];
    
    
    
    if (checkClick==NO)
    {
        checkClick=YES;
        
        
        if (scrollViewContextX-320==scrollView1.contentOffset.x) {
            scrollView1.scrollEnabled=YES;
            
            
            NSString *strALlPack=[[NSUserDefaults standardUserDefaults]objectForKey:@"key_PurchaseAll"];
            if (![strALlPack isEqualToString:@"PurchaseAll"])
            {
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"***Upgrade Now!***" message:@"If you thought these were mean, you should check out our store for more hilarious jabs just like ‘em!" delegate:self cancelButtonTitle:@"No Thanks" otherButtonTitles:@"Store",nil];
                [alert show];
            }
            
        }
        else if ([arrayUpdatedAray count] > 1+ scrollView1.contentOffset.x /320 //End of Data check
                 && !((int)scrollView1.contentOffset.x % 320))
        {// && Not to scroll till previous scroll is finished.
            [scrollView1 setContentOffset:CGPointMake(scrollView1.contentOffset.x+320,
                                                      scrollView1.contentOffset.y) animated:YES];
        }
    }
    [self performSelector:@selector(checkClickNo)];
}

-(void)checkClickNo
{
    
    checkClick=NO;
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int selectedIndex = floor((scrollView.contentOffset.x - 320 / 2) / 320) + 1;
    
    if (page==selectedIndex) {
        return;
    }
    page=selectedIndex;
    counterPage++;
    [self loadAds];
    
    
}
int maintain;
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    
    int selectedIndex=scrollView.contentOffset.x /320;
    
    //nslog(@"selected Index %d",selectedIndex);
    
    if((selectedIndex+1)%5==0)
    {
        
        //nslog(@"Show Alert ");
        if (showPopUpOneTime==YES) {
            
            showPopUpOneTime=NO;
            
            AppDelegate *delegateApp=(AppDelegate *)[UIApplication sharedApplication].delegate;
            
            for (int i=0; i<[delegateApp.arrayPopInfo count]; i++)
            {
                
                NSString *strShowPopUp=[NSString stringWithFormat:@"%@",[[delegateApp.arrayPopInfo objectAtIndex:i]objectForKey:@"Location"]];
                if ([strShowPopUp isEqualToString:@"After 5 Jokes"]) {
                    
                    NSString *strOneX=[[NSUserDefaults standardUserDefaults]objectForKey:@"key_onexFiveJoke"];
                    
                    NSString *strPreTarget = [[NSUserDefaults standardUserDefaults] objectForKey:@"target_FiveJoke"];
                    
                    NSString *strTarget = [[delegateApp.arrayPopInfo objectAtIndex:i]objectForKey:@"target"];
                    
                    NSString *strDuration = [[delegateApp.arrayPopInfo objectAtIndex:i]objectForKey:@"Duration"];
                    
                    if (![strOneX isEqualToString:@"1x"] || [strDuration isEqualToString:@"Every Time"] || ![strTarget isEqualToString:strPreTarget])
                    {
                        [[NSUserDefaults standardUserDefaults] setObject:strDuration forKey:@"key_onexFiveJoke"];
                        [[NSUserDefaults standardUserDefaults] setObject:strTarget forKey:@"target_FiveJoke"];
                        
                        if (delegateApp.showPopUpOneTime==NO) {
                            
                            NSString *strOneTime=[NSString stringWithFormat:@"%@",[[delegateApp.arrayPopInfo objectAtIndex:i]objectForKey:@"Duration"]];
                            
                            if ([strOneTime isEqualToString:@"Every Time"]) {
                                //                                delegateApp.showPopUpOneTime=YES;
                                showPopUpOneTime = YES;
                            }
                            
                            
                            NSString *strLink=[NSString stringWithFormat:@"%@",[[delegateApp.arrayPopInfo objectAtIndex:i]objectForKey:@"target"]];
                            if ([strLink isEqualToString:@"Store"]) {
                                
                                checkAlertStore=YES;
                                showPopUp=YES;
                                
                                UIAlertView*  alert=[[UIAlertView alloc]initWithTitle:[[delegateApp.arrayPopInfo objectAtIndex:i]objectForKey:@"subject"] message:[[delegateApp.arrayPopInfo objectAtIndex:i]objectForKey:@"text"] delegate:self cancelButtonTitle:@"No, Thanks" otherButtonTitles:@"Ok", nil];
                                alert.tag = i;
                                [alert show];
                                
                                
                            }else
                            {
                                showPopUp=YES;
                                stringForURL=[NSString stringWithFormat:@"%@",[[delegateApp.arrayPopInfo objectAtIndex:i]objectForKey:@"target"]];
                                UIAlertView*  alert=[[UIAlertView alloc]initWithTitle:[[delegateApp.arrayPopInfo objectAtIndex:i]objectForKey:@"subject"] message:[[delegateApp.arrayPopInfo objectAtIndex:i]objectForKey:@"text"] delegate:self cancelButtonTitle:@"No, Thanks" otherButtonTitles:@"Ok", nil];
                                alert.tag = i;
                                [alert show];
                                
                            }
                        }
                    }
                    [[NSUserDefaults standardUserDefaults] synchronize];
                }
            }
        }
    }////
    strSelectedComment=[NSString stringWithFormat:@"%@",[[arrayUpdatedAray objectAtIndex:selectedIndex] objectForKey:@"key_Thought"]];
    AppDelegate *delegateApp=(AppDelegate *)[UIApplication sharedApplication].delegate;
    delegateApp.intScrollOffset=selectedIndex+1;
}
int ii=0;

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    int selectedIndex=scrollView.contentOffset.x /320;
    AppDelegate *delegateApp=(AppDelegate *)[UIApplication sharedApplication].delegate;
    delegateApp.intScrollOffset=selectedIndex+1;
    
    
    //nslog(@"selected Index %d",selectedIndex);
    if((selectedIndex+1)%5==0)
    { if (showPopUpOneTime==YES)
    {
        
        showPopUpOneTime=NO;
        
        AppDelegate *delegateApp=(AppDelegate *)[UIApplication sharedApplication].delegate;
        
        for (int i=0; i<[delegateApp.arrayPopInfo count]; i++)
        {
            
            NSString *strShowPopUp=[NSString stringWithFormat:@"%@",[[delegateApp.arrayPopInfo objectAtIndex:i]objectForKey:@"Location"]];
            if ([strShowPopUp isEqualToString:@"After 5 Jokes"]) {
                
                NSString *strOneX=[[NSUserDefaults standardUserDefaults]objectForKey:@"key_onexFiveJoke"];
                
                NSString *strPreTarget = [[NSUserDefaults standardUserDefaults] objectForKey:@"target_FiveJoke"];
                
                NSString *strTarget = [[delegateApp.arrayPopInfo objectAtIndex:i]objectForKey:@"target"];
                
                NSString *strDuration = [[delegateApp.arrayPopInfo objectAtIndex:i]objectForKey:@"Duration"];
                
                if (![strOneX isEqualToString:@"1x"] || [strDuration isEqualToString:@"Every Time"] || ![strTarget isEqualToString:strPreTarget])
                {
                    [[NSUserDefaults standardUserDefaults] setObject:strDuration forKey:@"key_onexFiveJoke"];
                    [[NSUserDefaults standardUserDefaults] setObject:strTarget forKey:@"target_FiveJoke"];
                    
                    if (delegateApp.showPopUpOneTime==NO) {
                        
                        NSString *strOneTime=[NSString stringWithFormat:@"%@",[[delegateApp.arrayPopInfo objectAtIndex:i]objectForKey:@"Duration"]];
                        
                        if ([strOneTime isEqualToString:@"Every Time"]) {
                            //                            delegateApp.showPopUpOneTime=YES;
                            showPopUpOneTime = YES;
                        }
                        
                        
                        NSString *strLink=[NSString stringWithFormat:@"%@",[[delegateApp.arrayPopInfo objectAtIndex:i]objectForKey:@"target"]];
                        if ([strLink isEqualToString:@"Store"]) {
                            
                            checkAlertStore=YES;
                            showPopUp=YES;
                            UIAlertView*  alert=[[UIAlertView alloc]initWithTitle:[[delegateApp.arrayPopInfo objectAtIndex:i]objectForKey:@"subject"] message:[[delegateApp.arrayPopInfo objectAtIndex:i]objectForKey:@"text"] delegate:self cancelButtonTitle:@"No, Thanks" otherButtonTitles:@"Ok", nil];
                            alert.tag = i;
                            [alert show];
                            
                            
                        }else
                        {
                            showPopUp=YES;
                            stringForURL=[NSString stringWithFormat:@"%@",[[delegateApp.arrayPopInfo objectAtIndex:i]objectForKey:@"target"]];
                            UIAlertView*  alert=[[UIAlertView alloc]initWithTitle:[[delegateApp.arrayPopInfo objectAtIndex:i]objectForKey:@"subject"] message:[[delegateApp.arrayPopInfo objectAtIndex:i]objectForKey:@"text"] delegate:self cancelButtonTitle:@"No, Thanks" otherButtonTitles:@"Ok", nil];
                            alert.tag = i;
                            [alert show];
                            
                        }
                    }
                }
                [[NSUserDefaults standardUserDefaults] synchronize];
            }
        }
    }}
    if (selectedIndex == [arrayUpdatedAray count]-1 && ii!=selectedIndex+1) {
        
        ii=selectedIndex+1;
        
    }else if (ii==selectedIndex+1) {
        NSString *strALlPack=[[NSUserDefaults standardUserDefaults]objectForKey:@"key_PurchaseAll"];
        if (![strALlPack isEqualToString:@"PurchaseAll"])
        {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"***Upgrade Now!***" message:@"If you thought these were mean, you should check out our store for more hilarious jabs just like ‘em!" delegate:self cancelButtonTitle:@"No Thanks" otherButtonTitles:@"Store",nil];
            [alert show];
        }
        
    }else if(selectedIndex < 24)
    {
        ii=0;
    }
    strSelectedComment=[NSString stringWithFormat:@"%@",[[arrayUpdatedAray objectAtIndex:selectedIndex] objectForKey:@"key_Thought"]];
}


#pragma mark - Delegate of UIAlertView

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    NSString *strButtonTitle=[alertView buttonTitleAtIndex:buttonIndex];
    AppDelegate *delegateApp=(AppDelegate *)[UIApplication sharedApplication].delegate;
    delegateApp.m_arrayInsults=nil;
    [delegateApp.m_arrayInsults removeAllObjects];
    
    delegateApp.intScrollOffset=0;
    if ([strButtonTitle isEqualToString:@"YES"]) {
        NSString *urlstring = [[NSString alloc] initWithFormat:@"http://itunes.apple.com/us/app/id485544768?mt=8"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlstring]];
        return;
    }
    
    if ([strButtonTitle isEqualToString:@"Ok"]) {
        
        if (checkAlertStore ==YES) {
            checkAlertStore=NO;
            ShopView *sv=[[ShopView alloc]init];
            [self presentModalViewController:sv animated:YES];
            return;
            
        }else
        {
            checkAlertStore=NO;
            NSString *urlstring = [[NSString alloc] initWithFormat:@"%@",[[delegateApp.arrayPopInfo objectAtIndex:alertView.tag]objectForKey:@"target"]];
            
            urlstring = [urlstring stringByReplacingOccurrencesOfString:@"https://" withString:@""];
            NSString *strURL = [NSString stringWithFormat:@"https://%@",urlstring];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:strURL]];
            return;
        }
        
    }
    
    
    if ([strButtonTitle isEqualToString:@"No Thanks"]) {
        NSString *strDataBase;
        
        
        if ([stringSubject isEqualToString:@"Random"]) {
            
            strDataBase=[NSString stringWithFormat:@"select * from BuildADisTable where Target='%@' AND IsActive='Yes'",stringTarget];
            
        }else
        {
            strDataBase=[NSString stringWithFormat:@"select * from BuildADisTable where Subject='%@' AND Target='%@' AND IsActive='Yes'",stringSubject,stringTarget];
            
        }
        arrayToShowData=[[NSMutableArray alloc]init];
        arrayUpdatedAray=[[NSMutableArray alloc]init];
        [self performSelector:@selector(getAllThought:) withObject:strDataBase];
        
        
    }else if ([strButtonTitle isEqualToString:@"Store"])
    {
        ShopView *shopView=[[ShopView alloc]init];
        [self presentModalViewController:shopView animated:YES];
        //        [self.navigationController pushViewController:shopView animated:YES];
        
    }
    
}


# pragma mark Twitter helper delegate

-(void)TwitterLoad:(UIViewController *)controller{
    
    [self presentModalViewController:controller animated:YES];
    
}



-(void) TwitterDidLogin:(NSString*)authData userName:(NSString*)userName  successfully:(BOOL)successfully{
    
    if (successfully) {
        [self performSelector:@selector(callTwitter) withObject:nil afterDelay:2.0];
    }
    
}
-(void)callTwitter{
    
    if (strSelectedComment.length!=0) {
        
    }else
    {
        strSelectedComment=[NSString stringWithFormat:@"%@",[[arrayUpdatedAray objectAtIndex:0] objectForKey:@"key_Thought"]];
    }
    
    [[TwitterHelper sharedController] sendUpdate:strSelectedComment];
    
    
    [self performSelector:@selector(showHUD)];
    /// [self performSelector:@selector(toGetPreview)];
    NSString *strTwi=@"Twitter";
    CheckPopUpShowOrNot=@"Twitter";
    //   [[NSUserDefaults standardUserDefaults] setObject:strTwi forKey:@"key_ShareFromTwitter"];
    [self toGetPreview:@"Twitter" jokeInsult:strSelectedComment];
    
}
//[[TwitterHelper sharedController]._engine sendUpdate:@"fhdjklsafhdjksl"];

-(void) TwitterRequestSuccessfully:(BOOL)successfully{
    [[TwitterHelper sharedController] logOut];
    [self loadAdRequest ];
}



-(void) getTwitterUserInfo{
    
}


#pragma mark - WebService Call
//-(void) TwitterDidLogin:(NSString*)authData userName:(NSString*)userName  successfully:(BOOL)successfully{
-(void)toGetPreview:(NSString *)sharedBy jokeInsult:(NSString *)joke
{
    if([[Reachability sharedReachability] internetConnectionStatus] == NotReachable) {
        [self performSelector:@selector(killHUD)];
        //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Message posted successfully" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        //        [alert show];
        //  [alertView release];
        
    }else {
        SDZDeviceService* service = [SDZDeviceService service];
        service.logging = YES;
        NSString *udid = [APPObject createUUID];
        udid = [udid stringByReplacingOccurrencesOfString:@"-" withString:@""];
        [service SaveSharedJoke:self action:@selector(GetFeedsByUserIDHandler:) target:stringTarget subject:stringSubject joke:joke sharedby:sharedBy sharedfrom:@"Build-A-Dis" deviceType:@"iPhone"];
    }
}


#pragma Mark - handler
- (void) GetFeedsByUserIDHandler: (id) value {
    
    //            NSString *strOneXShareJoke=[[NSUserDefaults standardUserDefaults]objectForKey:@"key_onexShareJoke"];
    //            ///////////
    //            if (![strOneXShareJoke isEqualToString:@"1x"]) {
    //                [[NSUserDefaults standardUserDefaults] setObject:[[delegateApp.arrayPopInfo objectAtIndex:i]objectForKey:@"Duration"] forKey:@"key_onexShareJoke"];
    //                if (delegateApp.ShowpopUpAfterShare==NO) {
    //
    //                    NSString *strOneTime=[NSString stringWithFormat:@"%@",[[delegateApp.arrayPopInfo objectAtIndex:i]objectForKey:@"Duration"]];
    //                    if ([strOneTime isEqualToString:@"Every Time"]) {
    //                        delegateApp.ShowpopUpAfterShare=YES;
    //                    }
    //                    NSString *strLink=[NSString stringWithFormat:@"%@",[[delegateApp.arrayPopInfo objectAtIndex:i]objectForKey:@"target"]];
    //                    if ([strLink isEqualToString:@"Store"]) {
    //                        checkAlertStore=YES;
    //                        showPopUp=YES;
    //                        UIAlertView*  alert=[[UIAlertView alloc]initWithTitle:[[delegateApp.arrayPopInfo objectAtIndex:i]objectForKey:@"subject"] message:[[delegateApp.arrayPopInfo objectAtIndex:i]objectForKey:@"text"] delegate:self cancelButtonTitle:@"No, Thanks" otherButtonTitles:@"Ok", nil];
    //                        [alert show];
    //                        return;
    //                    }else
    //                    {
    //                        showPopUp=YES;
    //                        stringForURL=[NSString stringWithFormat:@"%@",[[delegateApp.arrayPopInfo objectAtIndex:i]objectForKey:@"target"]];
    //                        UIAlertView*  alert=[[UIAlertView alloc]initWithTitle:[[delegateApp.arrayPopInfo objectAtIndex:i]objectForKey:@"subject"] message:[[delegateApp.arrayPopInfo objectAtIndex:i]objectForKey:@"text"] delegate:self cancelButtonTitle:@"No, Thanks" otherButtonTitles:@"Ok", nil];
    //
    //                        [alert show];
    //                        return;
    //                    }
    //                }
    //            }
    //    }
    //  }
    
    // Handle errors
    
    if([value isKindOfClass:[NSError class]]) {
        // //nslog(@"%@", value);
        [self performSelector:@selector(killHUD)];
        //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Message posted successfully" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        //        [alert show];
        
        //---- Set view user inter action anable when image posting failed --------
        return;
        
    }
    
    if([value isKindOfClass:[SoapFault class]]) {
        
        ////nslog(@"%@", value);
        //---- Set view user inter action anable when image posting failed --------
        [self performSelector:@selector(killHUD)];
        //        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@" " message:@"Message posted successfully" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        //        [alert show];
        
        return;
        
    }
    
    NSString* result = (NSString*)value;
    
    //nslog(@"SaveMedia returned the value: %@", result);// i基于古代的经典著作圣经
    
    NSData *aData = [[NSData alloc] initWithData:[result dataUsingEncoding:NSASCIIStringEncoding]];
    
    NSXMLParser *parser=[[NSXMLParser alloc] initWithData:aData];//dataUsingEncoding: NSASCIIStringEncoding];
    
    [parser setDelegate:self];
    
    [parser parse];
    [self performSelector:@selector(killHUD)];
    
    
    
    
    //////////////////////////////
    
    AppDelegate *delegateApp=(AppDelegate *)[UIApplication sharedApplication].delegate;
    
    for (int i=0; i<[delegateApp.arrayPopInfo count]; i++)
    {
        [self performSelector:@selector(killHUD)];
        NSString *strShowPopUp=[NSString stringWithFormat:@"%@",[[delegateApp.arrayPopInfo objectAtIndex:i]objectForKey:@"Location"]];
        
        if ([strShowPopUp isEqualToString:@"After Sharing"]) {
            
            NSString *strOneXShareJoke=[NSString stringWithFormat:@"%@",[[delegateApp.arrayPopInfo objectAtIndex:i]objectForKey:@"Duration"]];
            if ([strOneXShareJoke isEqualToString:@"1x"])
            {
                NSString *strFBShare=[[NSUserDefaults standardUserDefaults]objectForKey:@"key_ShareFromFacebook"];
                NSString *strTWShare=[[NSUserDefaults standardUserDefaults]objectForKey:@"key_ShareFromTwitter"];
                NSString *strEMShare=[[NSUserDefaults standardUserDefaults]objectForKey:@"key_ShareFromEmail"];
                
                NSString *strPreTarget = [[NSUserDefaults standardUserDefaults] objectForKey:@"target"];
                
                NSString *strTarget = [[delegateApp.arrayPopInfo objectAtIndex:i]objectForKey:@"target"];
                
                if ([strPreTarget isEqualToString:strTarget]) {
                    if ([strFBShare isEqualToString:CheckPopUpShowOrNot]) {
                        return;
                    }
                    if ([strTWShare isEqualToString:CheckPopUpShowOrNot]) {
                        return;
                    }
                    if ([strEMShare isEqualToString:CheckPopUpShowOrNot]) {
                        return;
                    }
                }
                else{
                    [[NSUserDefaults standardUserDefaults] setObject:strTarget forKey:@"target"];
                    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"key_ShareFromFacebook"];//
                    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"key_ShareFromTwitter"];
                    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"key_ShareFromEmail"];
                    
                }
                if ([CheckPopUpShowOrNot isEqualToString:@"FaceBook"]) {
                    
                    [[NSUserDefaults standardUserDefaults] setObject:CheckPopUpShowOrNot forKey:@"key_ShareFromFacebook"];//
                }
                if ([CheckPopUpShowOrNot isEqualToString:@"Twitter"]) {
                    
                    [[NSUserDefaults standardUserDefaults] setObject:CheckPopUpShowOrNot forKey:@"key_ShareFromTwitter"];
                }
                if ([CheckPopUpShowOrNot isEqualToString:@"Email"]) {
                    
                    [[NSUserDefaults standardUserDefaults] setObject:CheckPopUpShowOrNot forKey:@"key_ShareFromEmail"];
                }
                
                NSString *strLink=[NSString stringWithFormat:@"%@",[[delegateApp.arrayPopInfo objectAtIndex:i]objectForKey:@"target"]];
                if ([strLink isEqualToString:@"Store"]) {
                    checkAlertStore=YES;
                    showPopUp=YES;
                    UIAlertView*  alert=[[UIAlertView alloc]initWithTitle:[[delegateApp.arrayPopInfo objectAtIndex:i]objectForKey:@"subject"] message:[[delegateApp.arrayPopInfo objectAtIndex:i]objectForKey:@"text"] delegate:self cancelButtonTitle:@"No, Thanks" otherButtonTitles:@"Ok", nil];
                    alert.tag = i;
                    [alert show];
                    return;
                }else
                {
                    showPopUp=YES;
                    stringForURL=[NSString stringWithFormat:@"%@",[[delegateApp.arrayPopInfo objectAtIndex:i]objectForKey:@"target"]];
                    UIAlertView*  alert=[[UIAlertView alloc]initWithTitle:[[delegateApp.arrayPopInfo objectAtIndex:i]objectForKey:@"subject"] message:[[delegateApp.arrayPopInfo objectAtIndex:i]objectForKey:@"text"] delegate:self cancelButtonTitle:@"No, Thanks" otherButtonTitles:@"Ok", nil];
                    alert.tag = i;
                    [alert show];
                    return;
                }
                
                
            }
            else if([strOneXShareJoke isEqualToString:@"Every Time"])
            {
                [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"key_ShareFromFacebook"];//
                [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"key_ShareFromTwitter"];
                [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"key_ShareFromEmail"];
                NSString *strLink=[NSString stringWithFormat:@"%@",[[delegateApp.arrayPopInfo objectAtIndex:i]objectForKey:@"target"]];
                if ([strLink isEqualToString:@"Store"]) {
                    checkAlertStore=YES;
                    showPopUp=YES;
                    UIAlertView*  alert=[[UIAlertView alloc]initWithTitle:[[delegateApp.arrayPopInfo objectAtIndex:i]objectForKey:@"subject"] message:[[delegateApp.arrayPopInfo objectAtIndex:i]objectForKey:@"text"] delegate:self cancelButtonTitle:@"No, Thanks" otherButtonTitles:@"Ok", nil];
                    alert.tag = i;
                    [alert show];
                    return;
                }else
                {
                    showPopUp=YES;
                    stringForURL=[NSString stringWithFormat:@"%@",[[delegateApp.arrayPopInfo objectAtIndex:i]objectForKey:@"target"]];
                    UIAlertView*  alert=[[UIAlertView alloc]initWithTitle:[[delegateApp.arrayPopInfo objectAtIndex:i]objectForKey:@"subject"] message:[[delegateApp.arrayPopInfo objectAtIndex:i]objectForKey:@"text"] delegate:self cancelButtonTitle:@"No, Thanks" otherButtonTitles:@"Ok", nil];
                    alert.tag = i;
                    [alert show];
                    return;
                }
            }
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    }
    
}

-(void)dealloc
{
    if (scrollView1!=nil) {
        //nslog(@"ScrollView not nil dealloc");
        scrollView1=nil;
    }
}


@end
