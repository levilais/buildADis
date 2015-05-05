//
//  AppDelegate.h
//  PicAPal
//
//  Created by Anoop Gupta on 8/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    

    UINavigationController *navcon;
    BOOL fatpack;
    BOOL expansionPack;
    BOOL noAds;
    BOOL unlockAll;
    NSMutableArray *m_arrayInsults;
    
    NSString *saveSubject;
    NSString *saveTarget;
    
    int intScrollOffset;
    
    BOOL changeSize;
    BOOL checkRun;
    BOOL checkForHoneScreen;
    BOOL checkForPopulaterScreen;
BOOL showPopUpOneTime,ShowpopUpAfterShareFB,ShowpopUpAfterShareTW,ShowpopUpAfterShareEM;
    NSMutableArray *arrayPopInfo;
}
@property(nonatomic,strong)NSMutableArray *arrayPopInfo;
@property(nonatomic)BOOL changeSize,checkRun,checkForHoneScreen,checkForPopulaterScreen,showPopUpOneTime,ShowpopUpAfterShareFB,ShowpopUpAfterShareTW,ShowpopUpAfterShareEM;
@property(nonatomic,assign) int intScrollOffset;
@property(nonatomic,strong)NSString *saveSubject ,*saveTarget;
@property(nonatomic,strong)NSMutableArray *m_arrayInsults;
@property(nonatomic)BOOL fatpack,expansionPack,noAds,unlockAll ;
@property (strong, nonatomic) IBOutlet UIWindow *window;
@property (strong, nonatomic) IBOutlet UINavigationController *navcon;
- (void) copyDatabaseIfNeeded;
- (NSString *) getDBPath;
+ (sqlite3 *) getNewDBConnection;
//for banner

-(void)hidShow:(BOOL)hid;


-(void)showAd;

@end
