//
//  UIView+RoundCorners.h
//  SearchAcronym
//
//  Created by Chaitanya Kumar on 3/5/16.
//  Copyright © 2016 Chaitanya Kumar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface UIView (RoundCorners)

-(void)addRoundedCorners:(UIRectCorner) corners withRadii:(CGSize) radii;
-(CALayer*)maskForRoundedCorners:(UIRectCorner) corners withRadii:(CGSize) radii;

@end
