
//  Purchase.m
//  Created by techvalens on 01/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.


#import "InAppPurchaseManager.h"
#define kInAppPurchaseManagerProductsFetchedNotification @"kInAppPurchaseManagerProductsFetchedNotification"
#define kInAppPurchaseManagerProductsNotFetchedNotification @"kInAppPurchaseManagerProductsNotFetchedNotification"

#define kInAppPurchaseManagerTransactionFailedNotification @"kInAppPurchaseManagerTransactionFailedNotification"

#define kInAppPurchaseManagerTransactionCancelNotification @"kInAppPurchaseManagerTransactionCancelNotification"

#define kInAppPurchaseManagerTransactionSucceededNotification @"kInAppPurchaseManagerTransactionSucceededNotification"

#define kInAppPurchaseManagerProductsCanFetchedNotification @"kInAppPurchaseManagerProductsCanFetchedNotification"

#define kInAppPurchaseManagerRestoreSucceededNotification @"kInAppPurchaseManagerRestoreSucceededNotification"

#define FATPACK @"FatPackD1000"
#define EXPANSIONPACK @"ExpansionD100"
#define NOADPACK @"NoAdPackD100"
#define ALLPACK1 @"PurchaseAllPacksD_100"
#define ALLPACK2 @"PurchaseAll2T"

extern NSString *strCheckProduct;

@implementation InAppPurchaseManager
@synthesize ProductIdentifiers;

#pragma mark - View lifecycle

static InAppPurchaseManager* sharedInstance = nil;

+(InAppPurchaseManager*) sharedController
{
	if(sharedInstance==nil)
	{
		sharedInstance = [[InAppPurchaseManager alloc] init];
	}
	return sharedInstance;
}


- (void)initWithProductIdentifier:(NSString *)productIdentifier
{
	ProductIdentifiers=[[NSString alloc] initWithString:productIdentifier];
		//if (self=[super init]){
			//[productIdentifier copy] ;
		if([SKPaymentQueue  canMakePayments] ){
			////nslog(@"parantal controls are disabled.");
			SKProductsRequest *productrequest=[[SKProductsRequest alloc] initWithProductIdentifiers:[NSSet setWithObject:ProductIdentifiers]];
            
			[productrequest setDelegate:self];
			[productrequest start];
	//	}
	}
	//return self;
}

-(void)callForPayment:(NSString *)ProductIdentifier {
    SKPayment *payment=[SKPayment paymentWithProductIdentifier:ProductIdentifiers];
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    [[SKPaymentQueue defaultQueue] addPayment:payment];
}


- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response
{
   
//    NSArray *invalidIdentifiers = [response invalidProductIdentifiers];
    
    //nslog(@"invalidIdentifiers=%@",invalidIdentifiers);
    
    //nslog(@"response=%@",response.products);
    //SKProduct *validproduct=nil;  Unused
    int count=[response.products count];
    if (count>0){
		[self performSelector:@selector(callForPayment:) withObject:nil afterDelay:1.0];
        }else {
        UIAlertView* alert=[[UIAlertView alloc]initWithTitle:@"Oops!" message:@"No product Available." delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];        
        
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kInAppPurchaseManagerProductsNotFetchedNotification object:self userInfo:nil];
        
               [alert show];

        ////nslog(@"No porduct Available"); 
        
    }
}

- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions
{
    //nslog(@" paymentQueue value after transaction %@",transactions);
    for (SKPaymentTransaction *transaction in transactions)
    {
        switch (transaction.transactionState)
        {
            case SKPaymentTransactionStatePurchased:
                [self completeTransaction:transaction];
                break;
            case SKPaymentTransactionStateFailed:
                [self failedTransaction:transaction];
                break;
            case SKPaymentTransactionStateRestored:
                [self restoreTransaction:transaction];
                break;
            default:
                break;
        }
    }
} 

