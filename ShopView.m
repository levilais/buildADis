//
//  ShopView.m
//  PicAPal
//
//  Created by USER USER on 8/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ShopView.h"
#import "AppDelegate.h"
#import "Reachability.h"
#import "SDZServices.h"
#import "SDZDeviceService.h"
#import "UIDevice+Resolutions.h"
#import "APPObject.h"

#define FATPACK @"FatPackD1000"
#define EXPANSIONPACK @"ExpansionD100"
#define NOADPACK @"NoAdPackD100"
#define ALLPACK1 @"PurchaseAllPacksD_100"
#define ALLPACK2 @"PurchaseAll2T"

BOOL checkPurchased;

BOOL checkAllPurchase;
NSString *strCheckProduct;
@implementation ShopView



//Nsstring to check purchase 

@synthesize btnback;
@synthesize btnNoAds,btnFatPack,btnPickUpPal,btnUnlockAll,btnExpansionPack,btnRestore;
@synthesize btnNoAds1,btnFatPack1,btnPickUpPal1,btnUnlockAll1,btnExpansionPack1;
@synthesize mainScrollView;

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
    
    isRestoring = NO;
    
    if ([[UIScreen mainScreen] bounds].size.height == 568) {
        mainScrollView.contentSize = CGSizeMake(320, 548-50);
    }
    else{
        mainScrollView.contentSize = CGSizeMake(320, 410+65);
    }
    
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

    checkPurchased=YES;
    
    [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
    
    // [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_texture.png"]]];
    [self.navigationController setNavigationBarHidden:YES];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveTestNotification:) 
                                                 name:kInAppPurchaseManagerTransactionSucceededNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveTestNotification:) 
                                                 name:kInAppPurchaseManagerProductsNotFetchedNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveTestNotification:) 
                                                 name:kInAppPurchaseManagerTransactionFailedNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveTestNotification:) 
                                                 name:kInAppPurchaseManagerRestoreSucceededNotification
                                               object:nil];
    
    NSString *strFatPackP=[[NSUserDefaults standardUserDefaults]objectForKey:@"key_FatPack"];
    NSString *strExpPack=[[NSUserDefaults standardUserDefaults]objectForKey:@"key_ExpansionPack"];
    NSString *strHidePack=[[NSUserDefaults standardUserDefaults]objectForKey:@"key_HiddenAdPack"];
    NSString *strALlPack=[[NSUserDefaults standardUserDefaults]objectForKey:@"key_PurchaseAll"];
    
    
    
    if ([strFatPackP isEqualToString:@"FatPack"] && [strExpPack isEqualToString:@"ExpansionPack"])
    {
        
    [btnUnlockAll setBackgroundImage:[UIImage imageNamed:@"unlock_all_2N.png"] forState:UIControlStateNormal];
        checkAllPurchase=YES;
        
    }else if([strFatPackP isEqualToString:@"FatPack"] && [strExpPack isEqualToString:@"HiddenAdPack"])
    {
        checkAllPurchase=YES;
     [btnUnlockAll setBackgroundImage:[UIImage imageNamed:@"unlock_all_2N.png"] forState:UIControlStateNormal];
    }else if ([strExpPack isEqualToString:@"ExpansionPack"] && [strHidePack isEqualToString:@"HiddenAdPack"])
    {checkAllPurchase=YES;
         [btnUnlockAll setBackgroundImage:[UIImage imageNamed:@"unlock_all_2N.png"] forState:UIControlStateNormal];
    }
    
    if ([strFatPackP isEqualToString:@"FatPack"]&&[strExpPack isEqualToString:@"ExpansionPack"]&&[strHidePack isEqualToString:@"HiddenAdPack"]) {
        [btnUnlockAll setBackgroundImage:[UIImage imageNamed:@"unlock_allN.png"] forState:UIControlStateNormal];
    }
    
    if ([strALlPack isEqualToString:@"PurchaseAll"])
    {
        [btnUnlockAll setUserInteractionEnabled:NO];
        [btnNoAds setUserInteractionEnabled:NO];
        [btnFatPack setUserInteractionEnabled:NO];
        [btnExpansionPack setUserInteractionEnabled:NO];
        
        [btnNoAds setBackgroundImage:[UIImage imageNamed:@"noaidsN.png"] forState:UIControlStateNormal];
         [btnExpansionPack setBackgroundImage:[UIImage imageNamed:@"100_packN.png"] forState:UIControlStateNormal];
        [btnUnlockAll setBackgroundImage:[UIImage imageNamed:@"unlock_allN.png"] forState:UIControlStateNormal];
        [btnFatPack setBackgroundImage:[UIImage imageNamed:@"fat_packNew.png"] forState:UIControlStateNormal];
    
    }
    if ([strFatPackP isEqualToString:@"FatPack"]) {
        [btnFatPack setUserInteractionEnabled:NO];
        //fat_packNew.png
        [btnFatPack setBackgroundImage:[UIImage imageNamed:@"fat_packNew.png"] forState:UIControlStateNormal];
    }
    if ([strExpPack isEqualToString:@"ExpansionPack"]) {
        [btnExpansionPack setUserInteractionEnabled:NO];
        [btnExpansionPack setBackgroundImage:[UIImage imageNamed:@"100_packN.png"] forState:UIControlStateNormal];
    }
    
    if ([strHidePack isEqualToString:@"HiddenAdPack"]) {
        [btnNoAds setUserInteractionEnabled:NO];
        [btnNoAds setBackgroundImage:[UIImage imageNamed:@"noaidsN.png"] forState:UIControlStateNormal];
    }

    if ([UIDevice currentResolution]==UIDevice_iPhoneTallerHiRes ) {
        btnUnlockAll.frame=CGRectMake(5,77-50 ,310 ,55 );
        btnFatPack.frame=CGRectMake(5,144-50 ,310 ,55 );
        btnExpansionPack.frame=CGRectMake(5,207-50 ,310 ,55 );
        btnNoAds.frame=CGRectMake(5,273-50 ,310 ,55 );
        btnPickUpPal.frame=CGRectMake(5,338-50 ,310 ,55);
        btnRestore.frame = CGRectMake(5, 403-50, 310, 55);
    }
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSString *strFatPackP=[[NSUserDefaults standardUserDefaults]objectForKey:@"key_FatPack"];
    NSString *strExpPack=[[NSUserDefaults standardUserDefaults]objectForKey:@"key_ExpansionPack"];
    NSString *strHidePack=[[NSUserDefaults standardUserDefaults]objectForKey:@"key_HiddenAdPack"];
    NSString *strALlPack=[[NSUserDefaults standardUserDefaults]objectForKey:@"key_PurchaseAll"];
    
    if ([strFatPackP isEqualToString:@"FatPack"] && [strExpPack isEqualToString:@"ExpansionPack"])
    {
        
        [btnUnlockAll setBackgroundImage:[UIImage imageNamed:@"unlock_all_2N.png"] forState:UIControlStateNormal];
        checkAllPurchase=YES;
        
    }else if([strFatPackP isEqualToString:@"FatPack"] && [strExpPack isEqualToString:@"HiddenAdPack"])
    {
        checkAllPurchase=YES;
        [btnUnlockAll setBackgroundImage:[UIImage imageNamed:@"unlock_all_2N.png"] forState:UIControlStateNormal];
    }else if ([strExpPack isEqualToString:@"ExpansionPack"] && [strHidePack isEqualToString:@"HiddenAdPack"])
    {checkAllPurchase=YES;
        [btnUnlockAll setBackgroundImage:[UIImage imageNamed:@"unlock_all_2N.png"] forState:UIControlStateNormal];
    }
    
    if ([strFatPackP isEqualToString:@"FatPack"]&&[strExpPack isEqualToString:@"ExpansionPack"]&&[strHidePack isEqualToString:@"HiddenAdPack"]) {
        [btnUnlockAll setBackgroundImage:[UIImage imageNamed:@"unlock_allN.png"] forState:UIControlStateNormal];
    }
    
    if ([strALlPack isEqualToString:@"PurchaseAll"])
    {
        [btnUnlockAll setUserInteractionEnabled:NO];
        [btnNoAds setUserInteractionEnabled:NO];
        [btnFatPack setUserInteractionEnabled:NO];
        [btnExpansionPack setUserInteractionEnabled:NO];
        
        [btnNoAds setBackgroundImage:[UIImage imageNamed:@"noaidsN.png"] forState:UIControlStateNormal];
        [btnExpansionPack setBackgroundImage:[UIImage imageNamed:@"100_packN.png"] forState:UIControlStateNormal];
        [btnUnlockAll setBackgroundImage:[UIImage imageNamed:@"unlock_allN.png"] forState:UIControlStateNormal];
        [btnFatPack setBackgroundImage:[UIImage imageNamed:@"fat_packNew.png"] forState:UIControlStateNormal];
        
    }
    if ([strFatPackP isEqualToString:@"FatPack"]) {
        [btnFatPack setUserInteractionEnabled:NO];
        //fat_packNew.png
        [btnFatPack setBackgroundImage:[UIImage imageNamed:@"fat_packNew.png"] forState:UIControlStateNormal];
    }
    if ([strExpPack isEqualToString:@"ExpansionPack"]) {
        [btnExpansionPack setUserInteractionEnabled:NO];
        [btnExpansionPack setBackgroundImage:[UIImage imageNamed:@"100_packN.png"] forState:UIControlStateNormal];
    }
    
    if ([strHidePack isEqualToString:@"HiddenAdPack"]) {
        [btnNoAds setUserInteractionEnabled:NO];
        [btnNoAds setBackgroundImage:[UIImage imageNamed:@"noaidsN.png"] forState:UIControlStateNormal];
    }
    
    if ([UIDevice currentResolution]==UIDevice_iPhoneTallerHiRes ) {
        btnUnlockAll.frame=CGRectMake(5,77-50 ,310 ,55 );
        btnFatPack.frame=CGRectMake(5,144-50 ,310 ,55 );
        btnExpansionPack.frame=CGRectMake(5,207-50 ,310 ,55 );
        btnNoAds.frame=CGRectMake(5,273-50 ,310 ,55 );
        btnPickUpPal.frame=CGRectMake(5,338-50 ,310 ,55);
        btnRestore.frame = CGRectMake(5, 403-50, 310, 55);
    }

}

