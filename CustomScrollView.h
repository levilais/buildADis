//
//  CustomScrollView.h
//  Testing
//
//  Created by anoop gupta on 26/09/12.
//  Copyright (c) 2012 anoop.gupta@techvalens.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomScrollView : UIScrollView<UIScrollViewDelegate>
{
//Gives Current Index of Selected Image. Sometime may not work, if you add other than UIImageview type of objects in ScrollView.
@protected  NSUInteger currentIndex;

//Gives Current Image reference
@protected  UIImageView *currentImage;

//Only for Class Use. Not for public access.
@private    NSUInteger  largeSize, mediumSize, smallSize, imageWidthHeight;
@private    float scrollingDistance, firstAdjustment, preX;
}
//Setting Property of currentImage
@property (strong, nonatomic) UIImageView *currentImage;

//Setting Property of currentIndex
@property (assign, nonatomic) NSUInteger currentIndex;

//Function for taking Image Sizes for SmallView, MediumView and Large View.
-(void)imageSizesSmall  :(NSUInteger)small  Medium:(NSUInteger)medium   LargeSize:(NSUInteger)large;

//Function for taking array to add as a subviews with number of images to show on scroll.
-(void)addImageViews    :(NSArray*)arrayImage    visibleImages:(NSUInteger)  visibleImages;

//Function for taking array to add as a subviews with label as header or footer with number of images to show on scroll.
-(void)addImageViews    :(NSArray*)arrayImage    withLabels:(NSArray*)arrayOfStringLabel fontSize:(NSUInteger)fontSize labelAsHeader:(BOOL)isHeader visibleImages:(NSUInteger)  visibleImages;


//Function for taking array to add as a subviews with distance between images to maintain.
-(void)addImageViews    :(NSArray*)arrayImage    DistanceBetweenImages:(NSUInteger)  imageDistance;

//Function for taking array to add as a subviews with label as header or footer with image distance.
-(void)addImageViewss    :(NSArray*)arrayImage    withLabels:(NSArray*)arrayOfStringLabel fontSize:(NSUInteger)fontSize labelAsHeader:(BOOL)isHeader DistanceBetweenImages:(NSUInteger)  imageDistance;
//Must call to enable Custom Scrolling in scroll view.
-(void)doCustomInitialization;
-(void)scrollmethod:(UIScrollView *)scroll;
@end
