//
//  MainViewController.m
//  TallerMecanico
//
//  Created by FUTAPP on 28/6/15.
//  Copyright (c) 2015 FUTAPP. All rights reserved.
//

#import "MainViewController.h"
#import "NewJobViewController.h"
#import "JobsTableViewController.h"
#import "OptionViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

- (IBAction)insertJob:(id)sender {
    NewJobViewController *nextView = [self.storyboard instantiateViewControllerWithIdentifier:@"NewJobViewController"];
    [self.navigationController pushViewController:nextView animated:YES];
}

- (IBAction)listJobs:(id)sender {
    
    OptionViewController *nextView = [self.storyboard instantiateViewControllerWithIdentifier:@"OptionViewController"];
    [self.navigationController pushViewController:nextView animated:YES];
}
@end
