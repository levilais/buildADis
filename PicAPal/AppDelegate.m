//
//  AppDelegate.m
//  PicAPal
//
//  Created by Anoop Gupta on 8/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import <RevMobAds/RevMobAds.h>

#import "UIDevice+Resolutions.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize navcon;
@synthesize fatpack,expansionPack,noAds,unlockAll;
@synthesize m_arrayInsults;
@synthesize saveTarget,saveSubject;
@synthesize intScrollOffset;
@synthesize changeSize,checkRun;
@synthesize checkForHoneScreen,checkForPopulaterScreen;
@synthesize arrayPopInfo;
@synthesize showPopUpOneTime,ShowpopUpAfterShareFB,ShowpopUpAfterShareTW,ShowpopUpAfterShareEM;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
        /////======   To show add  =======/////

    
    //self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    [self performSelector:@selector(createEditableCopyOfDatabaseIfNeeded)];
    [RevMobAds startSessionWithAppID:@"520bc14c097bd4838d000005"];
    [self.window addSubview:navcon.view];
    [self.window makeKeyAndVisible];
    
    arrayPopInfo=[[NSMutableArray alloc]init];
    
    /////====== to hide app =======//////
    
    NSString *strHideAdd=[[NSUserDefaults standardUserDefaults]objectForKey:@"key_HiddenAdPack"];
   
    checkRun=NO;
    checkForHoneScreen=NO;
    checkForPopulaterScreen=NO;
    showPopUpOneTime=NO;
    ShowpopUpAfterShareFB=NO;
    ShowpopUpAfterShareTW=NO;
    ShowpopUpAfterShareEM=NO;
    ////======   To show add  =======/////
    

    
       // Note: Edit SampleConstants.h to provide a definition for kSampleAdUnitID
    // before compiling
	m_arrayInsults=[[NSMutableArray alloc]init];
    saveTarget=[[NSString alloc]init];
    saveSubject=[[NSString alloc]init];
    intScrollOffset=0;

    return YES;
}



- (void)createEditableCopyOfDatabaseIfNeeded {
    
    //nslog(@"Create a  Editable copy of data base");
    
    // First, test for existence.
    
    BOOL success;
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSError *error;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:@"BuildADisNew2.sqlite"];
    
    success = [fileManager fileExistsAtPath:writableDBPath];
    
    if (success)
        
    {
        //nslog(@"Success........");
        return;
    }
    //The writable database does not exist, so copy the default to the appropriate location.
    
    NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"BuildADisNew2.sqlite"];
    
    success = [fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
    
    if (!success) {
        
        //nslog(@"Failed........");
        
    }
}


//Make connection

+ (sqlite3 *) getNewDBConnection{
    
    
    sqlite3 *newDBconnection;
    
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"BuildADisNew2.sqlite"];
    
    //nslog(@"%@ ",path);
    
    // Open the database. The database was prepared outside the application.
    
    
    if (sqlite3_open([path UTF8String], &newDBconnection) == SQLITE_OK) {
        
        //nslog(@"Database Successfully Opened :");
        
    } else {
        
        //nslog(@"Error in opening database :( “");
    }
    
    return newDBconnection;
    
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

#pragma mark - Show ADs

-(void)showAd
{
    NSString *strHideAdd=[[NSUserDefaults standardUserDefaults]objectForKey:@"key_HiddenAdPack"];
    
    if ([strHideAdd isEqualToString:@"HiddenAdPack"]) {
        
        return;
    }
    [[RevMobAds session] showFullscreen];
}


@end