#pragma mark - In_App Purchase Methods

-(void)inApp
{
    [self performSelector:@selector(showHUD)];
    [[InAppPurchaseManager sharedController] initWithProductIdentifier:@"100BK"];
    
}

- (IBAction)btnRestore:(id)sender
{
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"key_PurchaseAll"] isEqualToString:@"PurchaseAll"]) {
        [[[UIAlertView alloc] initWithTitle:@"" message:@"You have already purchased all items." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil] show];
    }
    else
    {
        isRestoring = YES;
        [self performSelector:@selector(showHUD)];
        [[InAppPurchaseManager sharedController] restorePrevious];
    }
}


//To purchase fat pack
-(IBAction)purchaseFatPack:(id)sender
{
    isRestoring = NO;
//    NSString *strFatPackP=[[NSUserDefaults standardUserDefaults]objectForKey:@"key_FatPack"];
//    
//    if ([strFatPackP isEqualToString:@"FatPack"]) {
//        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Message" message:@"You have already purchased fat pack " delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alert show];
//        
//    }else
//    {
        strCheckProduct=@"FatPackPurchase";
                    [self performSelector:@selector(showHUD)];
                   [[InAppPurchaseManager sharedController] initWithProductIdentifier:FATPACK];
        //[self performSelector:@selector(purchaseFatData)];//FatPackD1000  
//    }
    // [[InAppPurchaseManager sharedController] initWithProductIdentifier:@"100BP"];
    
}

