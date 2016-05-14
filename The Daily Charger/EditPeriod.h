//
//  EditPeriod.h
//  AA Schedule
//

#import <UIKit/UIKit.h>
#import "EditDay.h"
#import "FCColorPickerViewController.h"

@interface EditPeriod : UIViewController <FCColorPickerViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UINavigationBar *detailViewController;
@property (weak, nonatomic) IBOutlet UITextField *ClassNameEdit;
@property (weak, nonatomic) IBOutlet UITextField *RoomEdit;
//@property (strong, nonatomic) UIDatePicker *StartEdit;
@property (weak, nonatomic) IBOutlet UIDatePicker *StartEdit;
@property (weak, nonatomic) IBOutlet UIDatePicker *EndEdit;
@property (weak, nonatomic) IBOutlet UISegmentedControl *FreeEdit;
@property (weak, nonatomic) IBOutlet UIButton *selectColor;

@property (strong, nonatomic) NSMutableDictionary *periodData;
@property (strong, nonatomic) NSIndexPath *index;
@property (weak, nonatomic) EditDay *editor;

- (IBAction)cancelTapped:(id)sender;
- (IBAction)doneTapped:(id)sender;
- (IBAction)pickColor:(id)sender;
- (IBAction)freeChanged:(id)sender;

- (id)initWithNibName:(NSString *)nibName bundle:(NSBundle *)bundle periodData:(NSMutableDictionary *)data index:(NSIndexPath *)path editor:(EditDay *)editor;
@end
