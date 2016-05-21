//
//  EditBlock.m
//  AA Schedule
//

#import "EditBlock.h"
#import "EditSchedule.h"
#import "KeyDefinitions.h"
#import "CustomMethods.h"
#import "UIColor+Custom.h"

@interface EditBlock()
@property (strong, nonatomic) UIColor *pickerColor;
@end

@implementation EditBlock
- (id)initWithPeriodData:(NSMutableDictionary *)data index:(NSInteger)index editor:(EditDay *)editor{
    self = [super init];
    if(self){
        self.editor = editor;
        self.periodData = data;
        self.index = index;
    }
    return self;
}
- (void) viewDidLoad{
    [super viewDidLoad];
    [self.ClassNameEdit setText:self.periodData[kClassName]]; //TODO: dynamic text box size
    [self.RoomEdit setText:self.periodData[kRoom]];
    [self.FreeEdit setSelectedSegmentIndex:([self.periodData[kIsFree] boolValue] ? 1:0)];
    [self.selectColor setBackgroundColor:[CustomMethods getColor:self.periodData]];
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
    } //TODO: ^ makes custom color into paled default color when class that came in with custom color set is set to free. only changes bg color, not selected
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
    [self.view.window.rootViewController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)doneTapped:(id)sender{    
    NSMutableDictionary *newPeriod = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@(self.FreeEdit.selectedSegmentIndex == 1), kFreeState, nil];
    if(![self.ClassNameEdit.text isEqualToString:self.periodData[kClassName]]){
        if (self.ClassNameEdit.text || floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1)
            [newPeriod setObject:self.ClassNameEdit.text forKey:kClassName];
    }
    if(![self.RoomEdit.text isEqualToString:self.periodData[kRoom]]){
        if (self.RoomEdit.text || floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1)
            [newPeriod setObject:self.RoomEdit.text forKey:kRoom];
    }
    if([self.periodData[kIsFree] boolValue] != self.FreeEdit.selectedSegmentIndex==1){
        [newPeriod setObject:@(self.FreeEdit.selectedSegmentIndex==1) forKey:kIsFree];
    }
    if(self.pickerColor){
        [newPeriod setObject:[UIColor dictionaryFromColor:self.pickerColor] forKey:kColor];
    }
    //TODO: if color is different, set color
    
    [self.editor updateBlockAt:self.index to:newPeriod];
    [self.view.window.rootViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
