//
//  LTCircleLayer.h
//  LTCircleView
//
//  Created by Lucas Twisk on 20-12-15.
//  Copyright © 2015 Lucas Twisk. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LTCircleItem;

@interface LTCircleLayer : CALayer

@property (nonatomic) CGFloat startAngle;
@property (nonatomic) CGFloat endAngle;
@property (nonatomic) CGFloat circleLineWidth;
@property (nonatomic) CGFloat animationDuration;

@property (nonatomic, strong) UIColor *fillColor;

@end
