//
//  CustomScrollView.m
//  Testing
//
//  Created by anoop gupta on 26/09/12.
//  Copyright (c) 2012 anoop.gupta@techvalens.com. All rights reserved.
//

#import "CustomScrollView.h"

BOOL checks;

@implementation CustomScrollView

//Synthesizing Property of currentImage
@synthesize currentImage;

//Synthesizing Property of currentIndex
@synthesize currentIndex;


-(void)imageSizesSmall:(NSUInteger)small Medium:(NSUInteger)medium LargeSize:(NSUInteger)large
{
    @try
    {
        //Medium Should be ImagewidthHeight
        imageWidthHeight    =   medium;
        
        //This Gives you actual distance between current scrollview height and Image Object.
        smallSize           =   (self.frame.size.height - small )/2;
        mediumSize          =   (self.frame.size.height - medium)/2;
        largeSize           =   (self.frame.size.height - large )/2;
    }
    @catch (NSException *exception)
    {
        //nslog(@"Exception Handler:%@",exception);
    }
    @finally
    {}
}

-(void)addImageViews:(NSArray*)arrayImage visibleImages:(NSUInteger) visibleImages
{
    @try
    {
        //Calculating single distannce between scroll and image. for Images it should be twice.
        int singleDistance  =   (self.frame.size.width-visibleImages*imageWidthHeight)/(visibleImages*2);
        
        //First image should start from the middle of scroll view.
        int x               =   (self.frame.size.width - imageWidthHeight)/2;
        int y               =   (self.frame.size.height- imageWidthHeight)/2;
        
        //Adding Images to scrollviews.
        for (UIImage *image in arrayImage)
        {
            UIImageView *imageView  =   [[UIImageView alloc] initWithImage:image];
            imageView.frame         =   CGRectMake(x, y, imageWidthHeight, imageWidthHeight);
            [self addSubview:imageView];
            
            //Updating content size. Last Image should also maintain the content.
            self.contentSize        =   CGSizeMake(x + (imageWidthHeight+self.frame.size.width)/2,
                                                   self.frame.size.height);
            
            //Updating next x for next image.
            x   =   x + imageWidthHeight + singleDistance*2;
        }
        
        //Setting Initial Contentoffset.
        self.contentOffset = CGPointMake((self.frame.size.width-imageWidthHeight)/2-singleDistance, 0);
    }
    @catch (NSException *exception)
    {
        //nslog(@"Exception Handler:%@",exception);
    }
    @finally
    {}
}

-(void)addImageViews    :(NSArray*)arrayImage    withLabels:(NSArray*)arrayOfStringLabel fontSize:(NSUInteger)fontSize labelAsHeader:(BOOL)isHeader visibleImages:(NSUInteger)  visibleImages;
{
    @try
    {
        //Calculating single distannce between scroll and image. for Images it should be twice.
        int singleDistance  =   (self.frame.size.width-visibleImages*imageWidthHeight)/(visibleImages*2);
        
        //First image should start from the middle of scroll view.
        int x               =   (self.frame.size.width - imageWidthHeight)/2;
        int y               =   (self.frame.size.height- imageWidthHeight)/2;
        
        //Adding Images to scrollviews.
        for (UIImage *image in arrayImage)
        {
            UIImageView *imageView  =   [[UIImageView alloc] initWithImage:image];
            imageView.frame         =   CGRectMake(x, y, imageWidthHeight, imageWidthHeight);
            [self addSubview:imageView];
            
            //Updating content size. Last Image should also maintain the content.
            self.contentSize        =   CGSizeMake(x + (imageWidthHeight+self.frame.size.width)/2,
                                                   self.frame.size.height);
            
            //Updating next x for next image.
            x   =   x + imageWidthHeight + singleDistance*2;
        }
        
        x       =   (self.frame.size.width - imageWidthHeight-(mediumSize-largeSize))/2;
        y       =   isHeader    ?   largeSize-fontSize-2    :
        self.frame.size.height-largeSize+2;
        
        for (NSString *string in arrayOfStringLabel)
        {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(x, y, imageWidthHeight+(mediumSize-largeSize), fontSize)];
            label.backgroundColor = [UIColor clearColor];
            label.text = string;
            label.textAlignment = UITextAlignmentCenter;
            [label setFont:[UIFont systemFontOfSize:fontSize]];
            
            [self addSubview:label];
            x   =   x + imageWidthHeight + singleDistance*2;
            
        }
        //Setting Initial Contentoffset.
        self.contentOffset = CGPointMake((self.frame.size.width-imageWidthHeight)/2-singleDistance, 0);
    }
    @catch (NSException *exception)
    {
        //nslog(@"Exception Handler:%@",exception);
    }
    @finally
    {}
}

