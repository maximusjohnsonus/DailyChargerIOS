//
//  Period.m
//  AA Schedule
//

#import "Period.h"
#import "StringLibrary.h"
#import "CustomMethods.h"
#import "UIColor+Custom.h"
#import "EditPeriod.h"
#import "EditBlock.h"
#import "IntegerLibrary.h"
#import "PeriodNotes.h"
#import <UIKit/UIKit.h>

@interface Period()
- (NSString *) getMainText;
- (NSString *) getTimeText;
//- (NSInteger) getLength;
@end

@implementation Period

#pragma mark - Table Cell

- (void)awakeFromNib {
    // Initialization code
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    if(self.editor!=nil){ //if in edit mode, launch period editor
        UIViewController *newEditPeriod;
        if(!self.isBlock){
            if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1) {
                newEditPeriod = [[EditPeriod alloc] initWithNibName:@"EditPeriod" bundle:nil periodData:self.periodData index:self.index editor:self.editor];
            } else {
                newEditPeriod = [[EditPeriod alloc] initWithNibName:@"EditPeriodForSix" bundle:nil periodData:self.periodData index:self.index editor:self.editor];
            }
            //newEditPeriod = [[EditPeriod alloc] initWithNibName:@"EditPeriodForSix" bundle:nil];
        } else {
            newEditPeriod = [[EditBlock alloc] initWithPeriodData:self.periodData index:self.index.row editor:self.editor];
        }
        newEditPeriod.view.frame = self.window.bounds;
        newEditPeriod.view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self.window.rootViewController presentViewController:newEditPeriod animated:YES completion:nil];
    } else if([CustomMethods enableNotes]) { //else if notes enabled (and assuming we're in View Schedule because that's the only option that's not edit right now) launch period notes
        UIViewController *perNotes = [[PeriodNotes alloc] initWithIndex:[NSIndexPath indexPathForRow:self.index.row inSection:self.dayIndex] host:self.host notes:self.notes];
        perNotes.view.frame = self.window.bounds;
        perNotes.view.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self.window.rootViewController presentViewController:perNotes animated:YES completion:nil];
    }
    
}



#pragma mark - Data Model

/*- (void) prepareForReuse{

}*/

- (void) setPeriodData:(NSMutableDictionary *)data index:(NSIndexPath *)path dayIndex:(NSInteger)dayIndex notes:(NSString *)notes{
    if(self.ClassNameLabel!=nil){
        [self.ClassNameLabel removeFromSuperview];
    }
    self.index = path;
    self.dayIndex = dayIndex;
    self.periodData = data;
    self.notes = notes;
    //self.ClassNameLabel.text = [self getMainText];
    if(!self.isBlock)
        self.TimeLabel.text = [self getTimeText];
    else
        self.TimeLabel.text = @"";
    
    //if(self.ClassNameLabel==nil)
        self.ClassNameLabel = [[UILabel alloc] init];

    CGSize expectedLabelSize = [[self getMainText] sizeWithFont:[UIFont systemFontOfSize:13]];
    NSInteger leftBuffer = 75; //good amount to avoid overlap with time label
//    if(expectedLabelSize.width<self.frame.size.width - 2*padding - 2*leftBuffer){ //if label will be small enough to center
    if(expectedLabelSize.width/2+leftBuffer<self.frame.size.width/2){ //if label will be small enough to center
        //classLabel = [[UILabel alloc] init];//WithFrame:CGRectMake(-10, 0, self.frame.size.width, self.frame.size.height)];
        self.ClassNameLabel.textAlignment = NSTextAlignmentCenter; //pre-ios6 supposedly: yourLabel.textAlignment = UITextAlignmentCenter;
    }
    self.ClassNameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.ClassNameLabel.font = [UIFont systemFontOfSize:13];
    self.ClassNameLabel.text = [self getMainText];
    self.ClassNameLabel.backgroundColor = [UIColor clearColor];

    [self.contentView addSubview:self.ClassNameLabel];
    
    
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:self.ClassNameLabel
                                                                     attribute:NSLayoutAttributeTop
                                                                     relatedBy:NSLayoutRelationEqual
                                                                        toItem:self.contentView
                                                                     attribute:NSLayoutAttributeTop
                                                                    multiplier:1.0f
                                                                      constant:0.0f];
    NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:self.ClassNameLabel
                                                                        attribute:NSLayoutAttributeBottom
                                                                        relatedBy:NSLayoutRelationEqual
                                                                           toItem:self.contentView
                                                                        attribute:NSLayoutAttributeBottom
                                                                       multiplier:1.0f
                                                                         constant:0.0f];
    
    NSLayoutConstraint *leftConstraint = [NSLayoutConstraint constraintWithItem:self.ClassNameLabel
                                                                      attribute:NSLayoutAttributeLeft
                                                                      relatedBy:NSLayoutRelationEqual
                                                                         toItem:self.contentView
                                                                      attribute:NSLayoutAttributeLeft
                                                                     multiplier:1.0f
                                                                       constant:(expectedLabelSize.width<self.frame.size.width /* - 2*padding*/ - 2*leftBuffer ? 0.0f : leftBuffer*1.0f)]; //if small enough to center, no left offset, else offset leftBuffer
    NSLayoutConstraint *rightConstraint = [NSLayoutConstraint constraintWithItem:self.ClassNameLabel
                                                                       attribute:NSLayoutAttributeRight
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:self.contentView
                                                                       attribute:NSLayoutAttributeRight
                                                                      multiplier:1.0f
                                                                        constant:0.0f];
    
    [self.contentView addConstraint:topConstraint];
    [self.contentView addConstraint:bottomConstraint];
    [self.contentView addConstraint:leftConstraint];
    [self.contentView addConstraint:rightConstraint];


    
    //moved to editDay and viewDay willDisplayCell for ios6 //I have no idea what I was trying to say here. sorry :(
    //self.backgroundColor = [CustomMethods getColor:self.periodData];
}

- (NSString *) getMainText{
    NSString *notesText = (self.notes==nil || [self.notes isEqualToString:@""] || ![CustomMethods enableNotes] ? @"" : [NSString stringWithFormat:@" - %@",self.notes]); //don't display notes if there are none or notes aren't enabled
    notesText = [[notesText componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]] objectAtIndex:0]; //first line of the notes
    return [self.periodData[kClassName] stringByAppendingFormat:@"%@%@",
              (self.periodData[kRoom]==nil || [self.periodData[kRoom] isEqualToString:@""] ? @"" : [NSString stringWithFormat:@" (%@)", self.periodData[kRoom]]),
              notesText];
    
    
}
- (NSString *) getTimeText{
    return [NSString stringWithFormat:@"%@ - %@", [CustomMethods intToTimeString: [self.periodData[kStart] integerValue]], [CustomMethods intToTimeString: [self.periodData[kEnd] integerValue]]];
}
/*- (NSInteger) getLength{
    return ([self.periodData[kEnd] integerValue] - [self.periodData[kStart] integerValue]);
}*/


@end
