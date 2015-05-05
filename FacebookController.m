//
//  FacebookController.m
//  Blackjack
//
//  Created by onegray on 11/8/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "FacebookController.h"
#import "AppDelegate.h"
//#import "UserProfile.h"
//#import "NSHTTPCookieStorage_Extensions.h"
//Key for Beautifo app on techvalens.testing id

/*Build-A-Dis
 App ID:	189598067840830
 App Secret:	784f417876d5e9275fcbf8daf13a5d96(reset)*/

NSString* kFbApiKey = @"189598067840830";//@"120845078002687";
NSString* kFbApiSecret = @"784f417876d5e9275fcbf8daf13a5d96";//@"eebf609a59ea33f702192bb55cadcf3d";
NSString* kFbAppId = @"189598067840830";//@"120845078002687";

//NSString* kFbApiKey = @"420596224674811";
//NSString* kFbApiSecret = @"99681793353476fea5fc7d7498ff65b5";
//NSString* kFbAppId = @"420596224674811";

//Pictrgraph facebook ID 
//App ID: 	403991063002118
//App Secret: 	5ebebbb60f087765f0e0e989e8438ba0

static NSString* fbLoginServerPath = @"http://login.facebook.com";

typedef enum eFacebookActionType
{
	FAT_NO_ACTION,
	FAT_LOGIN,
	FAT_GET_UID,
    FAT_GET_PIC,
	FAT_PUBLISH_STREAM,
	FAT_GET_FRIENDS,
	FAT_PUBLISH_STREAMS_FOR_USERS,
}FacebookActionType;


@interface FacebookController ()
@property (nonatomic, retain) NSMutableDictionary* publishStreamParams;
@property (nonatomic, retain) NSMutableArray* requestStack;
-(BOOL) publishNextUserStream;
@end

@implementation FacebookController
@synthesize delegate;
@synthesize publishStreamParams;
@synthesize requestStack;

static FacebookController* sharedInstance = nil;

+(FacebookController*) sharedController
{
	if(sharedInstance==nil)
	{
		sharedInstance = [[FacebookController alloc] init];
	}
	return sharedInstance;
}

-(id) init
{
	if(self=[super init])
	{
		action = FAT_NO_ACTION;
	}
	return self;
}

-(void) dealloc
{
	self.publishStreamParams = nil;
	self.requestStack = nil;
	[facebook release];
	facebook=nil;
	[super dealloc];
}

-(BOOL) isLoggedIn
{
	return [facebook isSessionValid];
}

-(void)performRequestFromStack
{
	if([requestStack count]>0)
	{
		NSDictionary* requestDict = [requestStack objectAtIndex:0];
		//////nslog(@"performRequestFromStack \n%@",requestDict);
		[[requestDict retain] autorelease];
		[requestStack removeObjectAtIndex:0];
		[facebook requestWithGraphPath:[requestDict objectForKey:@"graph"]
							 andParams:[requestDict objectForKey:@"params"]
						 andHttpMethod:[requestDict objectForKey:@"method"]
						   andDelegate:self];	
	}
}

-(void) requestLogin
{
	//NSArray* permissions = [NSArray arrayWithObjects: @"publish_stream", @"offline_access",nil];
    NSArray* permissions =  [[NSArray arrayWithObjects:
                              @"email", @"read_stream", @"user_birthday", 
                              @"user_about_me", @"publish_stream", @"offline_access", nil] retain];
	[facebook authorize:kFbAppId permissions:permissions delegate:self];
}

-(void) requestUid
{
	[facebook requestWithGraphPath:@"me" andDelegate:self];
}

-(void) requestFriendList
{
	NSMutableDictionary * params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
									@"SELECT uid, name, pic_square, is_app_user FROM user "
									"WHERE uid IN (SELECT uid2 FROM friend WHERE uid1 = me()) ORDER BY name", @"query", nil];
	[facebook requestWithMethodName:@"fql.query" andParams:params andHttpMethod:@"POST" andDelegate:self];
}

-(void) requestPublishStream
{
    [facebook requestWithGraphPath:@"me/feed" andParams:publishStreamParams andHttpMethod:@"POST" andDelegate:self];	
}

-(void)logout
{
	////nslog(@"FacebookController logout");
	NSURL* fbLoginUrl = [NSURL URLWithString:fbLoginServerPath];
    
	NSHTTPCookieStorage* cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
	NSArray* cookies = [cookieStorage cookiesForURL:fbLoginUrl];
	for (NSHTTPCookie* cookie in cookies) 
	{
		[cookieStorage deleteCookie:cookie];
	}
	if(facebook!=nil)
	{		
		[facebook release];
		facebook = nil;
	}
}


