//
//  ScrollViewButton.h
//  BuildADis
//
//  Created by USER USER on 9/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TapScrollView.h"

@interface ScrollViewButton : UIViewController<UIScrollViewDelegate>
{
    UIScrollView *sv;
    TapScrollView *scrolling;
    UIButton *btnImage;
    CGPoint startPoint;
    BOOL isTouchSV;
    int suoyin;

}
@property(nonatomic,strong)UIButton *btnImage;
@property(nonatomic,strong)IBOutlet UIScrollView *sv;
-(void)touch:(id)sender;
@end
