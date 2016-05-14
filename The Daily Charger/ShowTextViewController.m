//
//  ShowTextViewController.m
//  AA Schedule
//

#import "ShowTextViewController.h"
#import "SWRevealViewController.h"
#import "StringLibrary.h"

@interface ShowTextViewController()
- (NSString *)getTextWithTag:(int)tag;
- (NSString *)getTitleWithTag:(int)tag;
@end

@implementation ShowTextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    int tagInt=-1;
    if([self.tag isEqualToString:@"help"])
        tagInt = 0;
    if([self.tag isEqualToString:@"about"])
        tagInt = 1;
    if([self.tag isEqualToString:@"feedback"])
        tagInt = 2;
    
    self.textView.text = [self getTextWithTag:tagInt];

    self.title = [self getTitleWithTag:tagInt];
    
    //Set up side bar
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
}

- (NSString *)getTitleWithTag:(int)tag{
    switch (tag) {
        case 0: // Help
            return @"Help";
            break;
        case 1: // About
            return @"About";
            break;
        case 2: // Feedback (temporary - TODO: remove)
            return @"Feedback";
            break;
        default:
            return @"Default";
            break;
    }
}

- (NSString *)getTextWithTag:(int)tag{
    switch (tag) {
        case 0: // Help
            return helpText;
            break;
        case 1: // About
            return aboutText;
            break;
        case 2: // Feedback (temporary - TODO: remove)
            if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1)
                return feedbackText;
            return feedbackText;
            break;
        default:
            return @"Error: Text failed to load";
            break;
    }
}

@end