-(void) login
{
	////nslog(@"FacebookController login");
	if(facebook==nil)
	{		
		facebook = [[Facebook alloc] init];
			if( ![facebook isSessionValid] )
		{
			action = (action==FAT_NO_ACTION ? FAT_LOGIN : action);
			[self requestLogin];
		}
		else
		{
			if( [delegate respondsToSelector:@selector(facebookDidLoginSuccessfully:)] )
			{
				[delegate facebookDidLoginSuccessfully:YES];
			}
		}
	}
}

-(void) loginAndGetUid
{
	////nslog(@"FacebookController loginAndGetUid");
	//NSAssert(action==FAT_NO_ACTION, @"FacebookController request is already in progress");
	action = FAT_GET_UID;
	
	[self login];
	
	if( [self isLoggedIn] )
	{
		[self requestUid];
		//[[RootViewController sharedController] presentLoadingAlert];
	}
}

- (void) getProfileImage:(NSString*)fbID{
    ////nslog(@"FacebookController get profile photo");
	//NSAssert(action==FAT_NO_ACTION, @"FacebookController request is already in progress");
	action = FAT_GET_PIC;
    NSString *get_string = [NSString stringWithFormat:@"%@/picture", fbID];
    [facebook requestWithGraphPath:get_string andDelegate:self];
}

-(void) getFriendList
{
	////nslog(@"FacebookController getFriendList");
	//NSAssert(action==FAT_NO_ACTION, @"FacebookController request is already in progress");
	action = FAT_GET_FRIENDS;
	
	[self login];
	
	if( [self isLoggedIn] )
	{
		[self requestFriendList];
		//[[RootViewController sharedController] presentLoadingAlert];
	}
}

-(void) publishStream:(NSDictionary*)publishParams
{
	////nslog(@"FacebookController publishStream");
	//NSAssert(action==FAT_NO_ACTION, @"FacebookController request is already in progress");
	action = FAT_PUBLISH_STREAM;

	self.publishStreamParams = [NSMutableDictionary dictionaryWithDictionary:publishParams];
	
	[self login];
	
	if( [self isLoggedIn] )
	{
		[self requestPublishStream];
		//[[RootViewController sharedController] presentLoadingAlert];
	}
}

-(void) publishStreamsForUsers:(NSDictionary*)publishParamsForUsers
{
	////nslog(@"FacebookController publishStreamsForUsers");
	//NSAssert(action==FAT_NO_ACTION, @"FacebookController request is already in progress");
	action = FAT_PUBLISH_STREAMS_FOR_USERS;
	
	self.requestStack = [NSMutableArray arrayWithCapacity:[publishParamsForUsers count]];
	for(NSString* user in publishParamsForUsers)
	{
		NSDictionary* requestParams = [NSDictionary dictionaryWithObjectsAndKeys:
									   [NSString stringWithFormat:@"%@/feed", user], @"graph",
									   [publishParamsForUsers objectForKey:user], @"params",
									   @"POST", @"method", nil];
		[requestStack addObject:requestParams];
	}
	
	[self login];
	
	if( [self isLoggedIn] )
	{
		[self publishNextUserStream];
		//[[RootViewController sharedController] presentLoadingAlert];
	}
}

-(BOOL) publishNextUserStream
{
	BOOL progress = NO;
	if([requestStack count]>0)
	{
		[self performRequestFromStack];
		progress = YES;
	}
	else
	{
		self.requestStack = nil;
		if( [delegate respondsToSelector:@selector(facebookDidPublishSuccessfully:)] )
		{
			[delegate facebookDidPublishSuccessfully:YES];
		}
	}	
	return progress;
}

- (void)fbDidNotLogin:(BOOL)cancelled
{
	////nslog(@"FacebookController fbDidNotLogin");

	self.publishStreamParams = nil;
	self.requestStack = nil;
	[facebook release];
	facebook = nil; 

	if(!cancelled)
	{
//		[[RootViewController sharedController] presentModalAlertWithTitle:@"Sorry" 
//																  message:@"Facebook login failed" 
//																   target:self
//																 selector:@selector(errorAlertDidClose)
//															 buttonTitles:@"OK", nil];
	}
	
	FacebookActionType fat = action;
	action = FAT_NO_ACTION;
		
	if( [delegate respondsToSelector:@selector(facebookDidLoginSuccessfully:)] )
	{
		[delegate facebookDidLoginSuccessfully:NO];
	}
	
	if(fat==FAT_GET_UID)
	{
		if( [delegate respondsToSelector:@selector(facebookDidGetUid:successfully:)] )
		{
			[delegate facebookDidGetUid:nil successfully:NO];
		}
	}
	else if (fat == FAT_GET_FRIENDS)
	{
		if( [delegate respondsToSelector:@selector(facebookDidGetFiends:successfully:)] )
		{
			[delegate facebookDidGetFiends:nil successfully:NO];
		}
	}
	else if(fat==FAT_PUBLISH_STREAM || fat==FAT_PUBLISH_STREAMS_FOR_USERS)
	{
		if( [delegate respondsToSelector:@selector(facebookDidPublishSuccessfully:)] )
		{
			[delegate facebookDidPublishSuccessfully:NO];
		}
	}else if(fat==FAT_GET_PIC){
        if( [delegate respondsToSelector:@selector(facebookDidGetPic:successfully:)] )
		{
			[delegate facebookDidGetPic:nil successfully:NO];
		}
    }
	
}

