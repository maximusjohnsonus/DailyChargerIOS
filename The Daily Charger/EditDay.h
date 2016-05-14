//
//  EditDay.h
//  AA Schedule
//
#import <UIKit/UIKit.h>
#import "EditSchedule.h"

@interface EditDay : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic) NSInteger index;
@property (weak, nonatomic) EditSchedule *mommy;

- (id)initWithIndex:(NSInteger)index height:(CGFloat)height parent:(EditSchedule *)mama;
- (void)updatePeriodAt:(NSIndexPath *)path to:(NSMutableDictionary *)data;
- (void)updateBlockAt:(NSInteger)index to:(NSMutableDictionary *)data;

+ (void) setSchedule:(NSMutableArray *)schedule;

@end
