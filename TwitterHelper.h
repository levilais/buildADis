//
//  TwitterHelper.h
//  Wishlu
//
//  Created by Ashish on 2/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
//Twitter
#import "SA_OAuthTwitterController.h"

@protocol TwitterHelperDelegate <NSObject>
@optional
-(void) TwitterDidLogin:(NSString*)authData userName:(NSString*)userName  successfully:(BOOL)successfully;
-(void) TwitterRequestSuccessfully:(BOOL)successfully;
-(void) TwitterLoad:(UIViewController *)controller;

@end
//********** protocall *************  




@class SA_OAuthTwitterEngine;
@interface TwitterHelper : UIViewController <SA_OAuthTwitterControllerDelegate>{//NSObject
    //Twitter
    SA_OAuthTwitterEngine *_engine;
    id<TwitterHelperDelegate> delegate;
    NSString *usernamee,*authDataa;
}
@property(nonatomic,retain)   SA_OAuthTwitterEngine *_engine;
@property(nonatomic,retain)  NSString *usernamee,*authDataa;
@property (nonatomic, retain) id<TwitterHelperDelegate> delegate;

+(TwitterHelper*) sharedController;
-(void) logOut;
-(NSString *) getUserInformationFor:(NSString *)usernameOIid;
-(NSString *) getusername;
//Twitter
-(void)authenticatePerson;
-(void)sendUpdate:(NSString *)status;
@end