-(void) fbDidLogin 
{
	////nslog(@"FacebookController fbDidLogin");
	
	if(action == FAT_LOGIN)
	{
		action = FAT_NO_ACTION;
		
		if( [delegate respondsToSelector:@selector(facebookDidLoginSuccessfully:)] )
		{
			[delegate facebookDidLoginSuccessfully:YES];
		}
	}
	else if (action == FAT_GET_UID)
	{
		[self requestUid];
		//[[RootViewController sharedController] presentLoadingAlert];
	}
	else if (action == FAT_GET_FRIENDS)
	{
		[self requestFriendList];
		//[[RootViewController sharedController] presentLoadingAlert];
	}
	else if (action == FAT_PUBLISH_STREAM)
	{
		[self requestPublishStream];
		//[[RootViewController sharedController] presentLoadingAlert];
	}	
	else if (action == FAT_PUBLISH_STREAMS_FOR_USERS)
	{
		BOOL progress = [self publishNextUserStream];
		if(progress)
		{
			//[[RootViewController sharedController] presentLoadingAlert];
		}
	}
	
}

- (void)request:(FBRequest*)request didFailWithError:(NSError*)error 
{
	//////nslog(@"FacebookController request:didFailWithError: %@",[error localizedDescription]);
	FacebookActionType fat = action;
	action = FAT_NO_ACTION;
	
	if(fat==FAT_GET_UID)
	{
		if( [delegate respondsToSelector:@selector(facebookDidGetUid:successfully:)] )
		{
			[delegate facebookDidGetUid:nil successfully:NO];
		}
	}
	else if (fat == FAT_GET_FRIENDS)
	{
		if( [delegate respondsToSelector:@selector(facebookDidGetFiends:successfully:)] )
		{
			[delegate facebookDidGetFiends:nil successfully:NO];
		}
	}
	else if(fat==FAT_PUBLISH_STREAM)
	{
		self.publishStreamParams = nil;
		
		if( [delegate respondsToSelector:@selector(facebookDidPublishSuccessfully:)] )
		{
			[delegate facebookDidPublishSuccessfully:NO];
		}
	}
	else if(fat==FAT_PUBLISH_STREAMS_FOR_USERS)
	{
		/*
		self.requestStack = nil;
		
		if( [delegate respondsToSelector:@selector(facebookDidPublishSuccessfully:)] )
		{
			[delegate facebookDidPublishSuccessfully:NO];
		}
		*/
		
		BOOL progress = [self publishNextUserStream];
		if(!progress)
		{
			//[[RootViewController sharedController] dismissModalAlert];
			action = FAT_NO_ACTION;
		}
	}else if(fat==FAT_GET_PIC){
        if( [delegate respondsToSelector:@selector(facebookDidGetPic:successfully:)] )
		{
			[delegate facebookDidGetPic:nil successfully:NO];
		}
    }
	
}