-(void)purchaseFatData
{
    sqlite3  *database=[AppDelegate getNewDBConnection]; 
    //update from 
    if(sqlite3_exec(database,[[NSString stringWithFormat:@"UPDATE BuildADisTable SET IsActive='Yes' Where Pack ='Fat'"] UTF8String], NULL, NULL, NULL)==0)
    {
        checkPurchased=NO;
        NSString *strselected=[NSString stringWithFormat:@"%@",@"FatPack"];
        [[NSUserDefaults standardUserDefaults] setObject:strselected forKey:@"key_FatPack"];
        
        NSString *strFatPackP=[[NSUserDefaults standardUserDefaults]objectForKey:@"key_FatPack"];
        NSString *strExpPack=[[NSUserDefaults standardUserDefaults]objectForKey:@"key_ExpansionPack"];
        NSString *strHidePack=[[NSUserDefaults standardUserDefaults]objectForKey:@"key_HiddenAdPack"];

        if ([strFatPackP isEqualToString:@"FatPack"]&&[strExpPack isEqualToString:@"ExpansionPack"]&&[strHidePack isEqualToString:@"HiddenAdPack"]) {
            [btnUnlockAll setBackgroundImage:[UIImage imageNamed:@"unlock_allN.png"] forState:UIControlStateNormal];
        }
        
        if (!isRestoring) {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"" message:@"Purchase Successfully" delegate:self  cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
        }
        
    }  else 
    {
        
    }
    sqlite3_close(database);
}


