//
//  HUDView.h
//  HUDView
//

#import <UIKit/UIKit.h>

@interface HudView : UIView
{
	UILabel *loadingLabel;
	HudView *loadingView;
}
@property (nonatomic,strong) UILabel *loadingLabel;
@property (nonatomic,strong)  HudView *loadingView;
-(id)loadingViewInView:(UIView *)aSuperview text:(NSString*)hudText;
-(void)removeView;
-(void)setUserInteractionEnabledForSuperview:(UIView *)aSuperview;
-(void)setUserInteractionEnabledNoForSuperview:(UIView *)aSuperview;
@end
