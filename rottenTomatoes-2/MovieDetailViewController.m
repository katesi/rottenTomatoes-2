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
@property (weak, nonatomic) IBOutlet UIView *detailsView;

@end

@implementation MovieDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleLabel.text =  self.movie[@"title"];
    self.title = self.movie[@"title"];
    NSDictionary *ratings = self.movie[@"ratings"];
    
    self.criticsLabel.text =  [NSString stringWithFormat:@"%@",ratings[@"critics_score"]];
    self.audienceLabel.text =  [NSString stringWithFormat:@"%@",ratings[@"audience_score"]];
    
    self.synopsisLabel.text = self.movie[@"synopsis"];
    [self.synopsisLabel sizeToFit];
    
    NSString *thumbnailURL = [self.movie valueForKeyPath:@"posters.thumbnail"];
    NSString *fullURL = [thumbnailURL stringByReplacingOccurrencesOfString:@"_tmb.jpg" withString:@"_ori.jpg"];
    [self.posterView setImageWithURL:[NSURL URLWithString:fullURL]];
    
    int viewWidth = self.scrollView.frame.size.width;
    int viewHeight = self.synopsisLabel.frame.origin.y + self.synopsisLabel.frame.size.height;
    
    CGRect detailsFrame = self.detailsView.frame;
    detailsFrame.size.height = viewHeight + 20;
    [self.detailsView setFrame:detailsFrame];
    
    self.scrollView.contentSize = CGSizeMake(viewWidth, self.detailsView.frame.origin.y + detailsFrame.size.height);
    
    detailsFrame.size.height = viewHeight + 200;
    [self.detailsView setFrame:detailsFrame];
   
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
