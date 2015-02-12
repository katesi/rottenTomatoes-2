//
//  MovieCell.h
//  RottenTomatoes
//
//  Created by Katerina Simonova on 2/8/15.
//  Copyright (c) 2015 Katerina Simonova. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;

@property (weak, nonatomic) IBOutlet UIImageView *posterView;

@end
