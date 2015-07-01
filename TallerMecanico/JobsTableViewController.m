//
//  JobsTableViewController.m
//  TallerMecanico
//
//  Created by FUTAPP on 28/6/15.
//  Copyright (c) 2015 FUTAPP. All rights reserved.
//

#import "JobsTableViewController.h"
#import "Job.h"
#import "JobTableViewCell.h"

static int NUMBER_SECTION =1;
static NSString* CELL_IDENTIFIER =@"JobTableViewCell";


@interface JobsTableViewController ()
@property(nonatomic) double titleCost;
@end

@implementation JobsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializer];
    //[self deleteObjects];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void) initializer{
    [self loadJobs];
    UINib *nib =[UINib nibWithNibName:CELL_IDENTIFIER bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:CELL_IDENTIFIER];
    [self loadTitle];
}

-(void) loadJobs{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:self.selectedDate];
    NSInteger day = [components day];
    NSInteger month = [components month];
    NSInteger year = [components year];
    switch (self.selectedSearch) {
        case 1:
            self.jobs = [Job objectsWhere:[NSString stringWithFormat:@"daySearch = %ld AND monthSearch = %ld AND yearSearch = %ld",day,month,year]];
            break;
        case 2:
            self.jobs = [Job objectsWhere:[NSString stringWithFormat:@"monthSearch = %ld AND yearSearch = %ld",month,year]];
            break;
            
        default:
            self.jobs = [Job allObjects];
            break;
    }
    
    self.jobs = [self.jobs sortedResultsUsingProperty:@"createdDate" ascending:YES];
    self.jobsArray = [self RLMResultsToArray];
    
}

-(void) loadTitle{
    self.titleCost =0.0;
    for (Job *object in self.jobsArray) {
        self.titleCost += object.cost;
    }
    NSString* totalMoney =[NSString stringWithFormat:@"Monto Total = ¢%.02f", self.titleCost];

    self.navigationItem.title = totalMoney;
}

//ESTO ES SOLO PARA BORRAR DATOS TONTOS QUE SE INGRESARON PARA PRUEBAS
-(void) deleteObjects{
    RLMRealm *realm =[RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [realm deleteAllObjects];
    [realm commitWriteTransaction];
}

-(NSMutableArray*)RLMResultsToArray {
    NSMutableArray *array = [NSMutableArray new];
    for (RLMObject *object in self.jobs) {
        [array addObject:object];
    }
    return array;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return NUMBER_SECTION;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.jobsArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JobTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELL_IDENTIFIER forIndexPath:indexPath];
    
    Job* jobObject = [self.jobsArray objectAtIndex:indexPath.row];
    cell.brandLabel.text = jobObject.brand;
    cell.userLabel.text = jobObject.user;
    cell.costLabel.text = [NSString stringWithFormat:@"¢%.02f", jobObject.cost];
    cell.yearLabel.text = [NSString stringWithFormat:@"%d",jobObject.year];
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}


@end
