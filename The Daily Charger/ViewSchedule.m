//
//  ViewSchedule.m
//  ScrollViews
//

#import "ViewSchedule.h"
#import "DayView.h"
#import "SWRevealViewController.h"
#import "CustomMethods.h"
#import "IntegerLibrary.h"
#import "GetSchedule.h"
#import "StringLibrary.h"

NSInteger viewCurPage;
NSInteger viewOldPage=0;
const int viewNumPages = 275;
BOOL allowScroll = YES;

@interface ViewSchedule ()
@property (nonatomic, strong) NSMutableArray *controllers;
@property (nonatomic, strong) NSDate *firstDate;
@property (nonatomic, strong) NSDateFormatter *dateFormatter;

- (void)loadVisiblePages;
- (void)showVisiblePages;
//- (void)loadPage:(NSInteger)page;
//- (void)showPage:(NSInteger)page;
//- (void)purgePage:(NSInteger)page;
- (NSDate *)getDateForPage:(NSInteger) page;
- (NSInteger)getAdjustedIndex:(NSInteger)index;
- (NSInteger)getDeadjustedIndex:(NSInteger)index;
- (void) lockAndLoad;

@end

@implementation ViewSchedule


#pragma mark -

- (void)loadVisiblePages {
    [self purgePage:viewCurPage-2];
    
    for (NSInteger i=viewCurPage-1; i<=viewCurPage+1; i++) {
        [self loadPage:i];
    }
    
    [self purgePage:viewCurPage+2];
    
    NSInteger adjustedCurPage = [self getAdjustedIndex:viewCurPage];

    NSInteger cycleDay = [CustomMethods getCycleDayForIndex:adjustedCurPage];
    NSString *dayString = (cycleDay>=0 ? [NSString stringWithFormat:@", Day %ld",(long)cycleDay] : @", No School");
    if(allowScroll)
        self.title = [NSString stringWithFormat:@"%@%@",[self.dateFormatter stringFromDate:[self getDateForPage:adjustedCurPage]], dayString];

}
- (void)showVisiblePages {
    for (NSInteger i=viewCurPage-1; i<=viewCurPage+1; i++) {
        [self showPage:i];
    }
}

- (void)loadPage:(NSInteger)page
{
    NSInteger adjustedPage = [self getAdjustedIndex:page];
    if (page < 0 || adjustedPage >= viewNumPages) {
        // If it's outside the range of what we have to display, then do nothing
        return;
    }

    // Load an individual page, first seeing if we've already loaded it
    UIViewController *pageViewController = [self.controllers objectAtIndex:page];
    
    if ((NSNull*)pageViewController== [NSNull null]) {
        CGRect frame = self.view.frame; //was bounds
        frame.origin.x = frame.size.width * page;
        frame.origin.y = 0.0f;
        UIViewController *newPageView;
        if (floor(NSFoundationVersionNumber) > NSFoundationVersionNumber_iOS_6_1) {
            newPageView = [[DayView alloc] initWithIndex:[CustomMethods getCycleDayForIndex:[self getAdjustedIndex:page]] dayIndex:page height:self.view.frame.size.height - [UIApplication sharedApplication].statusBarFrame.size.height - self.navigationController.navigationBar.frame.size.height - 2*padding parent:self];
        } else {
            newPageView = [[DayView alloc] initWithIndex:[CustomMethods getCycleDayForIndex:[self getAdjustedIndex:page]] dayIndex:page height:self.view.frame.size.height - 2*padding parent:self];
        }
        //newPageView.view.contentMode = UIViewContentModeScaleAspectFit;
        newPageView.view.frame = CGRectMake(frame.origin.x + padding, frame.origin.y +padding, frame.size.width - 2*padding, frame.size.height - 2*padding);
        [self.controllers replaceObjectAtIndex:page withObject:newPageView];        
        [self.scrollView addSubview:newPageView.view];
    }
}
- (void)showPage:(NSInteger)page{
    UIViewController *newPageView = [self.controllers objectAtIndex:page];
    if(newPageView)
        [self.scrollView addSubview:newPageView.view];
}