//To purchase Expansion pak 
-(IBAction)purchaseExpansionPack:(id)sender
{
    isRestoring = NO;
//    NSString *strExpPack=[[NSUserDefaults standardUserDefaults]objectForKey:@"key_ExpansionPack"];
//    
//    if ([strExpPack isEqualToString:@"ExpansionPack"]) {
//        
//        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Message" message:@"You have already purchased expansion pack " delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alert show];
//        
//    }else
//    {
        strCheckProduct=@"ExpPackPurchase";
                    [self performSelector:@selector(showHUD)];
                   [[InAppPurchaseManager sharedController] initWithProductIdentifier:EXPANSIONPACK];
        //[self performSelector:@selector(purchaseExpensionData)];//ExpansionD100  
        // [[InAppPurchaseManager sharedController] initWithProductIdentifier:@"1003H"];
        
//    }
}
-(void)purchaseExpensionData
{
    sqlite3  *database=[AppDelegate getNewDBConnection]; 
    //update from 
    if(sqlite3_exec(database,[[NSString stringWithFormat:@"UPDATE BuildADisTable SET IsActive = 'Yes' Where Pack = 'Expansion'"] UTF8String], NULL, NULL, NULL)==0)
    {
        
        
        checkPurchased=NO;
        NSString *strselected=[NSString stringWithFormat:@"%@",@"ExpansionPack"];
        [[NSUserDefaults standardUserDefaults] setObject:strselected forKey:@"key_ExpansionPack"];
        NSString *strFatPackP=[[NSUserDefaults standardUserDefaults]objectForKey:@"key_FatPack"];
        NSString *strExpPack=[[NSUserDefaults standardUserDefaults]objectForKey:@"key_ExpansionPack"];
        NSString *strHidePack=[[NSUserDefaults standardUserDefaults]objectForKey:@"key_HiddenAdPack"];

        if ([strFatPackP isEqualToString:@"FatPack"]&&[strExpPack isEqualToString:@"ExpansionPack"]&&[strHidePack isEqualToString:@"HiddenAdPack"]) {
            [btnUnlockAll setBackgroundImage:[UIImage imageNamed:@"unlock_allN.png"] forState:UIControlStateNormal];
        }
        
        if (!isRestoring) {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"" message:@"Purchase Successfully" delegate:self  cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
        }
        
        
    }  else 
    {
        
    }
    sqlite3_close(database);
}



