//
//  CustomMethods.h
//  AA Schedule
//

#import <UIKit/UIKit.h>

@interface CustomMethods : NSObject
+ (NSMutableArray *)getSchedule;
+ (void) saveSchedule:(NSMutableArray *)newSchedule;
+ (NSMutableDictionary *) getNotesForDay:(NSInteger)index;
+ (void) updateNoteTo:(NSString *)newNote forPath:(NSIndexPath *)index;
+ (NSString *)intToTimeString:(NSInteger)time;
+ (BOOL) use24HourTime;
+ (BOOL) enableNotes;
+ (BOOL) showWeekends;
+ (NSInteger) minimumPeriodLength;
+ (NSInteger) getCycleDayForIndex:(NSInteger)index;
+ (UIColor *) getColor:(NSMutableDictionary *)periodData;
@end