- (void)purgePage:(NSInteger)page {
    if (page < 0 || page >= viewNumPages) {
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
- (void)loadView{
    [super loadView];
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    //if([[[def dictionaryRepresentation] allKeys] containsObject:KEY_NOTES]){
    //[def removeObjectForKey:KEY_NOTES];
    if ([def objectForKey:KEY_NOTES]==nil){ //if notes are new for them
        [def setBool:YES forKey:KEY_NOTES];
        [def synchronize];
        
        UIAlertView *notesAlert=[[UIAlertView alloc]initWithTitle:@"We've added Notes" message:@"Tap on a period! Read more in Help." delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
        [notesAlert show];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"View Schedule";
    
    self.dateFormatter = [[NSDateFormatter alloc] init];
    [self.dateFormatter setDateFormat:@"EEEE, M/d"]; //TODO: allow customizability of this (advanced)

    NSDateComponents *firstDayComp = [[NSDateComponents alloc] init];
    [firstDayComp setDay:intStartDay];
    [firstDayComp setMonth:intStartMonth];
    [firstDayComp setYear:intStartYear];
    self.firstDate = [[NSCalendar currentCalendar] dateFromComponents:firstDayComp];
    NSDateComponents *daysBetween = [[[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian] components:NSCalendarUnitDay
                                                                                                                     fromDate:self.firstDate
                                                                                                                       toDate:[NSDate date]
                                                                                                                      options:0 ];
    
    //Make sure nothing loads until viewDidAppear (it works)
    viewCurPage = [self getDeadjustedIndex:[daysBetween day]];
    viewOldPage = viewCurPage;
    //[self loadVisiblePages];
    
    // Scroll to starting page
    [self.scrollView setContentOffset:CGPointMake(viewCurPage * self.view.frame.size.width, 0)];
    
    //Set up side bar
    SWRevealViewController *revealViewController = self.revealViewController;
    if ( revealViewController )
    {
        [self.sidebarButton setTarget: self.revealViewController];
        [self.sidebarButton setAction: @selector( revealToggle: )];
        [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Set up the array to hold the views for each page
    self.controllers = [[NSMutableArray alloc] init]; //TODO: change from array to 3 variables?
    for (NSInteger i = 0; i < viewNumPages; i++) {
        [self.controllers addObject:[NSNull null]];
    }
    
    // Set up the content size of the scroll view
    CGSize pagesScrollViewSize = self.view.frame.size;
    self.scrollView.contentSize = CGSizeMake(pagesScrollViewSize.width * viewNumPages, pagesScrollViewSize.height);

    NSMutableArray *schedule = [CustomMethods getSchedule];
    if(schedule==nil){
        [self lockAndLoad];
    } else {
        allowScroll = YES;
        [DayView setSchedule: schedule];
    }

}
- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    if(allowScroll)
        [self loadVisiblePages];
}


- (void) lockAndLoad{
    allowScroll = NO;
    viewCurPage = 0;
    self.title = @"Make a new schedule";
    CGRect frame = self.view.frame; //TODO: make this a modal view
    frame.origin.x = 0.0f;
    frame.origin.y = 0.0f;
    UIViewController *newPageView = [[GetSchedule alloc] initWithViewParent:self];
    //newPageView.view.frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height);
    [self.controllers replaceObjectAtIndex:0 withObject:newPageView];
    [self.scrollView addSubview:newPageView.view];
}
- (void) unlock{
    allowScroll = YES;
    if([self.controllers objectAtIndex:0]!=[NSNull null]){
        if ([self.scrollView.subviews containsObject: ((UIViewController *)[self.controllers objectAtIndex:0]).view]){
            [((UIViewController *)[self.controllers objectAtIndex:0]).view removeFromSuperview];
        }
    }
    [self.controllers replaceObjectAtIndex:0 withObject:[NSNull null]];
    [self viewWillAppear:YES];
    [self loadVisiblePages];

}

/*- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.scrollView = nil;
    self.controllers = nil;
    self.sidebarButton = nil;
    self.firstDate = nil;
    self.dateFormatter = nil;
}*/



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [scrollView setContentOffset: CGPointMake(allowScroll ? scrollView.contentOffset.x : 0, 0)]; // Disable vertical scroll
    
    CGFloat pageWidth = self.view.frame.size.width;
    if(pageWidth!=0){
        viewCurPage = (NSInteger)floor( (self.scrollView.contentOffset.x * 2.0f + pageWidth) / (pageWidth * 2.0f) );
    }
    
    //viewCurPage = [self getAdjustedIndex:viewCurPage];
   
    if(viewCurPage!=viewOldPage){
        [self loadVisiblePages];
        //[self showVisiblePages];
        viewOldPage=viewCurPage;
    }
}

#pragma mark -

- (NSDate *)getDateForPage:(NSInteger) page{
    NSDateComponents *daysToAdd = [[NSDateComponents alloc] init];
    [daysToAdd setDay:page];
    return [[[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian] dateByAddingComponents:daysToAdd toDate:self.firstDate options:0];
}

- (NSInteger)getAdjustedIndex:(NSInteger)index{ //TODO: replace with math instead of for loop
    if([CustomMethods showWeekends])
        return index;
    int realIndex=0;
    int i=0;
    NSCalendar *cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *tempDate = [self.firstDate copy];
    NSDateComponents *oneDay = [[NSDateComponents alloc] init];
    [oneDay setDay:1];
    NSInteger weekday;
    while (i<index){
        realIndex++;
        tempDate = [cal dateByAddingComponents:oneDay toDate:tempDate options:0];
        weekday = [[cal components:NSCalendarUnitWeekday fromDate:tempDate] weekday];
        if(weekday!=1 && weekday!=7)
            i++;
    }

    return realIndex;
    
}
- (NSInteger)getDeadjustedIndex:(NSInteger)index{ //TODO: replace with math instead of for loop

    if([CustomMethods showWeekends])
        return index;
    int realIndex=0;
    
    NSCalendar *cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *tempDate = [self.firstDate copy];
    NSDateComponents *oneDay = [[NSDateComponents alloc] init];
    [oneDay setDay:1];
    NSInteger weekday;
    for(int i=0; i<index; i++){
        weekday = [[cal components:NSCalendarUnitWeekday fromDate:tempDate] weekday];
        if(weekday!=1 && weekday!=7){
            realIndex++;
        }
        tempDate = [cal dateByAddingComponents:oneDay toDate:tempDate options:0];
    }
    return realIndex;
    
}


@end