-(void)addImageViews:(NSArray*)arrayImage DistanceBetweenImages:(NSUInteger) imageDistance
{
    @try
    {
        //Here singleDistance should be half of image distance.
        int singleDistance  =   imageDistance/2;
        
        //First image should start from the middle of scroll view.
        int x               =   (self.frame.size.width - imageWidthHeight)/2;
        int y               =   (self.frame.size.height- imageWidthHeight)/2;
        
        //Adding Images to scrollviews.
        for (UIImage *image in arrayImage)
        {
            UIImageView *imageView  =   [[UIImageView alloc] initWithImage:image];
            imageView.frame         =   CGRectMake(x, y, imageWidthHeight, imageWidthHeight);
            [self addSubview:imageView];
            
            //Updating content size. Last Image should also maintain the content.
            self.contentSize        =   CGSizeMake(x + (imageWidthHeight+self.frame.size.width)/2,
                                                   self.frame.size.height);
            //Updating next x for next image.
            x   =   x + imageWidthHeight + singleDistance*2;
        }
        
        //Setting Initial Contentoffset.
        self.contentOffset = CGPointMake((self.frame.size.width-imageWidthHeight)/2-singleDistance, 0);
    }
    @catch (NSException *exception)
    {
        //nslog(@"Exception Handler:%@",exception);
    }
    @finally
    {}
}

-(void)addImageViewss   :(NSArray*)arrayImage    withLabels:(NSArray*)arrayOfStringLabel fontSize:(NSUInteger)fontSize labelAsHeader:(BOOL)isHeader DistanceBetweenImages:(NSUInteger)  imageDistance
{
    @try
    {
        //Here singleDistance should be half of image distance.
        int singleDistance  =   imageDistance/2;
        
        //First image should start from the middle of scroll view.
        int x               =   (self.frame.size.width - imageWidthHeight)/2;
        int y               =   (self.frame.size.height- imageWidthHeight)/2;
        
        //Adding Images to scrollviews.
        for (UIImage *image in arrayImage)
        {
            UIImageView *imageView  =   [[UIImageView alloc] initWithImage:image];
            imageView.frame         =   CGRectMake(x, y, imageWidthHeight, imageWidthHeight);
            [self addSubview:imageView];
            
            //Updating content size. Last Image should also maintain the content.
            self.contentSize        =   CGSizeMake(x + (imageWidthHeight+self.frame.size.width)/2,
                                                   self.frame.size.height);
            //Updating next x for next image.
            x   =   x + imageWidthHeight + singleDistance*2;
        }
        
        x       =   (self.frame.size.width - imageWidthHeight-(mediumSize-largeSize))/2;
        y       =   isHeader    ?   largeSize-fontSize-3    :
        self.frame.size.height-largeSize+2;
        
        for (NSString *string in arrayOfStringLabel)
        {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(x, y-2, imageWidthHeight+(mediumSize-largeSize), fontSize)];
            label.backgroundColor = [UIColor clearColor];

            label.text = string;
            label.textAlignment = UITextAlignmentCenter;
            [label setFont:[UIFont boldSystemFontOfSize:fontSize]];
            
            [self addSubview:label];
            x   =   x + imageWidthHeight + singleDistance*2;
        }
        
        //Setting Initial Contentoffset.
        self.contentOffset = CGPointMake((self.frame.size.width-imageWidthHeight)/2-singleDistance, 0);
    }
    @catch (NSException *exception)
    {
        //nslog(@"Exception Handler:%@",exception);
    }
    @finally
    {}
}
-(void)doCustomInitialization
{
    @try
    {
        //Adding a gesture recognizer to recognize tap gesture.
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc]
                                    initWithTarget:self
                                    action:@selector(tapAction:)]];
        
        //Setting scrollviews to hidden.
        self.showsHorizontalScrollIndicator =   NO;
        self.showsVerticalScrollIndicator   =   NO;
        
        //Setting Delegate to self, so it will be able to call functions which is implemented here. It should not to be set in class where object has been created. If you set its delegate to self from class where you have created object, then it should not be able to call these functions which is defined here.
        self.delegate = self;
        
        //If more than one images, then distance between center of both images will be scrolling distance.
        if ([self.subviews count] > 1)
        {
            UIImageView *img1   =   [self.subviews objectAtIndex:0];
            UIImageView *img2   =   [self.subviews objectAtIndex:1];
            
            scrollingDistance   =   abs(img2.center.x-img1.center.x);
        }
        //If only one image or no image, than scrolling distance between image is 0.
        else
            scrollingDistance   =   0;
        
        //Finding which image is in the Center.
        for (UIImageView *imageView in self.subviews)
            if (imageView.center.x  >   self.contentOffset.x    +
                self.frame.size.width/2 -
                scrollingDistance/2 &&
                imageView.center.x  <   self.contentOffset.x    +
                self.frame.size.width/2 +
                scrollingDistance/2)
            {
                //If more than one object is added to scroll view, then object should be kind of UIImageView class.
                if ([imageView isKindOfClass:[UIImageView class]])
                {
                    //Center image size should be large size.
                    int adjustment  =   largeSize  -    imageView.frame.origin.y;
                    imageView.frame =   CGRectMake(imageView.frame.origin.x +adjustment,
                                                   imageView.frame.origin.y   +adjustment,
                                                   imageView.frame.size.width -adjustment*2,
                                                   imageView.frame.size.height-adjustment*2);
                    
                    //Scrolling adjustment which is to be maintain. which is firstAdjustment.
                    firstAdjustment =   (imageView.center.x-self.contentOffset.x)-
                    self.frame.size.width/2;
                    
                    [self setContentOffset:CGPointMake(self.contentOffset.x+
                                                       firstAdjustment,
                                                       self.contentOffset.y)
                                  animated:NO];
                    
                    //Now finding Actual Adjustment which is to be maintained in whole class.
                    firstAdjustment =   (int)self.contentOffset.x%(int)scrollingDistance;
                    
                    //                [self bringSubviewToFront:imageView];
                    
                    //Setting imageview as currentImage and setting its index.
                    currentImage    =   imageView;
                    currentIndex    =   [self.subviews indexOfObject:imageView];
                }
                //If Current image is found, then there is no need of for loop.
                break;
            }
    }
    @catch (NSException *exception)
    {
        //nslog(@"Exception Handler:%@",exception);
    }
    @finally
    {}
}

