//
//  LTCircleView.h
//  LTCircleView
//
//  Created by Lucas Twisk on 20-12-15.
//  Copyright © 2015 Lucas Twisk. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LTCircleView;

@protocol LTCircleViewDataSource <NSObject>

- (NSInteger)numberOfSegmentsInCircleView:(LTCircleView *)circleView;
- (CGFloat)circleView:(LTCircleView *)circleView valueForSegment:(NSInteger)segment;
- (UIColor *)circleView:(LTCircleView *)circleView colorForSegment:(NSInteger)index;

@end

@interface LTCircleView : UIView

@property (weak, nonatomic) id<LTCircleViewDataSource> delegate;

/* Width of the circle, default value is 32.0 */
@property (nonatomic) CGFloat circleWidth;

/* Duration of the animation, default value is 0.5  */
@property (nonatomic) CGFloat animationDuration;

- (void)reloadData;

@end