//To Purchase No Ads 
-(IBAction)purchaseNoAds:(id)sender
{
    isRestoring = NO;
//    NSString *strExpPack=[[NSUserDefaults standardUserDefaults]objectForKey:@"key_HiddenAdPack"];
//    
//    if ([strExpPack isEqualToString:@"HiddenAdPack"]) {
//        
//        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Message" message:@"You have already purchased iAd pack " delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alert show];
//        
//    }else{
        strCheckProduct=@"NoAdPackPurchase";
            [self performSelector:@selector(showHUD)];
            [[InAppPurchaseManager sharedController] initWithProductIdentifier:NOADPACK];
        //[self performSelector:@selector(hiddenAdds)];     //NoAdPackD100   
//    }
    
}

-(void)hiddenAdds
{
    AppDelegate *delegateApp=(AppDelegate *)[UIApplication sharedApplication].delegate;
    
    delegateApp.checkForHoneScreen=YES;
    delegateApp.checkForPopulaterScreen=YES;
    NSString *strselected=@"HiddenAdPack";
    [[NSUserDefaults standardUserDefaults] setObject:strselected forKey:@"key_HiddenAdPack"];
    NSString *strFatPackP=[[NSUserDefaults standardUserDefaults]objectForKey:@"key_FatPack"];
    NSString *strExpPack=[[NSUserDefaults standardUserDefaults]objectForKey:@"key_ExpansionPack"];
    NSString *strHidePack=[[NSUserDefaults standardUserDefaults]objectForKey:@"key_HiddenAdPack"];

    if ([strFatPackP isEqualToString:@"FatPack"]&&[strExpPack isEqualToString:@"ExpansionPack"]&&[strHidePack isEqualToString:@"HiddenAdPack"]) {
        [btnUnlockAll setBackgroundImage:[UIImage imageNamed:@"unlock_allN.png"] forState:UIControlStateNormal];
    }
    
    if (!isRestoring) {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"" message:@"Purchase Successfully" delegate:self  cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }
    
}

//To purchase Unlock all
-(IBAction)purchaseUnlockAll:(id)sender
{
    isRestoring = NO;
//    NSString *strExpPack=[[NSUserDefaults standardUserDefaults]objectForKey:@"key_PurchaseAll"];
//    
//    if ([strExpPack isEqualToString:@"PurchaseAll"]) {
//        
//        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Message" message:@"You have already purchased All pack " delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alert show];
//        
//    }else
//    {//PurchaseAllPack
        strCheckProduct=@"AllPackPurchase";
        [self performSelector:@selector(showHUD)];
        if (checkAllPurchase==YES) {
            [[InAppPurchaseManager sharedController] initWithProductIdentifier:ALLPACK1];
        }else
        {
        
        [[InAppPurchaseManager sharedController] initWithProductIdentifier:ALLPACK2];
        }
        //[self performSelector:@selector(PurchaseAll)];PurchaseAll1011 
//    }
}

-(void)PurchaseAll
{
    sqlite3  *database=[AppDelegate getNewDBConnection]; 
    //update from 
    if(sqlite3_exec(database,[[NSString stringWithFormat:@"UPDATE BuildADisTable SET IsActive ='Yes'"] UTF8String], NULL, NULL, NULL)==0)
    {
        checkPurchased=NO;
        NSString *strselected=[NSString stringWithFormat:@"%@",@"ExpansionPack"];
        [[NSUserDefaults standardUserDefaults] setObject:strselected forKey:@"key_ExpansionPack"];
        
        NSString *strselected1=[NSString stringWithFormat:@"%@",@"FatPack"];
        [[NSUserDefaults standardUserDefaults] setObject:strselected1 forKey:@"key_FatPack"];
        
        NSString *strselected2=[NSString stringWithFormat:@"%@",@"PurchaseAll"];
        [[NSUserDefaults standardUserDefaults] setObject:strselected2 forKey:@"key_PurchaseAll"];
        
        
        NSString *strselected3=[NSString stringWithFormat:@"%@",@"HiddenAdPack"];
        [[NSUserDefaults standardUserDefaults] setObject:strselected3 forKey:@"key_HiddenAdPack"];
        
        AppDelegate *delegateApp=(AppDelegate *)[UIApplication sharedApplication].delegate;
        delegateApp.checkForHoneScreen=YES;
        delegateApp.checkForPopulaterScreen=YES;
        
        if (!isRestoring) {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"" message:@"Purchase Successfully" delegate:self  cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
        }
        if ([[UIScreen mainScreen] bounds].size.height == 568) {
            mainScrollView.contentSize = CGSizeMake(320, 548-50);
        }
        else{
            mainScrollView.contentSize = CGSizeMake(320, 460);
        }
        
    }  else 
    {
        
        
    }
    sqlite3_close(database);
    
    
}

