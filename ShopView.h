//
//  ShopView.h
//  PicAPal
//
//  Created by USER USER on 8/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InAppPurchaseManager.h"
#import "HudView.h"

#define kInAppPurchaseManagerProductsFetchedNotification @"kInAppPurchaseManagerProductsFetchedNotification"
#define kInAppPurchaseManagerProductsNotFetchedNotification @"kInAppPurchaseManagerProductsNotFetchedNotification"
#define kInAppPurchaseManagerTransactionCancelNotification @"kInAppPurchaseManagerTransactionCancelNotification"
#define kInAppPurchaseManagerTransactionFailedNotification @"kInAppPurchaseManagerTransactionFailedNotification"
#define kInAppPurchaseManagerTransactionSucceededNotification @"kInAppPurchaseManagerTransactionSucceededNotification"
#define kInAppPurchaseManagerRestoreSucceededNotification @"kInAppPurchaseManagerRestoreSucceededNotification"

@interface ShopView : UIViewController<UITableViewDelegate,UITableViewDataSource,NSXMLParserDelegate,UIAlertViewDelegate>
{

    //UIbutton to go back
    UIButton *btnback;
    //Hud View to Show Prtoces Bar
    HudView *aHUD;
    //Uibutton to show fatFree , Expansion Pack, No Ads Unlock all and pickapal app
    UIButton *btnFatPack,*btnExpansionPack,*btnNoAds,*btnUnlockAll,*btnPickUpPal,*btnRestore;
    
    UIButton *btnFatPack1,*btnExpansionPack1,*btnNoAds1,*btnUnlockAll1,*btnPickUpPal1;
    
    BOOL isRestoring;
    UIScrollView *mainScrollView;

}
@property(nonatomic,strong)IBOutlet UIButton *btnFatPack1,*btnExpansionPack1,*btnNoAds1,*btnUnlockAll1,*btnPickUpPal1;
@property(nonatomic,strong)IBOutlet UIButton *btnFatPack,*btnExpansionPack,*btnNoAds,*btnUnlockAll,*btnPickUpPal,*btnRestore;
@property(nonatomic,strong)IBOutlet UIButton *btnback;
@property(nonatomic,strong)IBOutlet UIScrollView *mainScrollView;

//Method to go back
-(IBAction)back:(id)sender;
//To Show app store for pick a apal app
-(IBAction)pickAPalApp:(id)sender;
//Purchase fat pack
-(IBAction)purchaseFatPack:(id)sender;
//To purchase Expansion pak 
-(IBAction)purchaseExpansionPack:(id)sender;
//To Purchase No Ads 
-(IBAction)purchaseNoAds:(id)sender;
//To purchase Unlock all
-(IBAction)purchaseUnlockAll:(id)sender;
//For restoring the transactions
-(IBAction)btnRestore:(id)sender;


@end
