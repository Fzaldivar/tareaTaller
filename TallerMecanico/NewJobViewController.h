//
//  NewJobViewController.h
//  TallerMecanico
//
//  Created by FUTAPP on 28/6/15.
//  Copyright (c) 2015 FUTAPP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewJobViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UITextField *userTextField;
@property (weak, nonatomic) IBOutlet UITextField *brandTextField;
@property (weak, nonatomic) IBOutlet UIPickerView *yearPicker;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextField;

@property (weak, nonatomic) IBOutlet UITextField *moneyTextField;

@end
