//
//  EditSchedule.h
//  ScrollViews
//

#import <UIKit/UIKit.h>

@interface EditSchedule : UIViewController <UIScrollViewDelegate>

//@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

- (void)loadVisiblePages;
- (void)loadPage:(NSInteger)page;
- (void)purgePage:(NSInteger)page;
- (void) unlock;
@end
