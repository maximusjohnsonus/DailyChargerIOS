//
//  EditDay.m
//  AA Schedule
//

#import "EditDay.h"
#import "StringLibrary.h"
#import "Period.h"
#import "EditPeriod.h"
#import "CustomMethods.h"
#import "UIColor+Custom.h"
#import "IntegerLibrary.h"
#import <UIKit/UIKit.h>

static NSMutableArray *scheduleArray;

@interface EditDay()
@property (nonatomic) NSInteger totalMinutesInDay;
@property (nonatomic) CGFloat height;
@property (strong, nonatomic) UITableView *myTableView;

- (NSInteger) getMinInDay;
@end

@implementation EditDay
- (id)initWithIndex:(NSInteger)index height:(CGFloat)height parent:(EditSchedule *)mama{
    self = [super init];
    if(self){
        _index = index; //-1=edit blocks, 0=day 1, 1=day 2, ...
        _height = height;
        self.mommy = mama;
        //_myDay = [scheduleArray objectAtIndex:index];
        
        // Set number of minutes in day for scaling the view
        self.totalMinutesInDay=[self getMinInDay];
    }
    
    return self;
}

- (NSInteger) getMinInDay{
    if(self.index != -1){ //don't load a day off
        NSInteger min = 0;
        for(NSMutableDictionary *period in scheduleArray[self.index]){
            min+=[period[kEnd] integerValue] - [period[kStart] integerValue];
        }
        return min;
    }
    else
        return 9;
}

+ (void) setSchedule:(NSMutableArray *)schedule{
    scheduleArray = [schedule mutableCopy];
}

- (void)updatePeriodAt:(NSIndexPath *)path to:(NSMutableDictionary *)data{
    NSInteger perIndex = path.row;
    NSMutableArray *day = scheduleArray[path.section];
    
    NSInteger newStart = [data[kStart] integerValue];
    NSInteger newEnd = [data[kEnd] integerValue];
    NSInteger oldStart = [day[perIndex][kStart] integerValue];
    NSInteger oldEnd = [day[perIndex][kEnd] integerValue];
    day[perIndex][kClassName] = data[kClassName];
    if(data[kRoom])
        day[perIndex][kRoom] = data[kRoom];
    //NSLog(@"6 %@ %@ %d %d", data[kStart], data[kEnd], oldStart, oldEnd);
    day[perIndex][kIsFree] = data[kIsFree];

    //NSLog(@"7");

    //NSLog(@"updating period");
    if(data[kColor]!=nil){
        //NSLog(@"setting color %@", data[kColor]);
        [day[perIndex] setObject:data[kColor] forKey:kColor];
    }
    
    //If start time is earlier than it was, delete all periods completely absorbed by new period, resize any partly covered (do not account for passing)
    if(newStart < oldStart){
        for(NSInteger i=perIndex-1; i>=0; i--){
            if([day[i][kStart] integerValue]>=newStart) {
                [day removeObjectAtIndex:i];
                perIndex--;
            } else if([day[i][kEnd] integerValue]>newStart){
                day[i][kEnd] = @(newStart);
            }
        }
        day[perIndex][kStart] = @(newStart);
    } else if (newStart > oldStart) {  //If start time is later than it was, fill gap with free
        NSMutableDictionary *fillerFree = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                           @"Free", kClassName,
                                           @(oldStart), kStart,
                                           @(newStart), kEnd,
                                           day[perIndex][kBlock], kBlock,
                                           @YES, kIsFree, nil];
        
        //new Period(oldStart(),newStart, r.getString(R.string.free_name), p.getBlock(), 2);
        [day insertObject:fillerFree atIndex:perIndex];
        //day.add(perIndex, fillerFree);
        perIndex++;
        day[perIndex][kStart] = @(newStart);
    }
    
    //If end time is later than it was, delete all periods completely absorbed by new period, resize any partly covered (do not account for passing)
    if(newEnd > oldEnd){
        for(NSInteger i=perIndex+1; i<[day count]; i++){
            if([day[i][kEnd] integerValue]<=newEnd) {
                [day removeObjectAtIndex:i];
                i--;
            } else if([day[i][kStart] integerValue]<newEnd){
                day[i][kStart] = @(newEnd);
            }
        }
        day[perIndex][kEnd] = @(newEnd);
    } else if (newEnd < oldEnd) {  //If end time is earlier than it was, fill gap with free
        NSMutableDictionary *fillerFree = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                           @"Free", kClassName,
                                           @(newEnd), kStart,
                                           @(oldEnd), kEnd,
                                           day[perIndex][kBlock], kBlock,
                                           @YES, kIsFree, nil];
        //Period fillerFree = new Period(newEnd, p.getEnd(), r.getString(R.string.free_name), p.getBlock(), 2);
        [day insertObject:fillerFree atIndex:perIndex+1];
        //day.add(perIndex+1, fillerFree);
        day[perIndex][kEnd] = @(newEnd);
    }
    
    //Delete all periods smaller than minimum
    for(int i=0; i<[day count]; i++){
        if([day[i][kEnd] integerValue] - [day[i][kStart] integerValue]<[CustomMethods minimumPeriodLength]){
            [day removeObjectAtIndex:i];
            i--;
        }
    }
    
    
    [CustomMethods saveSchedule:scheduleArray];
    self.totalMinutesInDay = [self getMinInDay];
        
    [self.mommy purgePage:self.index+1];
    [self.mommy loadPage:self.index+1];
    if(self.index==-1){
        [self.mommy purgePage:self.index+2];
        [self.mommy loadPage:self.index+2];
    }

    //[(UITableView *)self.view reloadData];
}