#pragma mark - Inner method
- (void) receiveTestNotification:(NSNotification *) notification
{////FatPack  ExpansionPack  HiddenAdPack
    NSString *strFatPackP=[[NSUserDefaults standardUserDefaults]objectForKey:@"key_FatPack"];
    NSString *strExpPack=[[NSUserDefaults standardUserDefaults]objectForKey:@"key_ExpansionPack"];
    NSString *strHidePack=[[NSUserDefaults standardUserDefaults]objectForKey:@"key_HiddenAdPack"];
    if ([[notification name] isEqualToString:kInAppPurchaseManagerTransactionSucceededNotification]){
        
        if ([strCheckProduct isEqualToString:@"FatPackPurchase"]) {
            [self performSelector:@selector(purchaseFatData)];
            [btnFatPack setUserInteractionEnabled:NO];
            
            if ([strExpPack isEqualToString:@"ExpansionPack"]||[strHidePack isEqualToString:@"HiddenAdPack"]) {
                [btnUnlockAll setBackgroundImage:[UIImage imageNamed:@"unlock_all_2N.png"] forState:UIControlStateNormal];
                checkAllPurchase=YES;
            }
            
            [btnFatPack setBackgroundImage:[UIImage imageNamed:@"fat_packNew.png"] forState:UIControlStateNormal];
            strCheckProduct=@"";
        }
        else if([strCheckProduct isEqualToString:@"ExpPackPurchase"])
        {
            [self performSelector:@selector(purchaseExpensionData)];
            [btnExpansionPack setUserInteractionEnabled:NO];
            
            if ([strFatPackP isEqualToString:@"FatPack"]||[strHidePack isEqualToString:@"HiddenAdPack"]) {
                [btnUnlockAll setBackgroundImage:[UIImage imageNamed:@"unlock_all_2N.png"] forState:UIControlStateNormal];
                checkAllPurchase=YES;
            }
            
            [btnExpansionPack setBackgroundImage:[UIImage imageNamed:@"100_packN.png"] forState:UIControlStateNormal];
            strCheckProduct=@"";
        }
        else if([strCheckProduct isEqualToString:@"NoAdPackPurchase"])
        {
            [self performSelector:@selector(hiddenAdds)];
            [btnNoAds setUserInteractionEnabled:NO];//noaidsN.png
            if ([[UIScreen mainScreen] bounds].size.height == 568) {
                mainScrollView.contentSize = CGSizeMake(320, 548-50);
            }
            else{
                mainScrollView.contentSize = CGSizeMake(320, 460);
            }
            
            if ([strFatPackP isEqualToString:@"FatPack"]||[strExpPack isEqualToString:@"ExpansionPack"]) {
                [btnUnlockAll setBackgroundImage:[UIImage imageNamed:@"unlock_all_2N.png"] forState:UIControlStateNormal];
                checkAllPurchase=YES;
            }
            
            //  [btnNoAds setBackgroundImage:[UIImage imageNamed:@"08.png"] forState:UIControlStateNormal];
            [btnNoAds setBackgroundImage:[UIImage imageNamed:@"noaidsN.png"] forState:UIControlStateNormal];
            strCheckProduct=@"";
            
        }else if([strCheckProduct isEqualToString:@"AllPackPurchase"])
        {
            [self performSelector:@selector(PurchaseAll)];
            [btnUnlockAll setBackgroundImage:[UIImage imageNamed:@"unlock_allN.png"] forState:UIControlStateNormal];
            [btnNoAds setBackgroundImage:[UIImage imageNamed:@"noaidsN.png"] forState:UIControlStateNormal];
            [btnExpansionPack setBackgroundImage:[UIImage imageNamed:@"100_packN.png"] forState:UIControlStateNormal];
            [btnFatPack setBackgroundImage:[UIImage imageNamed:@"fat_packNew.png"] forState:UIControlStateNormal];
            
            [btnUnlockAll setUserInteractionEnabled:NO];
            [btnNoAds setUserInteractionEnabled:NO];
            [btnFatPack setUserInteractionEnabled:NO];
            [btnExpansionPack setUserInteractionEnabled:NO];
            
            strCheckProduct=@"";
        }
        
        if ([strFatPackP isEqualToString:@"FatPack"] && [strExpPack isEqualToString:@"ExpansionPack"] && [strHidePack isEqualToString:@"HiddenAdPack"] ) {
            [btnUnlockAll setBackgroundImage:[UIImage imageNamed:@"unlock_allN.png"] forState:UIControlStateNormal];
            if ([[UIScreen mainScreen] bounds].size.height == 568) {
                mainScrollView.contentSize = CGSizeMake(320, 548-50);
            }
            else{
                mainScrollView.contentSize = CGSizeMake(320, 460);
            }
        }
        if (!isRestoring) {
            [self performSelector:@selector(killHUD)];
        }
        
    }
    else if ([[notification name] isEqualToString:kInAppPurchaseManagerRestoreSucceededNotification])
    {
        [self performSelector:@selector(killHUD)];
        NSString *strFatPackP=[[NSUserDefaults standardUserDefaults]objectForKey:@"key_FatPack"];
        NSString *strExpPack=[[NSUserDefaults standardUserDefaults]objectForKey:@"key_ExpansionPack"];
        NSString *strHidePack=[[NSUserDefaults standardUserDefaults]objectForKey:@"key_HiddenAdPack"];
        if ([strFatPackP isEqualToString:@"FatPack"] && [strExpPack isEqualToString:@"ExpansionPack"] && [strHidePack isEqualToString:@"HiddenAdPack"] )
        {
            [btnUnlockAll setUserInteractionEnabled:NO];
            [btnNoAds setUserInteractionEnabled:NO];
            [btnFatPack setUserInteractionEnabled:NO];
            [btnExpansionPack setUserInteractionEnabled:NO];
            
            NSString *strselected2=[NSString stringWithFormat:@"%@",@"PurchaseAll"];
            [[NSUserDefaults standardUserDefaults] setObject:strselected2 forKey:@"key_PurchaseAll"];
            [btnUnlockAll setBackgroundImage:[UIImage imageNamed:@"unlock_allN.png"] forState:UIControlStateNormal];
        }
    }
    else if ([[notification name] isEqualToString:kInAppPurchaseManagerTransactionFailedNotification]){
        
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Message" message:@"Transaction failed. Please try after some time." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alert show];
        [self performSelector:@selector(killHUD)];
    }else if([[notification name] isEqualToString:kInAppPurchaseManagerTransactionCancelNotification]){
        
        
        [self performSelector:@selector(killHUD)];
        
    }else if([[notification name] isEqualToString:kInAppPurchaseManagerProductsNotFetchedNotification]){
        
        [self performSelector:@selector(killHUD)];
    }
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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
        [aHUD loadingViewInView:self.view text:@"Please Wait...."];
        [self.navigationController.navigationBar setUserInteractionEnabled:NO];
		[self.view setUserInteractionEnabled:NO];
		[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
		
	}
}



