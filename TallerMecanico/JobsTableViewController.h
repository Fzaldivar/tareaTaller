//
//  JobsTableViewController.h
//  TallerMecanico
//
//  Created by FUTAPP on 28/6/15.
//  Copyright (c) 2015 FUTAPP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Realm/Realm.h>


@interface JobsTableViewController : UITableViewController

@property(nonatomic,strong) RLMResults* jobs;
@property(nonatomic,strong) NSMutableArray* jobsArray;
@property(nonatomic) int selectedSearch;
@property(nonatomic) NSDate* selectedDate;

@end