- (void)updateBlockAt:(NSInteger)index to:(NSMutableDictionary *)data{
    for(NSMutableArray *day in scheduleArray){
        for(NSMutableDictionary *period in day){
            if([period[kBlock] integerValue] == index){
                if(!(!data[kIsFree] && ![data[kFreeState] boolValue] && [period[kIsFree] boolValue])){ //the only case where R/CN isn't changed is where the free picker stayed on class and the updating period is free
                    if(data[kClassName])
                        period[kClassName] = data[kClassName];
                    if(data[kRoom])
                        period[kRoom] = data[kRoom];
                    if(data[kColor])
                        period[kColor] = data[kColor];
                } else {
                    if(data[kColor])
                        period[kColor] = [UIColor dictionaryFromColor:[UIColor paleColor:[UIColor colorFromDictionary:data[kColor]] withFactor:paleFactor]];
                }
                
                if(data[kIsFree]){ //if free state changed, set all to new state
                    period[kIsFree] = data[kIsFree];
                }
            }
        }
    }

    [CustomMethods saveSchedule:scheduleArray];
    
    [self.mommy purgePage:self.index+1];
    [self.mommy loadPage:self.index+1];
    if(self.index==-1){
        [self.mommy purgePage:self.index+2];
        [self.mommy loadPage:self.index+2];
    }
    
    //[(UITableView *)self.view reloadData];
}

- (void)viewDidLoad//loadView
{
    [super viewDidLoad];
    UITableView *tableView = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame] style:UITableViewStylePlain];
    tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.scrollEnabled = NO;
    tableView.userInteractionEnabled = YES;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView reloadData];
    
    self.view = tableView;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //NSLog(@"index: %ld", self.index);
    if(self.index != -1){
        //NSLog(@"count: %ld", [scheduleArray[self.index] count]);
        return [scheduleArray[self.index] count];
    }
    else //edit blocks
        return 9;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //NSLog(@"cell4rows 1");
    static NSString *periodTableIdentifier = @"PeriodTableCell";
    //NSLog(@"cell4rows 2");
    Period *cell = [tableView dequeueReusableCellWithIdentifier:periodTableIdentifier];
    //NSLog(@"cell4rows 3");
    if (cell == nil) {
        //NSLog(@"cell4rows 4");
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:periodTableIdentifier owner:self options:nil];
        cell = [nib objectAtIndex:0];
        //NSLog(@"cell4rows 5");
    }
    
    if(self.index != -1){
        //NSLog(@"cell4rows 6");
        //NSLog(@"day: %ld period: %ld", self.index, indexPath.row);
        [cell setPeriodData:scheduleArray[self.index][indexPath.row] index:[NSIndexPath indexPathForRow:indexPath.row inSection:self.index] dayIndex:-1 notes:nil];
        //NSLog(@"cell4rows 7");
    }else { //edit blocks
        //NSLog(@"cell4rows 8");
        NSMutableDictionary *block;
        for (NSMutableDictionary *period in scheduleArray[9]){
            if([period[kBlock] integerValue] == indexPath.row){
                block = [period mutableCopy];
                break;
            }
        }
        //NSLog(@"cell4rows 9");
        if(!block){
            for(NSMutableArray *day in scheduleArray){
                for (NSMutableDictionary *period in day){
                    if([period[kBlock] integerValue] == indexPath.row){
                        block = [period mutableCopy];
                        break;
                    }
                }
                if(block)
                    break;
            }
        }
        //NSLog(@"cell4rows 10");
        if(!block){
            block = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                     @"Null", kClassName,
                     @(indexPath.row), kBlock, nil];
        }
        //NSLog(@"cell4rows 11");
        if(indexPath.row == 8){
            block[kClassName] = @"Other";
            block[kIsFree] = @NO;
        }
        //NSLog(@"cell4rows 12");
        cell.isBlock = YES;
        [cell setPeriodData:block index:[NSIndexPath indexPathForRow:indexPath.row inSection:-1] dayIndex:-1 notes:nil];
    }
    //NSLog(@"cell4rows 13");
    cell.editor = self;
    //NSLog(@"cell4rows 14");

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"height 1");
    if(self.index != -1){
        NSMutableDictionary *period = scheduleArray[self.index][indexPath.row];
        //NSLog(@"height 2");
        return ([period[kEnd] integerValue] - [period[kStart] integerValue])*1.0/self.totalMinutesInDay*self.height;
    }
    else {
        //NSLog(@"height 3");
        return 1.0/self.totalMinutesInDay*self.height;
    }
}

//added for ios6
- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [cell setBackgroundColor:[CustomMethods getColor:((Period *)cell).periodData]];
}

#pragma mark - Touch Event

/*- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{ //TODO: make this work - less sketchy
    //[self performSegueWithIdentifier:@"mySegue" sender:self];
    //NSLog(@"touch!");
}*/



@end
