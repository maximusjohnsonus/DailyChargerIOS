//
//  ViewSchedule.h
//  ScrollViews
//

#import <UIKit/UIKit.h>

@interface ViewSchedule : UIViewController <UIScrollViewDelegate>

@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

- (void) unlock;
- (void)purgePage:(NSInteger)page;
- (void)loadPage:(NSInteger)page;
- (void)showPage:(NSInteger)page;

@end
