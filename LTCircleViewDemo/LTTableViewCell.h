//
//  LTTableViewCell.h
//  LTCircleView
//
//  Created by Lucas Twisk on 23-12-15.
//  Copyright © 2015 Lucas Twisk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LTTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *valueLabel;
@property (weak, nonatomic) IBOutlet UIStepper *stepper;

@end
