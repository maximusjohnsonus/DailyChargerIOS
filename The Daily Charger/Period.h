//
//  Period.h
//  AA Schedule
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "EditDay.h"
#import "DayView.h"

@interface Period : UITableViewCell
@property (strong, nonatomic) UILabel *ClassNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *TimeLabel;

@property (strong, nonatomic) NSMutableDictionary *periodData;
@property (strong, nonatomic) NSIndexPath *index;
@property (nonatomic) NSInteger dayIndex;
@property (weak, nonatomic) EditDay *editor;
@property (strong, nonatomic) DayView *host;
@property (strong, nonatomic) NSString *notes;
@property (nonatomic) BOOL isBlock;

- (void) setPeriodData:(NSMutableDictionary *)data index:(NSIndexPath *)path dayIndex:(NSInteger)dayIndex notes:(NSString *)notes;
/*- (NSString *) getMainText;
- (NSString *) getTimeText;
- (NSInteger) getLength;
- (UIColor *) getColor;*/

@end