- (void)recordTransaction:(SKPaymentTransaction *)transaction
{
   //nslog(@" recordTransaction value after transaction %@",transaction);
    if ([transaction.payment.productIdentifier isEqualToString:@""])
    {
        // save the transaction receipt to disk
        [[NSUserDefaults standardUserDefaults] setValue:transaction.transactionReceipt forKey:@"proUpgradeTransactionReceipt" ];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

// enable pro features
- (void)provideContent:(NSString *)productId
{
//    @"FatPackD1000"
//    @"ExpansionD100"
//    NoAdPackD100
//    @"PurchaseAllPacksD_100"
//    @"PurchaseAll2T"
    NSLog(@"provideContent value after transaction %@",productId);
    if ([productId isEqualToString:@""])
    {
        // enable the pro features
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"isProUpgradePurchased" ];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else if ([productId isEqualToString:EXPANSIONPACK]) {
        [[NSUserDefaults standardUserDefaults]setObject:@"ExpPackPurchase" forKey:@"key_ExpansionPack"];
        strCheckProduct=@"ExpPackPurchase";
    }
    else if ([productId isEqualToString:FATPACK]) {
        [[NSUserDefaults standardUserDefaults]setObject:@"FatPackPurchase" forKey:@"key_FatPack"];
        strCheckProduct=@"FatPackPurchase";
    }
    else if ([productId isEqualToString:NOADPACK]) {
        [[NSUserDefaults standardUserDefaults]setObject:@"NoAdPackPurchase" forKey:@"key_HiddenAdPack"];
        strCheckProduct=@"NoAdPackPurchase";
    }
    else if ([productId isEqualToString:ALLPACK1]) {
        [[NSUserDefaults standardUserDefaults]setObject:@"AllPackPurchase" forKey:@"key_PurchaseAll"];
        strCheckProduct=@"AllPackPurchase";
    }
    else if ([productId isEqualToString:ALLPACK2]) {
        [[NSUserDefaults standardUserDefaults]setObject:@"AllPackPurchase" forKey:@"key_PurchaseAll"];
        strCheckProduct=@"AllPackPurchase";
    }
} 


// removes the transaction from the queue and posts a notification with the transaction result
- (void)finishTransaction:(SKPaymentTransaction *)transaction wasSuccessful:(BOOL)wasSuccessful
{
    //remove the transaction from the payment queue.
    [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
    //nslog(@" finishTransaction value after transaction %@",transaction);
    NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:transaction,@"transaction" , nil];
    if (wasSuccessful)
    {
        // send out a notification that we’ve finished the transaction
        [[NSNotificationCenter defaultCenter] postNotificationName:kInAppPurchaseManagerTransactionSucceededNotification object:self userInfo:userInfo];
    }
    else
    {
        // send out a notification for the failed transaction
        [[NSNotificationCenter defaultCenter] postNotificationName:kInAppPurchaseManagerTransactionFailedNotification object:self userInfo:userInfo];
    }
} 


// called when the transaction was successful
- (void)completeTransaction:(SKPaymentTransaction *)transaction
{
    //nslog(@" completeTransaction value after transaction %@",transaction.transactionReceipt);
    [self recordTransaction:transaction];
    [self provideContent:transaction.payment.productIdentifier];
    [self finishTransaction:transaction wasSuccessful:YES];
} 

//Change
- (void)restorePrevious{
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
}

// called when a transaction has been restored and and successfully completed
- (void)restoreTransaction:(SKPaymentTransaction *)transaction
{
    //////nslog(@" value after transaction %@",transaction);

	[self recordTransaction:transaction.originalTransaction];
    [self provideContent:transaction.originalTransaction.payment.productIdentifier];
    [self finishTransaction:transaction wasSuccessful:YES];
} 

// Sent when an error is encountered while adding transactions from the user's purchase history back to the queue.
- (void)paymentQueue:(SKPaymentQueue *)queue restoreCompletedTransactionsFailedWithError:(NSError *)error
{
    NSLog(@"restoreCompletedTransactionsFailedWithError");
    NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:queue,@"queue" , nil];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kInAppPurchaseManagerRestoreSucceededNotification object:self userInfo:userInfo];
}


// Sent when all transactions from the user's purchase history have successfully been added back to the queue.
- (void)paymentQueueRestoreCompletedTransactionsFinished:(SKPaymentQueue *)queue
{
    NSLog(@"paymentQueueRestoreCompletedTransactionsFinished");
    
    NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:queue,@"queue" , nil];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kInAppPurchaseManagerRestoreSucceededNotification object:self userInfo:userInfo];
    
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"" message:@"Restored Successfully" delegate:self  cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    [alert show];
    
}


// called when a transaction has failed
- (void)failedTransaction:(SKPaymentTransaction *)transaction
{
    NSDictionary *userInfo = [NSDictionary dictionaryWithObjectsAndKeys:transaction,@"transaction" , nil];
    //////nslog(@" value after transaction %@",transaction);
    if (transaction.error.code != SKErrorPaymentCancelled)
    {
        // error!
        [self finishTransaction:transaction wasSuccessful:NO];
    }
    else
    {
        // this is fine, the user just cancelled.
        [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
        [[NSNotificationCenter defaultCenter] postNotificationName:kInAppPurchaseManagerTransactionCancelNotification object:self userInfo:userInfo];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kInAppPurchaseManagerProductsNotFetchedNotification object:self userInfo:userInfo];
        
    }
} 


@end