#pragma Mark - Gesture Delegate function
- (void)tapAction:(UITapGestureRecognizer*)sender
{
    //nslog(@"TapAction");
    @try
    {
        //Calculating tap Point (x, y).
        CGPoint tapPoint    =   [sender locationInView:self];
        
        //Finding which image is Tapped.
        for (UIImageView *imageView in self.subviews)
            if (tapPoint.x  >=  imageView.center.x  -   scrollingDistance/2 &&
                tapPoint.x  <=  imageView.center.x  +   scrollingDistance/2)
            {
                //Image should be kind of UIImageView and should not be current Image
                if ([imageView isKindOfClass:[UIImageView class]] && imageView != currentImage)
                {
                    //If tapped image is in left.
                    if(imageView.center.x-self.contentOffset.x<self.frame.size.width/2)
                    {
                        //Gives number of image difference between tapped image and current Image.
                        int i   =   -(imageView.center.x-currentImage.center.x)/scrollingDistance;
                        //Updating content offset.
                        int adjustment  =   (int)(self.contentOffset.x-firstAdjustment) %
                        (int)scrollingDistance*i;
                        if(adjustment   ==  0)
                            adjustment  =   scrollingDistance*i +   firstAdjustment;
                        [self setContentOffset:CGPointMake(self.contentOffset.x-adjustment,
                                                           self.contentOffset.y)
                                      animated:YES];//Changesssss
                    }
                    //If tapped image is in right.
                    else if(imageView.center.x-self.contentOffset.x>self.frame.size.width/2)
                    {
                        //Gives number of image difference between tapped image and current Image.
                        int i   =   (imageView.center.x-currentImage.center.x)/scrollingDistance;
                        
                        //Updating content offset.
                        //                    int adjustment  =   scrollingDistance*i -
                        //                                        (int)self.contentOffset.x  -
                        //                                        (int)firstAdjustment%(int)(scrollingDistance*i);
                        
                        int adjustment  =   scrollingDistance*i -
                        (int)(self.contentOffset.x  -
                              firstAdjustment)%(int)(scrollingDistance*i);
                        [self setContentOffset:CGPointMake(self.contentOffset.x+adjustment,
                                                           self.contentOffset.y)
                                      animated:YES];//Changessss
                    }
                    //If Tapped image is found, then there is no need of for loop.
                    break;
                }
            }
    }
    @catch (NSException *exception)
    {
        //nslog(@"Exception Handler:%@",exception);
    }
    @finally
    {}

}

