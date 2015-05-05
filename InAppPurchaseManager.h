//
//  Purchase.h
//  Created by techvalens on 01/02/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.


#import <UIKit/UIKit.h>
#import <StoreKit/StoreKit.h>
@interface InAppPurchaseManager : NSObject<SKProductsRequestDelegate,SKPaymentTransactionObserver>{
	NSString *ProductIdentifiers;
}

@property(nonatomic,strong) NSString *ProductIdentifiers;

+(InAppPurchaseManager*) sharedController;


- (void)initWithProductIdentifier:(NSString *)productIdentifier;

-(void)callForPayment:(NSString *)ProductIdentifier;

- (void)completeTransaction:(SKPaymentTransaction *)transaction;
- (void)restoreTransaction:(SKPaymentTransaction *)transaction;
- (void)failedTransaction:(SKPaymentTransaction *)transaction;
- (void)restorePrevious;//Change
@end