#pragma mark - Method to go on back screen 

-(IBAction)back:(id)sender
{
    
    [self dismissModalViewControllerAnimated:YES];
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - FreeApp PickAPal 
-(IBAction)pickAPalApp:(id)sender
{
    [self performSelector:@selector(showHUD)];
    [self performSelector:@selector(toGetPreview)];
	
    
}
#pragma mark - WebService Call

-(void)toGetPreview
{
    if([[Reachability sharedReachability] internetConnectionStatus] == NotReachable) {
        [self performSelector:@selector(killHUD)];
        NSString *urlstring = [[NSString alloc] initWithFormat:@"https://itunes.apple.com/us/app/pick-up-pal/id570136209?ls=1&mt=8"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlstring]];
        //  [alertView release];
        
    }else {
        
        SDZDeviceService* service = [SDZDeviceService service];
        service.logging = YES;
        NSString *udid = [APPObject createUUID];
        udid = [udid stringByReplacingOccurrencesOfString:@"-" withString:@""];
        [service IncrementAppVisitCount:self action:@selector(GetFeedsByUserIDHandler:) appname:@"pickuppal" deviceType:@"IPhone"];
        
    }
}


#pragma Mark - handler
- (void) GetFeedsByUserIDHandler: (id) value {
    
    // Handle errors
    
    if([value isKindOfClass:[NSError class]]) {
        [self performSelector:@selector(killHUD)];
        NSString *urlstring = [[NSString alloc] initWithFormat:@"https://itunes.apple.com/us/app/pick-up-pal/id570136209?ls=1&mt=8"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlstring]];
        //---- Set view user inter action anable when image posting failed --------
        return;
        
    }
    
    if([value isKindOfClass:[SoapFault class]]) {
        
  
        //---- Set view user inter action anable when image posting failed --------
        [self performSelector:@selector(killHUD)];
        NSString *urlstring = [[NSString alloc] initWithFormat:@"https://itunes.apple.com/us/app/pick-up-pal/id570136209?ls=1&mt=8"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlstring]];
        
        return;
        
    }
    
    NSString* result = (NSString*)value;
    
    
    NSData *aData = [[NSData alloc] initWithData:[result dataUsingEncoding:NSASCIIStringEncoding]];
    
    NSXMLParser *parser=[[NSXMLParser alloc] initWithData:aData];//dataUsingEncoding: NSASCIIStringEncoding];
    
    [parser setDelegate:self];
    
    [parser parse];
    [self performSelector:@selector(killHUD)];
    NSString *urlstring = [[NSString alloc] initWithFormat:@"https://itunes.apple.com/us/app/pick-up-pal/id570136209?ls=1&mt=8"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlstring]];

}