- (void)request:(FBRequest*)request didLoad:(id)result
{
	//////nslog(@"FacebookController request:didLoad: %@", result);
	if ([result isKindOfClass:[NSDictionary class]]) {
        [[NSUserDefaults standardUserDefaults] setObject:[result objectForKey:@"id"] forKey:@"facebookId"];
        [[NSUserDefaults standardUserDefaults] setObject:[result objectForKey:@"first_name"] forKey:@"first_name"];
        [[NSUserDefaults standardUserDefaults] setObject:[result objectForKey:@"last_name"] forKey:@"last_name"];
        [[NSUserDefaults standardUserDefaults] setObject:[result objectForKey:@"gender"] forKey:@"gender"];
        [[NSUserDefaults standardUserDefaults] setObject:[result objectForKey:@"name"] forKey:@"Username"];
        [[NSUserDefaults standardUserDefaults] setObject:[result objectForKey:@"email"] forKey:@"facebookEmailId"];
        [[NSUserDefaults standardUserDefaults] setObject:[result objectForKey:@"birthday"] forKey:@"birthday"];
    }

	if(action==FAT_GET_UID)
	{
		id uid = [result objectForKey:@"id"];
		//UserProfile* userProfile = [UserProfile currentUser];
		//userProfile.fbUid = uid;
		//[userProfile storeFbLogin:facebook];

		//[[RootViewController sharedController] dismissModalAlert];
		action = FAT_NO_ACTION;
		
		if( [delegate respondsToSelector:@selector(facebookDidGetUid:successfully:)] )
		{
			[delegate facebookDidGetUid:uid successfully:YES];
		}
	}
	else if (action == FAT_GET_FRIENDS)
	{
		//[[RootViewController sharedController] dismissModalAlert];
		action = FAT_NO_ACTION;
		if( [delegate respondsToSelector:@selector(facebookDidGetFiends:successfully:)] )
		{
			[delegate facebookDidGetFiends:result successfully:YES];
		}
	}
	else if(action==FAT_PUBLISH_STREAM)
	{
		//[[RootViewController sharedController] dismissModalAlert];
		action = FAT_NO_ACTION;
		self.publishStreamParams = nil;
		if( [delegate respondsToSelector:@selector(facebookDidPublishSuccessfully:)] )  // Comment to remove crash from Share
		{
			[delegate facebookDidPublishSuccessfully:YES];
		}
	}
	else if(action==FAT_PUBLISH_STREAMS_FOR_USERS)
	{
		BOOL progress = [self publishNextUserStream];
		if(!progress)
		{
			//[[RootViewController sharedController] dismissModalAlert];
			action = FAT_NO_ACTION;
		}
	}else if(action==FAT_GET_PIC){
        if( [delegate respondsToSelector:@selector(facebookDidGetPic:successfully:)] )
		{
			[delegate facebookDidGetPic:result successfully:YES];
		}
    }
}

-(void) errorAlertDidClose
{
	if( [delegate respondsToSelector:@selector(facebookDidCloseErrorAlert)] )
	{
		[delegate facebookDidCloseErrorAlert];
	}
}


#pragma mark -
#pragma mark publishing invitations

-(void) publishInvitationsForUsers:(NSArray*)userIds userNames:(NSArray*)userNames joinToLeague:(NSString*)league
{
	//HFHAppDelegate* app = (HFHAppDelegate*)[[UIApplication sharedApplication] delegate];
	NSMutableDictionary* userStreams = [NSMutableDictionary dictionaryWithCapacity:[userIds count]+1];
	
	NSMutableDictionary* params = [NSMutableDictionary dictionary];
	// Message
	NSString* message = [NSString stringWithFormat:@"has invited %@ to join the Beautifo %@", [userNames componentsJoinedByString:@", "], league];
	//////nslog(@"FB wall post: %@", message);
	[params setObject:message forKey:@"message"];
	
	// Link params
	[params setObject:@"http://www.Beautifoapp.com" forKey:@"link"];
	[params setObject:@"Beautifo" forKey:@"name"];
	[params setObject:@"http://www.Beautifoapp.com" forKey:@"caption"];
	[params setObject:@"Beautifo on your iphone" forKey:@"description"];
	
	// Link params
	[params setObject:@"" forKey:@"picture"];
	
	// Actions links
//	NSString* links = [NSString stringWithFormat:@"{\"name\":\"App Store page\", \"link\": \"http://www.Beautifoapp.com\"}"];
//	[params setObject:links forKey:@"actions"];
	
	[userStreams setObject:params forKey:@"me"];
	
	
	for(NSString* userId in userIds)
	{
		NSMutableDictionary* params = [NSMutableDictionary dictionary];
		
		// Message
		NSString* message = [NSString stringWithFormat:@"has invited you to join the %@ in Beautifo", league];
	//	////nslog(@"FB wall post: %@", message);

	
		[params setObject:message forKey:@"message"];
		
		// Link params
		[params setObject:@"http://www.Beautifoapp.com" forKey:@"link"];
		[params setObject:@"Beautifo" forKey:@"name"];
		[params setObject:@"http://www.Beautifoapp.com" forKey:@"caption"];
		[params setObject:@"Beautifo on your iphone" forKey:@"description"];
		
		
		// Link params
		[params setObject:@"" forKey:@"picture"];
		
		// Actions links
//		NSString* links = [NSString stringWithFormat:@"{\"name\":\"App Store page\", \"link\": \"http://www.Beautifoapp.com\"}"];
//		[params setObject:links forKey:@"actions"];

		[userStreams setObject:params forKey:userId];
	}

	[self publishStreamsForUsers:userStreams];
}


@end
