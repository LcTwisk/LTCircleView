//
//  ViewController.m
//  LTCircleView
//
//  Created by Lucas Twisk on 20-12-15.
//  Copyright © 2015 Lucas Twisk. All rights reserved.
//

#import "ViewController.h"
#import "LTCircleView.h"
#import "LTCircleItem.h"
#import "LTTableViewCell.h"

@interface ViewController () <UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate, LTCircleViewDataSource>

@property (weak, nonatomic) IBOutlet LTCircleView *circleView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *circleHeight;

@property (weak, nonatomic) IBOutlet UISlider *circleWidthSlider;
@property (weak, nonatomic) IBOutlet UISlider *animationDurationSlider;

@property (strong, nonatomic) NSNumberFormatter *numberFormatter;

@property (strong, nonatomic) NSArray *names;
@property (strong, nonatomic) NSArray *colors;

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	self.circleView.circleWidth = 32.0;
	self.circleView.animationDuration = 0.3;
	self.circleView.delegate = self;
	
	self.circleWidthSlider.minimumValue = 1.0;
	self.circleWidthSlider.maximumValue = 125.0;
	self.circleWidthSlider.value = 32.0;
	
	self.animationDurationSlider.minimumValue = 0.0;
	self.animationDurationSlider.maximumValue = 1.0;
	self.animationDurationSlider.value = 0.3;
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
	self.tableView.contentInset = UIEdgeInsetsMake(350, 0, 0, 0);
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return self.names.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	LTTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
	
	cell.nameLabel.text = [self.names objectAtIndex:indexPath.row];
	cell.nameLabel.textColor = [self.colors objectAtIndex:indexPath.row];
	cell.valueLabel.text = [self.numberFormatter stringFromNumber:@(cell.stepper.value)];
	cell.valueLabel.textColor = [self.colors objectAtIndex:indexPath.row];
	cell.stepper.tintColor = [self.colors objectAtIndex:indexPath.row];
	cell.stepper.tag = indexPath.row;
	
	return cell;
}

#pragma mark - LTCircleViewDataSource

- (NSInteger)numberOfSegmentsInCircleView:(LTCircleView *)circleView
{
	return self.names.count;
}

- (CGFloat)circleView:(LTCircleView *)circleView valueForSegment:(NSInteger)segment
{
	LTTableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:segment inSection:0]];
	return cell.stepper.value;
}

- (UIColor *)circleView:(LTCircleView *)circleView colorForSegment:(NSInteger)index
{
	return [self.colors objectAtIndex:index];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	self.circleHeight.constant = MAX(-scrollView.contentOffset.y - 100, 0);
}

#pragma mark - Actions

- (IBAction)circleWidthSliderChanged:(UISlider *)slider
{
	self.circleView.circleWidth = slider.value;
	[self.circleView reloadData];
}

- (IBAction)animationDurationSliderChanged:(UISlider *)slider
{
	self.circleView.animationDuration = slider.value;
	[self.circleView reloadData];
}


- (IBAction)stepperPressed:(UIStepper *)sender
{
	[self.circleView reloadData];
	[self.tableView reloadData];
}

#pragma mark - Properties

- (NSArray *)colors
{
	if (!_colors)
	{
		_colors = @[[UIColor colorWithRed:0.102 green:0.737 blue:0.612 alpha:1.00],
					[UIColor colorWithRed:0.204 green:0.596 blue:0.859 alpha:1.00],
					[UIColor colorWithRed:0.906 green:0.298 blue:0.235 alpha:1.00],
					[UIColor colorWithRed:0.945 green:0.769 blue:0.059 alpha:1.00],
					[UIColor colorWithRed:0.608 green:0.349 blue:0.714 alpha:1.00]];
	}
	return _colors;
}

- (NSArray *)names
{
	if (!_names)
	{
		_names = @[@"Name1", @"Name2", @"Name3", @"Name4", @"Name5"];
	}
	return _names;
}

- (NSNumberFormatter *)numberFormatter {
	if(!_numberFormatter) {
		_numberFormatter = [NSNumberFormatter new];
		_numberFormatter.locale = [[NSLocale alloc]  initWithLocaleIdentifier:@"nl_NL"];
	}
	return _numberFormatter;
}

@end
