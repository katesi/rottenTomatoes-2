//
//  MovieDetailViewController.m
//  RottenTomatoes
//
//  Created by Katerina Simonova on 2/8/15.
//  Copyright (c) 2015 Katerina Simonova. All rights reserved.
//

#import "MovieDetailViewController.h"
#import "UIImageView+AFNetworking.h"

@interface MovieDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;
@property (weak, nonatomic) IBOutlet UIImageView *posterView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UILabel *criticsLabel;
@property (weak, nonatomic) IBOutlet UILabel *audienceLabel;

@end

@implementation MovieDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text =  self.movie[@"title"];
    self.title = self.movie[@"title"];
    NSDictionary *ratings = self.movie[@"ratings"];
  
    self.criticsLabel.text =  [NSString stringWithFormat:@"%@",ratings[@"critics_score"]];
    self.audienceLabel.text =  [NSString stringWithFormat:@"%@",ratings[@"audience_score"]];
    
    self.scrollView.contentSize = CGSizeMake(150, 800);
    self.synopsisLabel.numberOfLines = 20;
   
    NSString *url_tmb = [self.movie valueForKeyPath:@"posters.thumbnail"];
    NSString* url = [url_tmb stringByReplacingOccurrencesOfString:@"_tmb.jpg" withString:@"_ori.jpg"];
    [self.posterView setImageWithURL:[NSURL URLWithString:url]];
    
    self.synopsisLabel.text = self.movie[@"synopsis"];
    
    CGSize maximumLabelSize = CGSizeMake(296, FLT_MAX);
    
    CGSize expectedLabelSize = [self.synopsisLabel.text sizeWithFont:self.synopsisLabel.font constrainedToSize:maximumLabelSize lineBreakMode:self.synopsisLabel.lineBreakMode];

    CGRect newFrame = self.synopsisLabel.frame;
    newFrame.size.height = expectedLabelSize.height;
    self.synopsisLabel.frame = newFrame;
    
    
    NSLog(@"%@", self.synopsisLabel);
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
