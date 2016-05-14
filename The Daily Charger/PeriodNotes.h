//
//  PeriodNotes.h
//  The Daily Charger
//
//  Created by Miranda Durham on 9/7/15.
//  Copyright (c) 2015 dOOP. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DayView.h"

@interface PeriodNotes : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *notesEdit;
//@property (weak, nonatomic) IBOutlet UIButton *doneButton;
@property NSIndexPath *index;
@property NSString *notes;
@property (weak, nonatomic) DayView *host;

- (id)initWithIndex:(NSIndexPath *)index host:(DayView *)host notes:(NSString *)notes;

@end
