//
//  ShowTextViewController.h
//  AA Schedule
//

#import <UIKit/UIKit.h>

@interface ShowTextViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (nonatomic) NSString *tag;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;


@end
