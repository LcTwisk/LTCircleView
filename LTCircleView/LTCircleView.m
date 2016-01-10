//
//  LTCircleView.m
//  LTCircleView
//
//  Created by Lucas Twisk on 20-12-15.
//  Copyright © 2015 Lucas Twisk. All rights reserved.
//

#import "LTCircleView.h"
#import "LTCircleItem.h"

@interface LTCircleView ()

@property (strong, nonatomic) NSArray *circleItems;

@end

@implementation LTCircleView

#pragma mark - Initializers

- (id)init
{
	self = [super init];
	if (self)
	{
		[self setDefaultProperties];
	}
	return self;
}

- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self)
	{
		[self setDefaultProperties];
	}
	return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
	if (self)
	{
		[self setDefaultProperties];
	}
	return self;
}

#pragma mark - Public Methods

- (void)reloadData
{
	[self createCircleItems];
	[self updateLayers];
	[self updateAngles];
}

- (void)layoutSubviews 
{
	for (LTCircleLayer *layer in self.layer.sublayers)
	{
		[CATransaction begin];
		[CATransaction setDisableActions:YES];
		layer.frame = self.bounds;
		[CATransaction commit];
		[layer setNeedsDisplay];
	}
}

#pragma mark - Private Methods

- (void)setDefaultProperties
{
	self.circleLineWidth = 32.0;
	self.animationDuration = 0.5;
}

- (void)createCircleItems
{
	CGFloat total = 0.0;
	NSInteger segments = [self.delegate numberOfSegmentsInCircleView:self];

	
	for (int i = 0; i < segments; i++)
	{
		total = total + [self.delegate circleView:self valueForSegment:i];
	}
	
	if (total <=  0)
	{
		return;
	}
	
	NSMutableArray *circleItems = [[NSMutableArray alloc] init];
	
	for (int i = 0; i < segments; i++)
	{
		LTCircleItem *item		= [[LTCircleItem alloc] init];
		item.normalizedValue	= [self.delegate circleView:self valueForSegment:i] / total;
		item.color				= [self.delegate circleView:self colorForSegment:i];
		[circleItems addObject:item];
	}
	self.circleItems = circleItems;
}

// Adjust the amount of layers
- (void)updateLayers
{
	if (self.layer.sublayers.count < self.circleItems.count)
	{
		NSInteger layersToCreate = self.circleItems.count - self.layer.sublayers.count;
		
		for (int i = 0; i < layersToCreate; i++)
		{
			LTCircleLayer *layer = [LTCircleLayer new];
			layer.frame = self.bounds;
			[self.layer addSublayer:layer];
		}
	}
	else if (self.layer.sublayers.count > self.circleItems.count)
	{
		NSInteger layersToRemove = self.layer.sublayers.count - self.circleItems.count;
		
		for (int i = 0; i < layersToRemove; i++)
		{
			[[self.layer.sublayers lastObject] removeFromSuperlayer];
		}
	}
	
	
	for (int i = 0; i < self.circleItems.count; i++)
	{
		LTCircleItem *item		= [self.circleItems objectAtIndex:i];
		LTCircleLayer *layer	= (LTCircleLayer *)[self.layer.sublayers objectAtIndex:i];
		
		layer.circleLineWidth		= self.circleLineWidth;
		layer.animationDuration = self.animationDuration;
		layer.fillColor			= item.color;
		layer.frame				= self.bounds;
		item.layer				= layer;
	}
}

// Update angles of layers
- (void)updateAngles
{
	CGFloat lastAngle = 0.0;
	for (LTCircleItem *item in self.circleItems)
	{
		CGFloat spanAngle = (M_PI * 2) * item.normalizedValue;
		
		item.layer.startAngle	= lastAngle;
		item.layer.endAngle		= lastAngle + spanAngle;
		
		lastAngle = lastAngle + spanAngle;
	}
}

#pragma mark - Setters

- (void)setcircleLineWidth:(CGFloat)circleLineWidth
{
	_circleLineWidth = circleLineWidth;
	[self layoutSubviews];
}

- (void)setAnimationDuration:(CGFloat)animationDuration
{
	_animationDuration = animationDuration;
	for (LTCircleLayer *layer in self.layer.sublayers)
	{
		layer.animationDuration = _animationDuration;
	}
}




@end
