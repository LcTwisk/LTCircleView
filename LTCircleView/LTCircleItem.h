//
//  LTCircleItem.h
//  LTCircleView
//
//  Created by Lucas Twisk on 20-12-15.
//  Copyright © 2015 Lucas Twisk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "LTCircleLayer.h"

@interface LTCircleItem : NSObject

@property (assign, nonatomic) CGFloat normalizedValue;
@property (strong, nonatomic) UIColor *color;
@property (strong, nonatomic) LTCircleLayer *layer;

@end
