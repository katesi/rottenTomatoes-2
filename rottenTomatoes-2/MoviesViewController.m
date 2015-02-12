//
//  MoviesViewController.m
//  RottenTomatoes
//
//  Created by Katerina Simonova on 2/8/15.
//  Copyright (c) 2015 Katerina Simonova. All rights reserved.
//

#import "MoviesViewController.h"
#import "MovieCell.h"
#import "UIImageView+AFNetworking.h"
#import "MovieDetailViewController.h"
#import "SVProgressHUD.h"

BOOL networkError = FALSE;

@interface MoviesViewController () <UITableViewDataSource, UITableViewDelegate >
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray* movies;
@property (nonatomic, strong) UIRefreshControl *refreshControl;

@end

@implementation MoviesViewController

- (void)doLoad {
    networkError = FALSE;
    
    NSURL *url = [NSURL URLWithString:@"http://api.rottentomatoes.com/api/public/v1.0/lists/movies/box_office.json?limit=30&country=us&apikey=dt9pmfzm7wgspc8gcjwx2k5t"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [SVProgressHUD show];
    
    [NSURLConnection
     sendAsynchronousRequest:request
     queue:[NSOperationQueue mainQueue] completionHandler:
     
     ^(NSURLResponse* response, NSData* data, NSError* connectionError)
     {
         [SVProgressHUD dismiss];
         if (connectionError != nil) {
             networkError = TRUE;
             [self.tableView reloadData];

             [self.refreshControl endRefreshing];
             return;
         }
         NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
         
         NSLog(@"Got the response");
         
         self.movies = responseDictionary[@"movies"];
         [self.tableView reloadData];
         [self.refreshControl endRefreshing];
         
     }
     ];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"MovieCell" bundle:nil] forCellReuseIdentifier:@"MovieCell"];
    NSLog(@"Finish setting up view did load");

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 100;
    self.tableView.delegate = self;
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(onRefresh) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl  atIndex:0];

    [self doLoad];
}

- (void)onRefresh {
    [self doLoad];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (networkError)
        return 1;
    return self.movies.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (networkError)
    {
        UITableViewCell *cell = [[UITableViewCell alloc] init];
        cell.text = @"Network error. Please try again later";
        return cell;
    }
    
    MovieCell* cell = [tableView dequeueReusableCellWithIdentifier:@"MovieCell"];
    
    NSDictionary *movie = self.movies[indexPath.row];
    
    cell.titleLabel.text = movie[@"title"];
    cell.synopsisLabel.text = movie[@"synopsis"];
    
    NSString *url = [movie valueForKeyPath:@"posters.thumbnail"];
    [cell.posterView setImageWithURL:[NSURL URLWithString:url]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MovieDetailViewController *vc = [[MovieDetailViewController alloc]init];
    
    vc.movie = self.movies[indexPath.row];
    
    if (self.movies.count > 0) {
        [self.navigationController pushViewController:vc animated:YES];
    }
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
