//
//  DayView.h
//  AA Schedule
//
#import <UIKit/UIKit.h>
#import "ViewSchedule.h"

@interface DayView : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic) NSInteger index;
@property (nonatomic) NSInteger dayIndex;
@property (weak, nonatomic) ViewSchedule *daddy;

- (id)initWithIndex:(NSInteger)index dayIndex:(NSInteger)dayIndex height:(CGFloat)height parent:(ViewSchedule *)parent;
- (void) refreshIndex:(NSIndexPath *)index withNewNote:(NSString *)note;
+ (void) setSchedule:(NSMutableArray *)schedule;

@end
