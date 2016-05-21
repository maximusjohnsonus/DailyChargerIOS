//
//  EditPeriod.m
//  AA Schedule
//

#import "EditPeriod.h"
#import "EditSchedule.h"
#import "KeyDefinitions.h"
#import "CustomMethods.h"
#import "UIColor+Custom.h"

@interface EditPeriod()
@property (strong, nonatomic) UIColor *pickerColor;
@end

@implementation EditPeriod
- (id)initWithNibName:(NSString *)nibName bundle:(NSBundle *)bundle periodData:(NSMutableDictionary *)data index:(NSIndexPath *)path editor:(EditDay *)editor{
    self = [super initWithNibName:nibName bundle:bundle];
    if(self){
        self.editor = editor;
        self.periodData = data;
        self.index = path;
    }
    return self;
}

- (void) viewDidLoad{
    [super viewDidLoad];
    [self.ClassNameEdit setText:self.periodData[kClassName]]; //TODO: dynamic text box size
    [self.RoomEdit setText:self.periodData[kRoom]];
    [self.FreeEdit setSelectedSegmentIndex:([self.periodData[kIsFree] boolValue] ? 1:0)];
    [self.selectColor setBackgroundColor:[CustomMethods getColor:self.periodData]];
    //self.StartEdit = [[UIDatePicker alloc] initWithFrame:CGRectMake(8,70,125,162)];
    //self.StartEdit.datePickerMode=UIDatePickerModeTime;
    
    NSDateComponents *timeComponents = [[NSDateComponents alloc] init];
    [timeComponents setYear:1970];
    [timeComponents setMonth:1];
    [timeComponents setDay:1];
    [timeComponents setHour:[self.periodData[kStart] integerValue]/60]; //no 24hr adjustment needed here
    [timeComponents setMinute:[self.periodData[kStart] integerValue]%60];
    [self.StartEdit setDate:[[[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian] dateFromComponents:timeComponents] animated:NO]; //TODO: 24hr adjust
    [timeComponents setHour:[self.periodData[kEnd] integerValue]/60]; //no 24hr adjustment needed here
    [timeComponents setMinute:[self.periodData[kEnd] integerValue]%60];
    [self.EndEdit setDate:[[[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian] dateFromComponents:timeComponents] animated:NO]; //TODO: 24hr adjust
    
    [self.view addSubview:self.StartEdit];

    
    self.title = @"Edit Period";
}


//TODO: only allow correct time order

- (IBAction)freeChanged:(id)sender{
    if(((UISegmentedControl *)sender).selectedSegmentIndex==0){
        if([self.ClassNameEdit.text isEqualToString:@"Free"])
            self.ClassNameEdit.text = self.periodData[kClassName];
        if([self.RoomEdit.text isEqualToString:@""])
            self.RoomEdit.text = self.periodData[kRoom];
        if(!self.pickerColor && !self.periodData[kColor])
            [self.selectColor setBackgroundColor:[CustomMethods getColor:[[NSMutableDictionary alloc] initWithObjectsAndKeys:@NO, kIsFree, self.periodData[kBlock], kBlock, nil]]];
        
    }
    else if(((UISegmentedControl *)sender).selectedSegmentIndex==1){
        if([self.ClassNameEdit.text isEqualToString:self.periodData[kClassName]])
            self.ClassNameEdit.text = @"Free";
        if([self.RoomEdit.text isEqualToString:self.periodData[kRoom]])
            self.RoomEdit.text = @"";
        if(!self.pickerColor && !self.periodData[kColor])
            [self.selectColor setBackgroundColor:[CustomMethods getColor:[[NSMutableDictionary alloc] initWithObjectsAndKeys:@YES, kIsFree, self.periodData[kBlock], kBlock, nil]]];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if(textField == self.ClassNameEdit){
        [textField resignFirstResponder];
        [self.RoomEdit becomeFirstResponder];
    } else if(textField == self.RoomEdit){
        [textField resignFirstResponder];
    }
    return YES;
}

- (IBAction)pickColor:(id)sender {
    FCColorPickerViewController *colorPicker = [FCColorPickerViewController colorPickerWithColor:(self.pickerColor ? self.pickerColor : [CustomMethods getColor:self.periodData])
                                                                                        delegate:self];
    colorPicker.tintColor = [UIColor whiteColor];
    [colorPicker setModalPresentationStyle:UIModalPresentationFormSheet];
    [self presentViewController:colorPicker
                       animated:YES
                     completion:nil];
}

- (void)colorPickerViewController:(FCColorPickerViewController *)colorPicker
                   didSelectColor:(UIColor *)color {
    self.pickerColor = color;
    [self.selectColor setBackgroundColor:color];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)colorPickerViewControllerDidCancel:(FCColorPickerViewController *)colorPicker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)cancelTapped:(id)sender{
    //NSLog(@"tapp %@", sender);
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)doneTapped:(id)sender{
    NSDateComponents *startComp = [[[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian] components:NSCalendarUnitHour|NSCalendarUnitMinute fromDate:self.StartEdit.date];
    NSDateComponents *endComp = [[[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian] components:NSCalendarUnitHour|NSCalendarUnitMinute fromDate:self.EndEdit.date];

    NSInteger startTime = startComp.hour*60 + startComp.minute;
    NSInteger endTime = endComp.hour*60 + endComp.minute;
    //NSLog(@"8 %d %d", startTime, endTime);

    if(startTime > endTime){
        NSInteger temp = startTime;
        startTime = endTime;
        endTime = temp;
    }
//    NSLog(@"place 4 %d",self.FreeEdit.selectedSegmentIndex);
    //NSLog(@"color==nil: %d", self.pickerColor == nil);
    NSMutableDictionary *newPeriod;
    if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1){
        newPeriod = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                          self.ClassNameEdit.text, kClassName,
                                          self.RoomEdit.text, kRoom,
                                          @(startTime), kStart,
                                          @(endTime), kEnd,
                                          @(self.FreeEdit.selectedSegmentIndex==1), kIsFree,
                                          nil];
    } else {
        newPeriod = [@{                       
                       kStart : @(startTime),
                       kEnd : @(endTime),
                       kIsFree : @(self.FreeEdit.selectedSegmentIndex==1)
                       } mutableCopy];
        if(self.RoomEdit.text)
            [newPeriod setObject:self.RoomEdit.text forKey:kRoom];
        if(self.ClassNameEdit.text)
            [newPeriod setObject:self.ClassNameEdit.text forKey:kClassName];
        
    }
  //  if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1 || self.FreeEdit.selectedSegmentIndex==1)
//        [newPeriod setObject:@(self.FreeEdit.selectedSegmentIndex==1) forKey:kIsFree];

    if(self.pickerColor)
        [newPeriod setObject:[UIColor dictionaryFromColor:self.pickerColor] forKey:kColor];
    
    //NSLog(@"place 5");

    //if color is different, set color

    [self.editor updatePeriodAt:self.index to:newPeriod];
    [self dismissViewControllerAnimated:YES completion:nil]; //.view.window.rootViewController
}

@end