#pragma Mark - Scroll View Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scroll
{
    //nslog(@"scrollViewDidScroll");
    @try
    {
        //Finding which image is in center.
        for (UIImageView *imageView in scroll.subviews)
            if (imageView.center.x  >   scroll.contentOffset.x  +
                self.frame.size.width/2 -
                scrollingDistance/2     &&
                imageView.center.x  <   scroll.contentOffset.x  +
                self.frame.size.width/2 +
                scrollingDistance/2)
            {
                //Image should be kind of UIImageView and should not be current Image
                if ([imageView isKindOfClass:[UIImageView class]] && currentImage != imageView)
                {
                    //It is new center image. Setting image as large.
                    int adjustment  =   largeSize   -   imageView.frame.origin.y;
                    imageView.frame =   CGRectMake(imageView.frame.origin.x +adjustment,
                                                   imageView.frame.origin.y   +adjustment,
                                                   imageView.frame.size.width -adjustment*2,
                                                   imageView.frame.size.height-adjustment*2);
                    
                    //Center image is no more is in center. it should be medium size.
                    adjustment  =    mediumSize-currentImage.frame.origin.y;
                    currentImage.frame  =   CGRectMake(currentImage.frame.origin.x  +adjustment,
                                                       currentImage.frame.origin.y     +adjustment,
                                                       currentImage.frame.size.width   -adjustment*2,
                                                       currentImage.frame.size.height  -adjustment*2);
                    //                [self bringSubviewToFront:imageView];
                    
                    //Setting imageview as currentImage and setting its index.
                    currentImage    =   imageView;
                    currentIndex    =   [scroll.subviews indexOfObject:imageView];
                }
                //If Tapped image is found, then there is no need of for loop.
                break;
            }
            else if ([imageView isKindOfClass:[UIImageView class]] && currentImage != imageView)
            {
                int adjustment  =   mediumSize   -   imageView.frame.origin.y;
                imageView.frame =   CGRectMake(imageView.frame.origin.x +adjustment,
                                               imageView.frame.origin.y   +adjustment,
                                               imageView.frame.size.width -adjustment*2,
                                               imageView.frame.size.height-adjustment*2);
            }
    }
    @catch (NSException *exception)
    {
        //nslog(@"Exception Handler:%@",exception);
    }
    @finally
    {}
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scroll
{
    //nslog(@"scrollViewDidEndDecelerating");
    @try
    {
        //Calculating distance between center of scrollview and current image center. and adjusting contentOffset with this distance. It should be animated.
        if ((int)(self.contentOffset.x-firstAdjustment)%(int)scrollingDistance < scrollingDistance/2 )
            [scroll setContentOffset:CGPointMake(
                                                 scroll.contentOffset.x - (int)(self.contentOffset.x-firstAdjustment) % (int)scrollingDistance,
                                                 scroll.contentOffset.y) animated:NO];////Changes
        else
            [scroll setContentOffset:CGPointMake(
                                                 scroll.contentOffset.x + (scrollingDistance - (int)(self.contentOffset.x-firstAdjustment) % (int)scrollingDistance),
                                                 scroll.contentOffset.y) animated:NO];//Changess        
    }
    @catch (NSException *exception)
    {
        //nslog(@"Exception Handler:%@",exception);
    }
    @finally
    {}
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scroll willDecelerate:(BOOL)decelerate
{
//    //nslog(@"scrollViewDidEndDragging");
//    @try
//    {
//        //Calculating distance between center of scrollview and current image center. and adjusting contentOffset with this distance. If you set it Animated, it will create a problem for you.
//        if (![scroll isDecelerating])
//        {
//            if ((int)scroll.contentOffset.x%(int)scrollingDistance < scrollingDistance/2)
//            {    [scroll setContentOffset:CGPointMake(
//                                                      scroll.contentOffset.x - (int)(self.contentOffset.x-firstAdjustment) % (int)scrollingDistance,
//                                                      scroll.contentOffset.y) animated:NO];
//            }
//            else
//            {
//                [scroll setContentOffset:CGPointMake(
//                                                     scroll.contentOffset.x + (scrollingDistance - (int)(self.contentOffset.x-firstAdjustment) % (int)scrollingDistance),
//                                                     scroll.contentOffset.y) animated:NO];
//            }
//        }
//    }
//    @catch (NSException *exception)
//    {
//        //nslog(@"Exception Handler:%@",exception);
//    }
//    @finally
//    {}
    checks=decelerate;
    [self performSelector:@selector(scrollmethod:) withObject:scroll afterDelay:0.1];
}


-(void)scrollmethod:(UIScrollView *)scroll
{
    //nslog(@"scrollViewDidEndDragging");
    @try
    {
        //Calculating distance between center of scrollview and current image center. and adjusting contentOffset with this distance. If you set it Animated, it will create a problem for you.
        if (![scroll isDecelerating])
        {
            if ((int)scroll.contentOffset.x%(int)scrollingDistance < scrollingDistance/2)
            {    [scroll setContentOffset:CGPointMake(
                                                      scroll.contentOffset.x - (int)(self.contentOffset.x-firstAdjustment) % (int)scrollingDistance,
                                                      scroll.contentOffset.y) animated:YES];
            }
            else
            {
                [scroll setContentOffset:CGPointMake(
                                                     scroll.contentOffset.x + (scrollingDistance - (int)(self.contentOffset.x-firstAdjustment) % (int)scrollingDistance),
                                                     scroll.contentOffset.y) animated:YES];
            }
        }
    }
    @catch (NSException *exception)
    {
        //nslog(@"Exception Handler:%@",exception);
    }
    @finally
    {}


}
#pragma Mark - Touch Delegate
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //nslog(@"touchesBegan");
    @try
    {
        //Calculating tap Point (x, y).
        CGPoint tapPoint =[[[event allTouches] anyObject] locationInView:self];
        
        //    //Finding that tap point is in the bounds of scrollview or not.
        //    if (tapPoint.x  >=    0   &&  tapPoint.x    <=    self.contentSize.width &&
        //        tapPoint.y  >=    0   &&  tapPoint.y    <=    self.contentSize.height
        //        )
        //Finding which image is touched.
        for (UIImageView *imageView in self.subviews)
            if (tapPoint.x  >=  imageView.center.x-scrollingDistance/2 &&
                tapPoint.y  >=  imageView.center.y-scrollingDistance/2 &&
                tapPoint.x  <=  imageView.center.x+scrollingDistance/2 &&
                tapPoint.y  <=  imageView.center.y+scrollingDistance/2)
            {
                //Image should be kind of UIImageView and should not be current Image.
                if ([imageView isKindOfClass:[UIImageView class]] && imageView != currentImage)
                {
                    //Setting touched image to small size.
                    int adjustment  =   smallSize   -   imageView.frame.origin.y;
                    imageView.frame =   CGRectMake(imageView.frame.origin.x +adjustment,
                                                   imageView.frame.origin.y   +adjustment,
                                                   imageView.frame.size.width -adjustment*2,
                                                   imageView.frame.size.height-adjustment*2);
                }
                //If touched image is found, then there is no need of for loop.
                break;
            }
    }
    @catch (NSException *exception)
    {
        //nslog(@"Exception Handler:%@",exception);
    }
    @finally
    {}
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{    
    //nslog(@"touchesMoved");
    @try
    {
        for (UIImageView *imageView in self.subviews)
            if (imageView.center.x  >   self.contentOffset.x    +
                self.frame.size.width/2 -
                scrollingDistance/2     &&
                imageView.center.x  <   self.contentOffset.x    +
                self.frame.size.width/2 +
                scrollingDistance/2)
            {
                //Image should be kind of UIImageView and should not be current Image
                if ([imageView isKindOfClass:[UIImageView class]] && currentImage != imageView)
                {
                    //It is new center image. Setting image as large.
                    int adjustment  =   largeSize   -   imageView.frame.origin.y;
                    imageView.frame =   CGRectMake(imageView.frame.origin.x +adjustment,
                                                   imageView.frame.origin.y   +adjustment,
                                                   imageView.frame.size.width -adjustment*2,
                                                   imageView.frame.size.height-adjustment*2);
                    
                    //Center image is no more is in center. it should be medium size.
                    adjustment  =    mediumSize-currentImage.frame.origin.y;
                    currentImage.frame  =   CGRectMake(currentImage.frame.origin.x  +adjustment,
                                                       currentImage.frame.origin.y     +adjustment,
                                                       currentImage.frame.size.width   -adjustment*2,
                                                       currentImage.frame.size.height  -adjustment*2);
                    //                [self bringSubviewToFront:imageView];
                    
                    //Setting imageview as currentImage and setting its index.
                    currentImage    =   imageView;
                    currentIndex    =   [self.subviews indexOfObject:imageView];
                }
                //If Tapped image is found, then there is no need of for loop.
                //            break;
            }
            else if ([imageView isKindOfClass:[UIImageView class]] && currentImage != imageView)
            {
                int adjustment  =   mediumSize   -   imageView.frame.origin.y;
                imageView.frame =   CGRectMake(imageView.frame.origin.x +adjustment,
                                               imageView.frame.origin.y   +adjustment,
                                               imageView.frame.size.width -adjustment*2,
                                               imageView.frame.size.height-adjustment*2);
            }
    }
    @catch (NSException *exception)
    {
        //nslog(@"Exception Handler:%@",exception);
    }
    @finally
    {}
}

- (void)touchesEnded: (NSSet *) touches withEvent: (UIEvent *) event
{
    //nslog(@"touchesEnded");
    @try
    {
        //Calculating tap Point (x, y).
        CGPoint tapPoint    =   [[[event allTouches] anyObject] locationInView:self];
        
        //    //Finding that tap point is in the bounds of scrollview or not.
        //    if (tapPoint.x>=    0   &&  tapPoint.x  <=  self.contentSize.width &&
        //        tapPoint.y>=    0   &&  tapPoint.y  <=  self.contentSize.height
        //        )
        //        //Finding in which image is touch has Ended.
        for (UIImageView *imageView in self.subviews)
            if (tapPoint.x  >=  imageView.center.x-scrollingDistance/2 &&
                tapPoint.y  >=  imageView.center.y-scrollingDistance/2 &&
                tapPoint.x  <=  imageView.center.x+scrollingDistance/2 &&
                tapPoint.y  <=  imageView.center.y+scrollingDistance/2)
            {
                //Image should be kind of UIImageView and should not be current Image.
                if ([imageView isKindOfClass:[UIImageView class]] && imageView != currentImage)
                {
                    //Center image is no more is in center. it should be medium size.
                    int adjustment  =   mediumSize  -   imageView.frame.origin.y;
                    currentImage.frame  =   CGRectMake(currentImage.frame.origin.x+adjustment,
                                                       currentImage.frame.origin.y +adjustment,
                                                       currentImage.frame.size.width-adjustment*2,
                                                       currentImage.frame.size.height-adjustment*2);
                    
                    //It is new center image. Setting image as large.
                    adjustment  =   largeSize   -   imageView.frame.origin.y;
                    imageView.frame =   CGRectMake(imageView.frame.origin.x +adjustment,
                                                   imageView.frame.origin.y   +adjustment,
                                                   imageView.frame.size.width -adjustment*2,
                                                   imageView.frame.size.height-adjustment*2);
                    
                    //If tapped image is in left.
                    if(imageView.frame.origin.x-self.contentOffset.x<self.frame.size.width/2)
                        adjustment  =   -(scrollingDistance);
                    //If tapped image is in right.
                    else if(imageView.frame.origin.x-self.contentOffset.x>self.frame.size.width/2)
                        adjustment  =   scrollingDistance;
                    
                    [self setContentOffset:CGPointMake(self.contentOffset.x +adjustment,
                                                       self.contentOffset.y) animated:NO];//Changesss
                    //                    [self bringSubviewToFront:imageView];
                    
                    //Setting imageview as currentImage and setting its index.
                    currentImage    =   imageView;
                    currentIndex    =   [self.subviews indexOfObject:imageView];
                }
                //If touched image is found, then there is no need of for loop.
                //                break;
            }
            else if ([imageView isKindOfClass:[UIImageView class]] && currentImage != imageView)
            {
                int adjustment  =   mediumSize   -   imageView.frame.origin.y;
                imageView.frame =   CGRectMake(imageView.frame.origin.x +adjustment,
                                               imageView.frame.origin.y   +adjustment,
                                               imageView.frame.size.width -adjustment*2,
                                               imageView.frame.size.height-adjustment*2);
            }
    }
    @catch (NSException *exception)
    {
        //nslog(@"Exception Handler:%@",exception);
    }
    @finally
    {}
}
@end
