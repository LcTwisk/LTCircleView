//
//  LTCircleLayer.m
//  LTCircleView
//
//  Created by Lucas Twisk on 20-12-15.
//  Copyright © 2015 Lucas Twisk. All rights reserved.
//

#import "LTCircleLayer.h"

@implementation LTCircleLayer

@dynamic startAngle, endAngle;

- (id)init
{
	self = [super init];
	
	if (self)
	{
		self.contentsScale = [[UIScreen mainScreen] scale];
	}
	
	return self;
}

- (id)initWithLayer:(id)layer
{
	if  (self = [super initWithLayer:layer])
	{
		if ([layer isKindOfClass:LTCircleLayer.class])
		{
			LTCircleLayer *other = (LTCircleLayer *)layer;
			self.startAngle		= other.startAngle;
			self.endAngle		= other.endAngle;
			self.fillColor		= other.fillColor;
			self.circleLineWidth	= other.circleLineWidth;
		}
	}
	return self;
}


- (id<CAAction>)actionForKey:(NSString *)event
{
	if ([event isEqualToString:@"startAngle"] || [event isEqualToString:@"endAngle"])
	{
		return [self makeAnimationForKey:event];
	}
	return [super actionForKey:event];
}

- (CABasicAnimation *)makeAnimationForKey:(NSString *)key
{
	CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:key];
	animation.fromValue = [[self presentationLayer] valueForKey:key];
	animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	animation.duration = self.animationDuration;
	
	return animation;
}

+ (BOOL)needsDisplayForKey:(NSString *)key
{
	if ([key isEqualToString:@"startAngle"] || [key isEqualToString:@"endAngle"])
	{
		return YES;
	}
	return [super needsDisplayForKey:key];
}

- (void)drawInContext:(CGContextRef)ctx
{
	CGFloat radius = self.bounds.size.width / 2.0;
	CGPoint center = CGPointMake(self.bounds.size.width / 2.0, self.bounds.size.height / 2.0);
	
	CGFloat outerRadius	= MIN(center.x, center.y);
	CGFloat innerRadius	= outerRadius - ((self.circleLineWidth > radius) ? radius : self.circleLineWidth);
	
	CGContextBeginPath(ctx);
	
	CGPoint p1 = CGPointMake(center.x + innerRadius * cosf(self.startAngle), center.y + innerRadius * sinf(self.startAngle));
	CGPoint p2 = CGPointMake(center.x + outerRadius * cosf(self.startAngle), center.y + outerRadius * sinf(self.startAngle));
	
	CGContextMoveToPoint(ctx, p1.x, p1.y);
	CGContextAddLineToPoint(ctx, p2.x, p2.y);
	int clockwise = self.startAngle > self.endAngle;
	
	CGContextAddArc(ctx, center.x, center.y, outerRadius, self.startAngle, self.endAngle, clockwise);
	CGPoint p3 = CGPointMake(center.x + innerRadius * cosf(self.endAngle), center.y + innerRadius * sinf(self.endAngle));
	
	CGContextAddLineToPoint(ctx, p3.x, p3.y);
	CGContextAddArc(ctx, center.x, center.y, innerRadius, self.endAngle, self.startAngle, !clockwise);
	
	CGContextClosePath(ctx);
	
	// Color it
	CGContextSetFillColorWithColor(ctx, self.fillColor.CGColor);
	CGContextSetLineWidth(ctx, 0.0);
	
	CGContextDrawPath(ctx, kCGPathFillStroke);
}


@end
