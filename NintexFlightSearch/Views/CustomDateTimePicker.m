//
//  CustomDateTimePicker.m
//  NintexFlightSearch
//
//  Copyright (c) 2015 Thong Vu. All rights reserved.
//

#import "CustomDateTimePicker.h"

#define MyDateTimePickerToolbarHeight 40

@interface CustomDateTimePicker()

@property (nonatomic, assign, readwrite) UIDatePicker *picker;

@property (nonatomic, assign) id doneTarget;
@property (nonatomic, assign) id cancelTarget;
@property (nonatomic, assign) SEL doneSelector;
@property (nonatomic, assign) SEL cancelSelector;

- (void) donePressed;
- (void) cancelPressed;

@end


@implementation CustomDateTimePicker

@synthesize picker = _picker;
@synthesize doneTarget = _doneTarget;
@synthesize cancelTarget = _cancelTarget;
@synthesize doneSelector = _doneSelector;
@synthesize cancelSelector = _cancelSelector;

- (id) initWithFrame: (CGRect) frame {
    if ((self = [super initWithFrame: frame])) {
        self.backgroundColor = [UIColor clearColor];
        
        UIDatePicker *picker = [[UIDatePicker alloc] initWithFrame: CGRectMake(0, MyDateTimePickerToolbarHeight, frame.size.width, frame.size.height - MyDateTimePickerToolbarHeight)];
        [self addSubview: picker];
        
        UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame: CGRectMake(0, 0, frame.size.width, MyDateTimePickerToolbarHeight)];
        toolbar.barStyle = UIBarStyleBlackOpaque;
        toolbar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle: NSLocalizedString(@"Done", @"")  style: UIBarButtonItemStyleBordered target: self action: @selector(donePressed)];
        UIBarButtonItem* flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle: NSLocalizedString(@"Cancel", @"") style: UIBarButtonItemStyleBordered target: self action: @selector(cancelPressed)];
        toolbar.items = [NSArray arrayWithObjects:cancelButton,flexibleSpace, doneButton, nil];
        
        [self addSubview: toolbar];
        
        self.picker = picker;
        picker.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin;
        
        self.autoresizesSubviews = YES;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin;
    }
    return self;
}

- (void) setMode: (UIDatePickerMode) mode {
    self.picker.datePickerMode = mode;
}

- (void) setMinDate: (NSDate*) date {
    [self.picker setMinimumDate: date];
}

- (void) setMaxDate: (NSDate*) date {
    [self.picker setMaximumDate: date];
}

- (void) donePressed {
    if (self.doneTarget) {
        [self.doneTarget performSelector:self.doneSelector withObject:nil afterDelay:0];
    }
}

- (void) cancelPressed {
    if (self.cancelTarget) {
        [self.cancelTarget performSelector:self.cancelSelector withObject:nil afterDelay:0];
    }
}

- (void) addTargetForDoneButton: (id) target action: (SEL) action {
    self.doneTarget = target;
    self.doneSelector = action;
}

- (void) addTargetForCancelButton: (id) target action: (SEL) action {
    self.cancelTarget=target;
    self.cancelSelector=action;
}

@end

