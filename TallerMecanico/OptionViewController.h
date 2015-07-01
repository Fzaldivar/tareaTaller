//
//  OptionViewController.h
//  TallerMecanico
//
//  Created by FUTAPP on 29/6/15.
//  Copyright (c) 2015 FUTAPP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OptionViewController : UIViewController
- (IBAction)oneDay:(id)sender;
- (IBAction)oneMonth:(id)sender;
- (IBAction)allData:(id)sender;

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@end
