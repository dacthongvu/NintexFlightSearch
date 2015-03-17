//
//  CustomDateTimePicker.h
//  NintexFlightSearch
//
//  Copyright (c) 2015 Thong Vu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomDateTimePicker : UIView {
}

@property (nonatomic, assign, readonly) UIDatePicker *picker;

- (void) setMode: (UIDatePickerMode) mode;
- (void) setMinDate: (NSDate*) date;
- (void) setMaxDate: (NSDate*) date;
- (void) addTargetForDoneButton: (id) target action: (SEL) action;
- (void) addTargetForCancelButton: (id) target action: (SEL) action;

@end