#pragma mark - Alert Delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    NSString *strFatPackP=[[NSUserDefaults standardUserDefaults]objectForKey:@"key_FatPack"];
    NSString *strExpPack=[[NSUserDefaults standardUserDefaults]objectForKey:@"key_ExpansionPack"];
    NSString *strHidePack=[[NSUserDefaults standardUserDefaults]objectForKey:@"key_HiddenAdPack"];
     NSString *strButtonTitle=[alertView buttonTitleAtIndex:buttonIndex];
    if ([strButtonTitle isEqualToString:@"Ok"]) {
    
        if ([strFatPackP isEqualToString:@"FatPack"] && [strExpPack isEqualToString:@"ExpansionPack"] && [strHidePack isEqualToString:@"HiddenAdPack"] ) {
            [btnUnlockAll setUserInteractionEnabled:NO];
            [btnNoAds setUserInteractionEnabled:NO];
            [btnFatPack setUserInteractionEnabled:NO];
            [btnExpansionPack setUserInteractionEnabled:NO];
            
            NSString *strselected2=[NSString stringWithFormat:@"%@",@"PurchaseAll"];
            [[NSUserDefaults standardUserDefaults] setObject:strselected2 forKey:@"key_PurchaseAll"];
            [btnUnlockAll setBackgroundImage:[UIImage imageNamed:@"unlock_allN.png"] forState:UIControlStateNormal];
        }

    }
}


@end
