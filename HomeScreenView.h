//
//  HomeScreenView.h
//  PicAPal
//
//  Created by USER USER on 8/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#include <ifaddrs.h>
#include <arpa/inet.h>
#import "FacebookController.h"
#import "HudView.h"
#import <QuartzCore/QuartzCore.h>
//@class SA_OAuthTwitterEngine;
//#import "SA_OAuthTwitterController.h"
#import "TapScrollView.h"
#import "TwitterHelper.h"
#import "CustomScrollView.h"



@interface HomeScreenView : UIViewController<UIActionSheetDelegate,MFMailComposeViewControllerDelegate,FacebookControllerDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UIScrollViewDelegate,TwitterHelperDelegate,SA_OAuthTwitterControllerDelegate>
{
    
    // UiimageView for banner img
    UIImageView *imageViewBanner;
    // UIbutton 
    UIButton *btnShop,*btnShare,*btnPopulatore;
    // uilable to show line
    UILabel *lblShowLine1,*lblShowLine2;
    //Scroll view to show targets and Subjects
    UIScrollView *scrollViewTarget,*scrollViewSubjects;
    
    // Show HUD
    HudView *aHUD;
    
    //UIpickerview to show subjects
    UIPickerView *pickerSubject;
    
    //NSArray to save subject images
	NSArray *arrayOfSubjectImages;
    
    //nsarray to save target Images
    NSArray *arrayOftargetImages;
    
    
    //UIview tyo show custom Action sheet
    UIView *viewActionSheet;
    
    // Arry to target text and subject text
    NSArray *arraytargetText,*arraySubjectText;
    
    //To Show ScrollView For Target 
    IBOutlet UILabel *label;
    UIImageView *currentImage1;
    IBOutlet TapScrollView *scrollView1;
    UILabel *lblSubText;
    
    
    // To show scrollView For Subject 
    IBOutlet TapScrollView *scrollView2;
    UIImageView *currentImage2;
    
    int selectedIndexScrollView1;
    int selectedIndexScrollView2;
    
    //////======== Cusotom Scroll View
    CustomScrollView *scrollViewCust1;
    CustomScrollView *scrollViewCust2;
    
}
@property(nonatomic,strong)IBOutlet UILabel *lblShowLine1,*lblShowLine2;
@property(nonatomic,strong)IBOutlet UIImageView *imageViewBanner;
@property(nonatomic,strong)IBOutlet  UIButton *btnShop,*btnShare,*btnPopulatore;
@property(nonatomic,strong) CustomScrollView *scrollViewCust1,*scrollViewCust2;
//@property(nonatomic,retain)GSTwitPicEngine *twitpicEngine;;
@property(nonatomic,strong)IBOutlet UIView *viewActionSheet;
@property(nonatomic,strong)IBOutlet UIScrollView *scrollViewTarget,*scrollViewSubjects;
@property(nonatomic,strong) UIPickerView *pickerSubject;
@property (strong, nonatomic) IBOutlet UILabel *label, *lblSubText;
@property (strong, nonatomic)  UIImageView *currentImage1,*currentImage2;
@property (strong, nonatomic) IBOutlet TapScrollView *scrollView1,*scrollView2;


//To Show Action Sheet
-(IBAction)showActionSheet:(id)sender;
//To Show Shop View
-(IBAction)shopView:(id)sender;
// To go on populate Screen 
-(IBAction)populaterView:(id)sender;
// To show animated action sheet
-(IBAction)setLibraryAttributes;
//To get rendom number
-(int)randomNumber;

@end
