//
//  DayView.m
//  AA Schedule
//

#import "DayView.h"
#import "KeyDefinitions.h"
#import "Period.h"
#import "CustomMethods.h"

static NSMutableArray *scheduleArray;

@interface DayView()
@property (nonatomic) NSInteger totalMinutesInDay;
@property (nonatomic) CGFloat height;
@property (strong, nonatomic) NSMutableDictionary *notes;
@end

@implementation DayView
- (id)initWithIndex:(NSInteger)index dayIndex:(NSInteger)dayIndex height:(CGFloat)height parent:(ViewSchedule *)parent{
    self = [super init];
    if(self){
        _index = (index==-1) ? -1 : (index+9)%10;
        self.dayIndex = dayIndex;
        _height = height;
        self.daddy = parent;
        //_myDay = [scheduleArray objectAtIndex:(index+9)%10];
        
        // Set number of minutes in day for scaling the view
        self.totalMinutesInDay=0;
        if(self.index != -1){ //don't load a day off
            for(NSMutableDictionary *period in scheduleArray[self.index]){
                self.totalMinutesInDay+=[period[kEnd] integerValue] - [period[kStart] integerValue];
            }
        }
        
        self.notes = [CustomMethods getNotesForDay:self.dayIndex];
    }
    return self;
}

+ (void) setSchedule:(NSMutableArray *)schedule{
    scheduleArray = [schedule mutableCopy];
}


/*- (void)loadView
{
    [super loadView];
    if(self.index != -1){ //don't load a day off
        UITableView *tableView = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame] style:UITableViewStylePlain];
        tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.scrollEnabled = NO;
        //tableView.allowsSelection = NO;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.userInteractionEnabled = NO;
        [tableView reloadData];
        
        self.view = tableView;
    } //else weekend
}*/
- (void) viewDidLoad{
    [super viewDidLoad];
    //NSLog(@"size: %f",[[UIScreen mainScreen] applicationFrame].size.width);
    if(self.index != -1){ //don't load a day off
        UITableView *tableView = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame] style:UITableViewStylePlain];
        tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.scrollEnabled = NO;
        //tableView.allowsSelection = NO;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.userInteractionEnabled = YES;
        [tableView reloadData];
        
        self.view = tableView;
        //NSLog(@"view size: %f", self.view.frame.size.width);
    } //else weekend
}
- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if(self.index != -1)
        [(UITableView *)self.view reloadData];
}
- (void) refreshIndex:(NSIndexPath *)index withNewNote:(NSString *)note{
    NSMutableDictionary *notes = [CustomMethods getNotesForDay:self.dayIndex];
    if(notes==nil){
        notes = [[NSMutableDictionary alloc] init];
    }
    if(note==nil || [note isEqualToString:@""]){
        [notes removeObjectForKey:[NSString stringWithFormat:@"%ld",(long)index.row]]; //delete if note is empty
    } else
        [notes setObject:note forKey:[NSString stringWithFormat:@"%ld",(long)index.row]]; //else update note
    
    self.notes = notes; //now dayView has the same notes for today as customMethods, but they're independent
    //[(UITableView *)self.view reloadData];
    [(UITableView *)self.view reloadRowsAtIndexPaths:[NSArray arrayWithObjects:index, nil] withRowAnimation:UITableViewRowAnimationNone];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [scheduleArray[self.index] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *periodTableIdentifier = @"PeriodTableCell"; //Has to be name of .xib file
    Period *cell = [tableView dequeueReusableCellWithIdentifier:periodTableIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:periodTableIdentifier owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    //NSString *text = [[CustomMethods getNotesForDay:indexPath.section] valueForKey:[NSString stringWithFormat:@"%d",indexPath.row]];
    [cell setPeriodData:scheduleArray[self.index][indexPath.row] index:[NSIndexPath indexPathForRow:indexPath.row inSection:self.index] dayIndex:self.dayIndex notes:[self.notes valueForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.row]]];
     //[[CustomMethods getNotesForDay:self.dayIndex] valueForKey:[NSString stringWithFormat:@"%d",indexPath.row]]];
    
    /*PeriodData *period = [[PeriodData alloc] initWithDictionary:[self.myDay objectAtIndex:indexPath.row]];
     cell.ClassNameLabel.text = [period getMainText];
     cell.TimeLabel.text = [period getTimeText];
     cell.backgroundColor = [period getColor];*/
    cell.host = self;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableDictionary *period = scheduleArray[self.index][indexPath.row];
    return ([period[kEnd] integerValue] - [period[kStart] integerValue])*1.0/self.totalMinutesInDay*self.height;
}

//added for ios6
- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    //NSLog(@"%@",[CustomMethods getColor:((Period *)cell).periodData]);
    [cell setBackgroundColor:[CustomMethods getColor:((Period *)cell).periodData]];
}

//- (void)didReceiveMemoryWarning{}

@end
