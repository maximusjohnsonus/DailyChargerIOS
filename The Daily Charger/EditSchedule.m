//
//  EditSchedule.m
//  ScrollViews
//

#import "EditSchedule.h"
#import "EditDay.h"
#import "SWRevealViewController.h"
#import "CustomMethods.h"
//#import "KeyDefinitions.h"
#import "GetSchedule.h"

NSInteger editCurPage=0;
NSInteger editOldPage=0;
const int editNumPages = 12;
BOOL editAllowScroll=YES;

@interface EditSchedule ()
@property (nonatomic, strong) NSMutableArray *controllers;

- (void) lockAndLoad;
@end

@implementation EditSchedule


#pragma mark -

- (void)loadVisiblePages {
    
    [self purgePage:editCurPage-2];
    for (NSInteger i=editCurPage-1; i<=editCurPage+1; i++) {
        [self loadPage:i];
    }
    [self purgePage:editCurPage+2];
    
    switch (editCurPage) {
        case 0:
            if (editAllowScroll)
                self.title = @"Edit Blocks";
            break;
        case 11:
            self.title = @"Make a new schedule";
            break;
        default:
            if (editAllowScroll)
                self.title = [NSString stringWithFormat:@"Edit Day %ld",(long)editCurPage%10];
            break;
    }
}

- (void)loadPage:(NSInteger)page{
    if (page < 0 || page >= editNumPages) {
        // If it's outside the range of what we have to display, then do nothing
        return;
    }
    
    // Load an individual page, first seeing if we've already loaded it
    UIViewController *pageViewController = [self.controllers objectAtIndex:page];
    UIViewController *newPageView;
    if ((NSNull*)pageViewController== [NSNull null]) {
        //NSLog(@"loading page %ld", page);
        CGRect frame = self.view.frame;
        frame.origin.x = frame.size.width * page;
        frame.origin.y = 0.0f;
        NSInteger padding = [[[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Constants" ofType:@"plist"]][@"Padding"] integerValue];
        if(page==11){
            newPageView = [[GetSchedule alloc] initWithEditParent:self];
            newPageView.view.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height);
        } else {
            NSInteger height;
            if(@available(iOS 11.0,*)){ // if we're on iPhone X, use safe areas instead
                height = self.view.safeAreaLayoutGuide.layoutFrame.size.height - 2*padding;
            } else {
                height = self.view.frame.size.height - [UIApplication sharedApplication].statusBarFrame.size.height - self.navigationController.navigationBar.frame.size.height - 2*padding;
            }
            newPageView = [[EditDay alloc] initWithIndex:page-1 height:height parent:self];


            //newPageView.view.contentMode = UIViewContentModeScaleAspectFit;
            newPageView.view.frame = CGRectMake(frame.origin.x + padding, frame.origin.y + padding, frame.size.width - 2*padding, frame.size.height - 2*padding);
        }
        [self.controllers replaceObjectAtIndex:page withObject:newPageView];
        [self.scrollView addSubview:newPageView.view];
    }
}

- (void)purgePage:(NSInteger)page {
    //NSLog(@"purging p %ld", page);
    if (page < 0 || page >= editNumPages) {
        // If it's outside the range of what we have to display, then do nothing
        return;
    }
    
    // Remove a page from the scroll view and reset the container array
    UIViewController *viewCont = [self.controllers objectAtIndex:page];
    if ((NSNull*)viewCont != [NSNull null]) {
        UIView *pageView = viewCont.view;
        [pageView removeFromSuperview];
        [self.controllers replaceObjectAtIndex:page withObject:[NSNull null]];
    }
}


#pragma mark -

- (void)viewDidLoad {
    //NSLog(@"edit viewdidload");
    [super viewDidLoad];
    
    self.title = @"Edit Schedule";
    editCurPage=0;
    editOldPage=0;
    
    // Set up the array to hold the views for each page
    self.controllers = [[NSMutableArray alloc] init]; //TODO: change from array to 3 variables?
    for (NSInteger i = 0; i < editNumPages; i++) {
        [self.controllers addObject:[NSNull null]];
    }
    
    
    
    NSMutableArray *schedule = [CustomMethods getSchedule];
    if(schedule==nil){
        [self lockAndLoad];
    } else {
        editAllowScroll = YES;
        [EditDay setSchedule:schedule];
        
        // Scroll to starting page
        [self.scrollView setContentOffset:CGPointMake(editCurPage * self.view.frame.size.width, 0)];
    }
    
    // Set up the content size of the scroll view
    CGSize pagesScrollViewSize = self.view.frame.size;
    self.scrollView.contentSize = CGSizeMake(pagesScrollViewSize.width * editNumPages, pagesScrollViewSize.height);
    
    //Set up side bar
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
}


- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self loadVisiblePages];
    //NSLog(@"edit layout subviews");
}

- (void) lockAndLoad{
    editAllowScroll = NO;
    editCurPage = 0;
    self.title = @"Make a new schedule";
    CGRect frame = self.view.frame;
    frame.origin.x = 0.0f;
    frame.origin.y = 0.0f;
    UIViewController *newPageView = [[GetSchedule alloc] initWithEditParent:self];
    //newPageView.view.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height);
    [self.controllers replaceObjectAtIndex:0 withObject:newPageView];
    [self.scrollView addSubview:newPageView.view];
}
- (void) unlock{
    editAllowScroll = YES;
    if([self.controllers objectAtIndex:0]!=[NSNull null]){
        if ([self.scrollView.subviews containsObject:((UIViewController *)[self.controllers objectAtIndex:0]).view]){
            [((UIViewController *)[self.controllers objectAtIndex:0]).view removeFromSuperview];
        }
    }
    [self.controllers replaceObjectAtIndex:0 withObject:[NSNull null]];
    editCurPage = 0;
    [self viewDidLoad];
    [self loadVisiblePages];
}

/*- (void)viewDidUnload {
    [super viewDidUnload];
    self.scrollView = nil;
    self.controllers = nil;
    self.sidebarButton = nil;
}*/

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


#pragma mark - UIScrollViewDelegate


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [scrollView setContentOffset:CGPointMake(editAllowScroll ? scrollView.contentOffset.x : 0, 0)]; // Disable vertical scroll
    
    CGFloat pageWidth = self.view.frame.size.width;
    if(pageWidth!=0){
        editCurPage = (NSInteger)floor( (self.scrollView.contentOffset.x * 2.0f + pageWidth) / (pageWidth * 2.0f) );
    }
        
    if(editCurPage!=editOldPage){
        [self loadVisiblePages];
        editOldPage=editCurPage;
    }
}



@end
