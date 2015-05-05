//
//  SplashScreen.h
//  PicAPal
//
//  Created by USER USER on 8/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"


@interface SplashScreen : UIViewController<NSXMLParserDelegate,UIAlertViewDelegate>
{
    NSMutableData *webData;
    NSURLRequest *request;
    NSURLConnection *connection1;
    UIImageView *imageViewSplash;
    NSString *strCurrentElement;
    AppDelegate *delegateApp;
}
@property(nonatomic,strong)AppDelegate *delegateApp;
@property(nonatomic,strong)NSString *strCurrentElement;
@property(nonatomic,strong)IBOutlet UIImageView *imageViewSplash;
@end
