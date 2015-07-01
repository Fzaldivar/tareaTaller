//
//  NewJobViewController.m
//  TallerMecanico
//
//  Created by FUTAPP on 28/6/15.
//  Copyright (c) 2015 FUTAPP. All rights reserved.
//

#import "NewJobViewController.h"
#import "Job.h"
static const int NUMBER_OF_COMPONENTS = 1;

@interface NewJobViewController ()
@property (nonatomic,strong) NSMutableArray* yearArray;
@end

@implementation NewJobViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializer];
}

-(void) initializer{
    [self initializeArray];
    [self initializeBarButtonItem];
    self.moneyTextField.delegate =self;
    self.descriptionTextField.delegate = self;
    
    self.navigationItem.title = @"Ingresar Trabajo";
}

-(void) initializeArray{
    self.yearArray = [NSMutableArray new];
    NSString* num;
    for(int i = 2016; i >= 1960;i--){
        num =[NSString stringWithFormat:@"%d", i];
        [self.yearArray addObject:num];
    }
}

-(void) initializeBarButtonItem{
    UIBarButtonItem *addButton =[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(createJob)];
    self.navigationItem.rightBarButtonItem = addButton;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - PICKER METHODS
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return NUMBER_OF_COMPONENTS;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.yearArray count];
}

- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.yearArray objectAtIndexedSubscript:row];
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    [self.view endEditing:YES];
}

#pragma mark - TEXTFIELD AND TEXTVIEW METHODS
// MÉTODO PARA OCULTAR TECLADO CUANDO SE DA RETURN
-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    if(textField == self.moneyTextField){
        [self animateTextField: textField up: YES];
    }
}


- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if(textField == self.moneyTextField){
        [self animateTextField: textField up: NO];
    }
}

- (void) animateTextField: (UIView*) view up: (BOOL) up
{
    int movementDistance;
    if(view == self.moneyTextField){
        movementDistance =210;
    }else{
        movementDistance =240;
    }
    const float movementDuration = 0.3f;
    
    int movement = (up ? -movementDistance : movementDistance);
    
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

-(void) textViewDidBeginEditing:(UITextView *)textView{
    [self animateTextField: textView up: YES];
}

-(void) textViewDidEndEditing:(UITextView *)textView{
    [self animateTextField: textView up: NO];
}

#pragma mark - NEW JOB
-(void) createJob{
    NSString* newBrand = self.brandTextField.text;
    NSString* newUser = self.userTextField.text;
    NSString* newDescription = self.descriptionTextField.text;
    NSString* newMoney = self.moneyTextField.text;
    NSInteger rowYear = [self.yearPicker selectedRowInComponent:0];
    NSString* yearString =[self.yearArray objectAtIndex:rowYear];
    
    NSArray* testArray = [[NSArray alloc] initWithObjects:newBrand,newDescription,newUser,newMoney, nil];
    
    bool flag = [self noEmptyTextFields:testArray];
    
    if(!flag){
        UIAlertView* alert = [[UIAlertView alloc]initWithTitle: @"Error"message:@"No pueden haber espacios en blanco" delegate:nil cancelButtonTitle:@"Aceptar" otherButtonTitles:nil, nil];
        [alert show];
    }else{
        Job* newJob = [Job new];
        newJob.brand=newBrand;
        newJob.user = newUser;
        newJob.year = [yearString intValue];
        newJob.descriptionJob=newDescription;
        newJob.cost = [newMoney doubleValue];
        newJob.createdDate = [NSDate new];
        NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:newJob.createdDate];
        newJob.daySearch = [components day];
        newJob.monthSearch = [components month];
        newJob.yearSearch = [components year];
        [self saveInDataBase:newJob];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

-(void) saveInDataBase:(Job*) job{
    RLMRealm *real =[RLMRealm defaultRealm];
    [real beginWriteTransaction];
    [real addObject:job];
    [real commitWriteTransaction];
}

-(BOOL) noEmptyTextFields:(NSArray*) list{
    for(NSString* current in list){
        NSString* test = [current stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if(test.length==0)
            return NO;
    }
    return YES;
}

- (IBAction)hideKeyboard:(id)sender {
    [self.view endEditing:YES];
}

@end
