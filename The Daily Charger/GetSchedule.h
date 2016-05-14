//
//  GetSchedule.h
//  AA Schedule
//

#import <UIKit/UIKit.h>
#import "ViewSchedule.h"
#import "EditSchedule.h"

@interface GetSchedule : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *use1012;
@property (weak, nonatomic) IBOutlet UIButton *use1012offset;
@property (weak, nonatomic) IBOutlet UIButton *use89;
@property (weak, nonatomic) IBOutlet UIButton *use67;

- (IBAction)use1012Tapped:(id)sender;
- (IBAction)use1012OffsetTapped:(id)sender;
- (IBAction)use89Tapped:(id)sender;
- (IBAction)use67Tapped:(id)sender;
//- (IBAction)useSampleTapped:(id)sender;

- (id)initWithViewParent:(ViewSchedule *)daddy;
- (id)initWithEditParent:(EditSchedule *)daddy;

@end
