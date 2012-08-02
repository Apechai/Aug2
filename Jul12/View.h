//
//  View.h
//  Jul12
//
//  Created by Matthew Fong on 7/11/12.
//  Copyright (c) 2012 Goldman Sachs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface View : UIView {
    NSDateFormatter *dateFormatter;
	UIDatePicker *datePicker;
	UITextView *textView;
    UISwitch *mySwitch;
    UITextField *eventText;

}

@property (nonatomic, retain) UIDatePicker *datePicker;
@property (nonatomic, retain) UITextField *eventText;

- (IBAction) scheduleAlarm:(id) sender;

@end
