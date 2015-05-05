//
//  PopulatorView.h
//  PicAPal
//
//  Created by USER USER on 8/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#include <ifaddrs.h>
#include <arpa/inet.h>
#import "FacebookController.h"
#import "HudView.h"
#import "TapScrollView.h"
#import "TwitterHelper.h"



@interface PopulatorView : UIViewController<UIActionSheetDelegate,MFMailComposeViewControllerDelegate,FacebookControllerDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UIScrollViewDelegate,UIAlertViewDelegate,TwitterHelperDelegate,SA_OAuthTwitterControllerDelegate,NSXMLParserDelegate>
{
    //UiimageView for banner
    IBOutlet UIImageView *imageViewBanner;
    //Button to  show populate icon
    IBOutlet UIButton *btnPopulatorIcon;
    // Lbl to show two lines
    IBOutlet UILabel *lblLineOne,*lblLineTwo;
    
    //uibutton to go back home
    UIButton *btnHome;
    //uibutton to go shop view
    UIButton *btnShop;
    //UIbutton to Show action sheet
    UIButton *btnActionSheet;
    //To Show Hud View
    HudView *aHUD;
    // Twitter AuthEngine
    SA_OAuthTwitterEngine *_engine;
    //UIpickerView to show send texts
    UIPickerView *pickerViewtext;
    //nsmutableArray to get data from database 
    NSMutableArray *arrayToShowData;

    //UIview tyo show custom Action sheet
    UIView *viewActionSheet;
    
    TapScrollView *scrollView1;
    
    NSString *stringTarget, *stringSubject;
    
    ////=======
    NSMutableArray *arrayUpdatedAray;
    //Bool for Check all insult has been seen on not 
    BOOL checkInsult,checkClick,checkPurchased;
    NSInteger counter,counterPage,page;
    BOOL hasStarted;
    
}
@property(nonatomic,strong)UIImageView *imageViewBanner;
@property(nonatomic,strong)IBOutlet UIButton *btnPopulatorIcon;
@property(nonatomic,strong)UILabel *lblLineOne,*lblLineTwo;
@property(nonatomic,strong)NSMutableArray *arrayUpdatedAray;
@property(nonatomic,strong)TapScrollView *scrollView1;
@property(nonatomic,strong)IBOutlet NSString *stringTarget, *stringSubject;
@property(nonatomic,strong)UIView *viewActionSheet;
@property(nonatomic,strong) UIPickerView *pickerViewtext;
@property(nonatomic,strong)IBOutlet UIButton *btnActionSheet,*btnShop;
@property(nonatomic,strong)IBOutlet  UIButton *btnHome;
//TO go home screen 
-(IBAction)homeView:(id)sender;
//To Share text
-(IBAction)showActionSheet:(id)sender;
//To Show shopview
-(IBAction)shopView:(id)sender;
//To Show custom Action sheet
-(IBAction)setLibraryAttributes;
//To get rendam number
-(int)randomNumber:(int)num;
//TO change Insult
-(IBAction)rotateInsult:(id)sender;
//Method of web service
-(void)toGetPreview:(NSString *)sharedBy jokeInsult:(NSString *)joke;

@end
