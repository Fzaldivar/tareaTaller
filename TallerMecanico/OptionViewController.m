//
//  OptionViewController.m
//  TallerMecanico
//
//  Created by FUTAPP on 29/6/15.
//  Copyright (c) 2015 FUTAPP. All rights reserved.
//

#import "OptionViewController.h"
#import "JobsTableViewController.h"

@interface OptionViewController ()

@end

@implementation OptionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializer];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

-(void) initializer{
    self.datePicker.datePickerMode = UIDatePickerModeDate;
}

-(void) callScreen: (int) selectedType{
    JobsTableViewController *nextView = [self.storyboard instantiateViewControllerWithIdentifier:@"JobsTableViewController"];
    nextView.selectedSearch = selectedType;
    nextView.selectedDate = self.datePicker.date;
    [self.navigationController pushViewController:nextView animated:YES];
}

- (IBAction)oneDay:(id)sender {
    [self callScreen:1];
}

- (IBAction)oneMonth:(id)sender {
    [self callScreen:2];
}

- (IBAction)allData:(id)sender {
    [self callScreen:3];
}
@end
