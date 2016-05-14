//
//  EditBlock.h
//  AA Schedule
//

#import <UIKit/UIKit.h>
#import "EditDay.h"
#import "FCColorPickerViewController.h"

@interface EditBlock : UIViewController <FCColorPickerViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UINavigationBar *detailViewController;
@property (weak, nonatomic) IBOutlet UITextField *ClassNameEdit;
@property (weak, nonatomic) IBOutlet UITextField *RoomEdit;
@property (weak, nonatomic) IBOutlet UISegmentedControl *FreeEdit;
@property (weak, nonatomic) IBOutlet UIButton *selectColor;

@property (strong, nonatomic) NSMutableDictionary *periodData;
@property (nonatomic) NSInteger index;
@property (weak, nonatomic) EditDay *editor;

- (IBAction)cancelTapped:(id)sender;
- (IBAction)doneTapped:(id)sender;
- (IBAction)pickColor:(id)sender;
- (IBAction)freeChanged:(id)sender;

- (id)initWithPeriodData:(NSMutableDictionary *)data index:(NSInteger)index editor:(EditDay *)editor;

@end
