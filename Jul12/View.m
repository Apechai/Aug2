//
//  View.m
//  Jul12
//
//  Created by Matthew Fong on 7/11/12.
//  Copyright (c) 2012 Goldman Sachs. All rights reserved.
//

#import "View.h"

@implementation View
@synthesize datePicker, eventText;

- (void) valueChanged
{

    [dateFormatter setDateFormat:@"HH:mm"]; //24hr time format

    textView.text = [NSString stringWithFormat: @"Switch on to remind you to keep up that good habit everyday at %@. (from Matt's new Mac)",[dateFormatter stringFromDate: datePicker.date]];
}

- (id) initWithFrame: (CGRect) frame
{
	self = [super initWithFrame: frame];
	if (self) {
		// Initialization code
		self.backgroundColor = [UIColor whiteColor];
		dateFormatter = [[NSDateFormatter alloc] init];
		[dateFormatter setDateStyle: NSDateFormatterFullStyle];
		[dateFormatter setTimeStyle: NSDateFormatterFullStyle];
        
		//Let the date picker assume its natural size.
		datePicker = [[UIDatePicker alloc] initWithFrame: CGRectZero];
		datePicker.datePickerMode = UIDatePickerModeTime; //vs. UIDatePickerModeTime
        
		//Center the picker in the DatePickerView.
		CGRect b = self.bounds;
        
		datePicker.frame = CGRectMake(
                                      b.origin.x,
                                      b.origin.y,
                                      datePicker.bounds.size.width,
                                      datePicker.bounds.size.height
                                      );
        
		[datePicker addTarget: self
                       action: @selector(valueChanged)
             forControlEvents: UIControlEventValueChanged
         ];
        
		[self addSubview: datePicker];
        
		//TextView occupies all of the View below the picker.
        
		CGRect f = CGRectMake(
                              b.origin.x,
                              b.origin.y + datePicker.bounds.size.height,
                              b.size.width,
                              b.size.height - datePicker.bounds.size.height
                              );
        
		textView = [[UITextView alloc] initWithFrame: f];
		textView.editable = NO;
		textView.font = [UIFont systemFontOfSize: 22];
		[self valueChanged];
		[self addSubview: textView];
        
        
        CGRect g = CGRectMake(
                              160, 350, 140, 20);
        eventText = [[UITextField alloc] initWithFrame: g];
        eventText.font = [UIFont systemFontOfSize: 14];
        [self addSubview: eventText];
        
        
        
        
        //Do not specify a size for the switch.
		//Let the switch assume its own natural size.
		mySwitch = [[UISwitch alloc] initWithFrame: CGRectZero];
		if (mySwitch == nil) {
			return nil;
		}
        
		//Call the valueChanged: method of the application delegate
		//when the value of the switch is changed.
		
		[mySwitch addTarget: self
                     action: @selector(valueChanged:)
           forControlEvents: UIControlEventValueChanged
         ];
		
		//Center the switch in the SwitchView.
        
		mySwitch.center = CGPointMake(
                                      160,
                                      400
                                      );
        
		mySwitch.on = NO;	//the default
		[self addSubview: mySwitch];
	}

	return self;
}

- (void) valueChanged: (id) sender {
	UISwitch *s = sender;
	if (s.isOn) {
		//The UISwitch has just been turned on.
		textView.backgroundColor = [UIColor greenColor];
        textView.text = [NSString stringWithFormat: @"I'll remind you to do your habit everyday at %@.",[dateFormatter stringFromDate: datePicker.date]];
	} else {
		//The UISwitch has just been turned off.
		
        textView.backgroundColor = [UIColor whiteColor];
        textView.text = [NSString stringWithFormat: @"Don't remind you about good habits."];
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (IBAction) scheduleAlarm:(id) sender {
    [eventText resignFirstResponder];
    
    NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
    
    // Get the current date
    NSDate *pickerDate = [self.datePicker date];
    
    // Break the date up into components
    NSDateComponents *dateComponents = [calendar components:( NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit )
												   fromDate:pickerDate];
    NSDateComponents *timeComponents = [calendar components:( NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit )
												   fromDate:pickerDate];
    // Set up the fire time
    NSDateComponents *dateComps = [[NSDateComponents alloc] init];
    [dateComps setDay:[dateComponents day]];
    [dateComps setMonth:[dateComponents month]];
    [dateComps setYear:[dateComponents year]];
    [dateComps setHour:[timeComponents hour]];
	// Notification will fire in one minute
    [dateComps setMinute:[timeComponents minute]];
	[dateComps setSecond:[timeComponents second]];
    NSDate *itemDate = [calendar dateFromComponents:dateComps];
    
    UILocalNotification *localNotif = [[UILocalNotification alloc] init];
    if (localNotif == nil)
        return;
    localNotif.fireDate = itemDate;
    localNotif.timeZone = [NSTimeZone defaultTimeZone];
    
	// Notification details
    localNotif.alertBody = [eventText text];
	// Set the action button
    localNotif.alertAction = @"View";
    
    localNotif.soundName = UILocalNotificationDefaultSoundName;
    localNotif.applicationIconBadgeNumber = 1;
    
	// Specify custom data for the notification
    NSDictionary *infoDict = [NSDictionary dictionaryWithObject:@"someValue" forKey:@"someKey"];
    localNotif.userInfo = infoDict;
    
	// Schedule the notification
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
    
}

@end
