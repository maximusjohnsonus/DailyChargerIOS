//
//  GetSchedule.m
//  AA Schedule
//

#import "GetSchedule.h"
#import "CustomMethods.h"
#import "KeyDefinitions.h"

@interface GetSchedule ()
@property ViewSchedule *viewParent;
@property EditSchedule *editParent;
@end

@implementation GetSchedule

- (id)initWithViewParent:(ViewSchedule *)daddy{ //shut up this works
    self = [super init];
    if (self){
        self.viewParent = daddy;
    }
    return self;
}
- (id)initWithEditParent:(EditSchedule *)daddy{ //if you want to do it better by all means go ahead
    self = [super init];
    if (self){
        self.editParent = daddy;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Make a new schedule";
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    [def setBool:YES forKey:KEY_RET];
    [def synchronize];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


- (IBAction)use1012Tapped:(id)sender{
    NSMutableDictionary *AShort = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"A", kClassName,
                                   @480, kStart,
                                   @527, kEnd,
                                   @0, kBlock,
                                   @NO, kIsFree, nil];
    NSMutableDictionary *ALong = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  @"A", kClassName,
                                  @480, kStart,
                                  @554, kEnd,
                                  @0, kBlock,
                                  @NO, kIsFree, nil];
    
    NSMutableDictionary *BShort = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"B", kClassName,
                                   @534, kStart,
                                   @581, kEnd,
                                   @1, kBlock,
                                   @NO, kIsFree, nil];
    NSMutableDictionary *BLong1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"B", kClassName,
                                   @480, kStart,
                                   @554, kEnd,
                                   @1, kBlock,
                                   @NO, kIsFree, nil];
    NSMutableDictionary *BLong2 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"B", kClassName,
                                   @561, kStart,
                                   @635, kEnd,
                                   @1, kBlock,
                                   @NO, kIsFree, nil];
    
    NSMutableDictionary *CShort = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"C", kClassName,
                                   @588, kStart,
                                   @635, kEnd,
                                   @2, kBlock,
                                   @NO, kIsFree, nil];
    NSMutableDictionary *CLong = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  @"C", kClassName,
                                  @561, kStart,
                                  @635, kEnd,
                                  @2, kBlock,
                                  @NO, kIsFree, nil];
    
    //These are all the left ones
    NSMutableDictionary *DShort1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                    @"D", kClassName,
                                    @642, kStart,
                                    @689, kEnd,
                                    @3, kBlock,
                                    @NO, kIsFree, nil];
    NSMutableDictionary *DShort2 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                    @"D", kClassName,
                                    @682, kStart,
                                    @729, kEnd,
                                    @3, kBlock,
                                    @NO, kIsFree, nil];
    NSMutableDictionary *DLong1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  @"D", kClassName,
                                  @642, kStart,
                                  @716, kEnd,
                                  @3, kBlock,
                                  @NO, kIsFree, nil];
    NSMutableDictionary *DLong2 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"D", kClassName,
                                   @682, kStart,
                                   @756, kEnd,
                                   @3, kBlock,
                                   @NO, kIsFree, nil];
    
    NSMutableDictionary *EShort1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                    @"E", kClassName,
                                    @750, kStart,
                                    @797, kEnd,
                                    @4, kBlock,
                                    @NO, kIsFree, nil];
    NSMutableDictionary *EShort2 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                    @"E", kClassName,
                                    @777, kStart,
                                    @824, kEnd,
                                    @4, kBlock,
                                    @NO, kIsFree, nil];
    NSMutableDictionary *ELong1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"E", kClassName,
                                   @750, kStart,
                                   @824, kEnd,
                                   @4, kBlock,
                                   @NO, kIsFree, nil];
    NSMutableDictionary *ELong2 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"E", kClassName,
                                   @777, kStart,
                                   @851, kEnd,
                                   @4, kBlock,
                                   @NO, kIsFree, nil];
    
    NSMutableDictionary *FShort1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                    @"F", kClassName,
                                    @804, kStart,
                                    @851, kEnd,
                                    @5, kBlock,
                                    @NO, kIsFree, nil];
    NSMutableDictionary *FShort2 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                    @"F", kClassName,
                                    @831, kStart,
                                    @878, kEnd,
                                    @5, kBlock,
                                    @NO, kIsFree, nil];
    NSMutableDictionary *FLong = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  @"F", kClassName,
                                  @804, kStart,
                                  @878, kEnd,
                                  @5, kBlock,
                                  @NO, kIsFree, nil];
    
    NSMutableDictionary *GShort = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"G", kClassName,
                                   @885, kStart,
                                   @932, kEnd,
                                   @6, kBlock,
                                   @NO, kIsFree, nil];
    NSMutableDictionary *GLong = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  @"G", kClassName,
                                  @858, kStart,
                                  @932, kEnd,
                                  @6, kBlock,
                                  @NO, kIsFree, nil];
    
    NSMutableDictionary *Lunch1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"Lunch", kClassName,
                                   @736, kStart,
                                   @770, kEnd,
                                   @7, kBlock,
                                   @NO, kIsFree, nil];
    NSMutableDictionary *Lunch2 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"Lunch", kClassName,
                                   @696, kStart,
                                   @743, kEnd,
                                   @7, kBlock,
                                   @NO, kIsFree, nil];
    NSMutableDictionary *Lunch3 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"Lunch", kClassName,
                                   @763, kStart,
                                   @797, kEnd,
                                   @7, kBlock,
                                   @NO, kIsFree, nil];
    NSMutableDictionary *Lunch4 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"Lunch", kClassName,
                                   @696, kStart,
                                   @770, kEnd,
                                   @7, kBlock,
                                   @NO, kIsFree, nil];
    NSMutableDictionary *Lunch5 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"Lunch", kClassName,
                                   @706, kStart,
                                   @743, kEnd,
                                   @7, kBlock,
                                   @NO, kIsFree, nil];
    NSMutableDictionary *Lunch8 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"Lunch", kClassName,
                                   @723, kStart,
                                   @770, kEnd,
                                   @7, kBlock,
                                   @NO, kIsFree, nil];
    
    NSMutableDictionary *Break = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  @"Break", kClassName,
                                  @635, kStart,
                                  @652, kEnd,
                                  @8, kBlock,
                                  @YES, kIsFree, nil];
    NSMutableDictionary *Advisor = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                    @"Advisor Time", kClassName,
                                    @642, kStart,
                                    @675, kEnd,
                                    @8, kBlock,
                                    @NO, kIsFree, nil];
    NSMutableDictionary *DivAss = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"Assembly/Class Meeting", kClassName,
                                   @645, kStart,
                                   @675, kEnd,
                                   @8, kBlock,
                                   @NO, kIsFree, nil];
    NSMutableDictionary *Club = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                 @"Club", kClassName,
                                 @642, kStart,
                                 @675, kEnd,
                                 @8, kBlock,
                                 @NO, kIsFree, nil];
    NSMutableDictionary *CommonTime = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       @"Common Time", kClassName,
                                       @885, kStart,
                                       @932, kEnd,
                                       @8, kBlock,
                                       @NO, kIsFree, nil];
    NSMutableDictionary *Other = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  @"Other", kClassName,
                                  @652, kStart,
                                  @699, kEnd,
                                  @8, kBlock,
                                  @NO, kIsFree, nil];
    [CustomMethods saveSchedule:
     [NSMutableArray arrayWithObjects:
     [NSMutableArray arrayWithObjects: [ALong mutableCopy],  [BLong2 mutableCopy],  [Club mutableCopy],  [DShort2 mutableCopy],  [Lunch1 mutableCopy],  [EShort2 mutableCopy],  [FShort2 mutableCopy],  [GShort mutableCopy], nil],
     [NSMutableArray arrayWithObjects: [AShort mutableCopy],  [BShort mutableCopy],  [CShort mutableCopy],  [DShort1 mutableCopy],  [Lunch2 mutableCopy],  [EShort1 mutableCopy],  [FLong mutableCopy],  [GShort mutableCopy], nil],
     [NSMutableArray arrayWithObjects: [AShort mutableCopy],  [BShort mutableCopy],  [CShort mutableCopy],  [DivAss mutableCopy],  [DLong2 mutableCopy],  [Lunch3 mutableCopy],  [FShort1 mutableCopy],  [GLong mutableCopy], nil],
     [NSMutableArray arrayWithObjects: [ALong mutableCopy],  [CLong mutableCopy],  [DShort1 mutableCopy],  [Lunch4 mutableCopy],  [EShort2 mutableCopy],  [FShort2 mutableCopy],  [GShort mutableCopy], nil],
     [NSMutableArray arrayWithObjects: [AShort mutableCopy],  [BShort mutableCopy],  [CShort mutableCopy],  [Break mutableCopy],  [Other mutableCopy],  [Lunch5 mutableCopy],  [ELong1 mutableCopy],  [FShort2 mutableCopy],  [GShort mutableCopy], nil],
     [NSMutableArray arrayWithObjects: [AShort mutableCopy],  [BShort mutableCopy],  [CShort mutableCopy],  [DShort1 mutableCopy],  [Lunch2 mutableCopy],  [EShort1 mutableCopy],  [FLong mutableCopy],  [CommonTime mutableCopy], nil],
     [NSMutableArray arrayWithObjects: [BLong1 mutableCopy],  [CLong mutableCopy],  [Club mutableCopy],  [DShort2 mutableCopy],  [Lunch1 mutableCopy],  [EShort2 mutableCopy],  [FShort2 mutableCopy],  [GShort mutableCopy], nil],
     [NSMutableArray arrayWithObjects: [AShort mutableCopy],  [BShort mutableCopy],  [CShort mutableCopy],  [DLong1 mutableCopy],  [Lunch8 mutableCopy],  [EShort2 mutableCopy],  [FShort2 mutableCopy],  [GShort mutableCopy], nil],
     [NSMutableArray arrayWithObjects: [AShort mutableCopy],  [BShort mutableCopy],  [CShort mutableCopy],  [Advisor mutableCopy],  [DShort2 mutableCopy],  [Lunch1 mutableCopy],  [ELong2 mutableCopy],  [GLong mutableCopy], nil],
     [NSMutableArray arrayWithObjects: [AShort mutableCopy],  [BShort mutableCopy],  [CShort mutableCopy],  [DShort1 mutableCopy],  [Lunch4 mutableCopy],  [EShort2 mutableCopy],  [FShort2 mutableCopy],  [GShort mutableCopy], nil], nil]];
    
    [CustomMethods deleteNotes];
    

    if(self.viewParent)
        [self.viewParent unlock];
    else if(self.editParent)
        [self.editParent unlock];
    //NSLog(@"!!!!! ERRRRRRRORROROROROR neither view nor edit were set!!!!!!!*******");
}
- (IBAction)use1012OffsetTapped:(id)sender{
    NSMutableDictionary *AShort = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"A", kClassName,
                                   @480, kStart,
                                   @527, kEnd,
                                   @0, kBlock,
                                   @NO, kIsFree, nil];
    NSMutableDictionary *ALong = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  @"A", kClassName,
                                  @480, kStart,
                                  @554, kEnd,
                                  @0, kBlock,
                                  @NO, kIsFree, nil];
    
    NSMutableDictionary *BShort = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"B", kClassName,
                                   @534, kStart,
                                   @581, kEnd,
                                   @1, kBlock,
                                   @NO, kIsFree, nil];
    NSMutableDictionary *BLong1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"B", kClassName,
                                   @480, kStart,
                                   @554, kEnd,
                                   @1, kBlock,
                                   @NO, kIsFree, nil];
    NSMutableDictionary *BLong2 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"B", kClassName,
                                   @561, kStart,
                                   @635, kEnd,
                                   @1, kBlock,
                                   @NO, kIsFree, nil];
    
    NSMutableDictionary *CShort = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"C", kClassName,
                                   @588, kStart,
                                   @635, kEnd,
                                   @2, kBlock,
                                   @NO, kIsFree, nil];
    NSMutableDictionary *CLong = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  @"C", kClassName,
                                  @561, kStart,
                                  @635, kEnd,
                                  @2, kBlock,
                                  @NO, kIsFree, nil];
    
    //These are all the right ones
    NSMutableDictionary *DShort1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                    @"D", kClassName,
                                    @652, kStart,
                                    @699, kEnd,
                                    @3, kBlock,
                                    @NO, kIsFree, nil];
    NSMutableDictionary *DShort2 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                    @"D", kClassName,
                                    @723, kStart,
                                    @770, kEnd,
                                    @3, kBlock,
                                    @NO, kIsFree, nil];
    NSMutableDictionary *DShort0 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                    @"D", kClassName,
                                    @642, kStart,
                                    @689, kEnd,
                                    @3, kBlock,
                                    @NO, kIsFree, nil];
    NSMutableDictionary *DLong1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"D", kClassName,
                                   @652, kStart,
                                   @726, kEnd,
                                   @3, kBlock,
                                   @NO, kIsFree, nil];
    NSMutableDictionary *DLong2 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"D", kClassName,
                                   @723, kStart,
                                   @797, kEnd,
                                   @3, kBlock,
                                   @NO, kIsFree, nil];
    
    NSMutableDictionary *EShort1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                    @"E", kClassName,
                                    @750, kStart,
                                    @797, kEnd,
                                    @4, kBlock,
                                    @NO, kIsFree, nil];
    NSMutableDictionary *EShort2 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                    @"E", kClassName,
                                    @777, kStart,
                                    @824, kEnd,
                                    @4, kBlock,
                                    @NO, kIsFree, nil];
    NSMutableDictionary *ELong1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"E", kClassName,
                                   @750, kStart,
                                   @824, kEnd,
                                   @4, kBlock,
                                   @NO, kIsFree, nil];
    NSMutableDictionary *ELong2 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"E", kClassName,
                                   @777, kStart,
                                   @851, kEnd,
                                   @4, kBlock,
                                   @NO, kIsFree, nil];
    
    NSMutableDictionary *FShort1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                    @"F", kClassName,
                                    @804, kStart,
                                    @851, kEnd,
                                    @5, kBlock,
                                    @NO, kIsFree, nil];
    NSMutableDictionary *FShort2 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                    @"F", kClassName,
                                    @831, kStart,
                                    @878, kEnd,
                                    @5, kBlock,
                                    @NO, kIsFree, nil];
    NSMutableDictionary *FLong = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  @"F", kClassName,
                                  @804, kStart,
                                  @878, kEnd,
                                  @5, kBlock,
                                  @NO, kIsFree, nil];
    
    NSMutableDictionary *GShort = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"G", kClassName,
                                   @885, kStart,
                                   @932, kEnd,
                                   @6, kBlock,
                                   @NO, kIsFree, nil];
    NSMutableDictionary *GLong = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  @"G", kClassName,
                                  @858, kStart,
                                  @932, kEnd,
                                  @6, kBlock,
                                  @NO, kIsFree, nil];
    
    NSMutableDictionary *Lunch1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"Lunch", kClassName,
                                   @682, kStart,
                                   @716, kEnd,
                                   @7, kBlock,
                                   @NO, kIsFree, nil];
    NSMutableDictionary *Lunch2 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"Lunch", kClassName,
                                   @706, kStart,
                                   @743, kEnd,
                                   @7, kBlock,
                                   @NO, kIsFree, nil];
    NSMutableDictionary *Lunch4 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"Lunch", kClassName,
                                   @706, kStart,
                                   @770, kEnd,
                                   @7, kBlock,
                                   @NO, kIsFree, nil];
    NSMutableDictionary *Lunch8 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"Lunch", kClassName,
                                   @733, kStart,
                                   @770, kEnd,
                                   @7, kBlock,
                                   @NO, kIsFree, nil];
    NSMutableDictionary *Lunch0 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"Lunch", kClassName,
                                   @696, kStart,
                                   @770, kEnd,
                                   @7, kBlock,
                                   @NO, kIsFree, nil];
    
    NSMutableDictionary *Break = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  @"Break", kClassName,
                                  @635, kStart,
                                  @652, kEnd,
                                  @8, kBlock,
                                  @YES, kIsFree, nil];
    NSMutableDictionary *Advisor = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                    @"Advisor Time", kClassName,
                                    @642, kStart,
                                    @675, kEnd,
                                    @8, kBlock,
                                    @NO, kIsFree, nil];
    NSMutableDictionary *DivAss = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"Assembly/Class Meeting", kClassName,
                                   @645, kStart,
                                   @675, kEnd,
                                   @8, kBlock,
                                   @NO, kIsFree, nil];
    NSMutableDictionary *Club = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                 @"Club", kClassName,
                                 @642, kStart,
                                 @675, kEnd,
                                 @8, kBlock,
                                 @NO, kIsFree, nil];
    NSMutableDictionary *CommonTime = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       @"Common Time", kClassName,
                                       @885, kStart,
                                       @932, kEnd,
                                       @8, kBlock,
                                       @NO, kIsFree, nil];
    NSMutableDictionary *Other = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  @"Other", kClassName,
                                  @652, kStart,
                                  @699, kEnd,
                                  @8, kBlock,
                                  @NO, kIsFree, nil];
    [CustomMethods saveSchedule:
     [NSMutableArray arrayWithObjects:
      [NSMutableArray arrayWithObjects: [ALong mutableCopy],  [BLong2 mutableCopy],  [Club mutableCopy],  [Lunch1 mutableCopy],  [DShort2 mutableCopy],  [EShort2 mutableCopy],  [FShort2 mutableCopy],  [GShort mutableCopy], nil],
      [NSMutableArray arrayWithObjects: [AShort mutableCopy],  [BShort mutableCopy],  [CShort mutableCopy],  [Break mutableCopy],  [DShort1 mutableCopy],  [Lunch2 mutableCopy],  [EShort1 mutableCopy],  [FLong mutableCopy],  [GShort mutableCopy], nil],
      [NSMutableArray arrayWithObjects: [AShort mutableCopy],  [BShort mutableCopy],  [CShort mutableCopy],  [DivAss mutableCopy],  [Lunch1 mutableCopy],  [DLong2 mutableCopy],  [FShort1 mutableCopy],  [GLong mutableCopy], nil],
      [NSMutableArray arrayWithObjects: [ALong mutableCopy],  [CLong mutableCopy],  [Break mutableCopy],  [DShort1 mutableCopy],  [Lunch4 mutableCopy],  [EShort2 mutableCopy],  [FShort2 mutableCopy],  [GShort mutableCopy], nil],
      [NSMutableArray arrayWithObjects: [AShort mutableCopy],  [BShort mutableCopy],  [CShort mutableCopy],  [Break mutableCopy],  [Other mutableCopy],  [Lunch2 mutableCopy],  [ELong1 mutableCopy],  [FShort2 mutableCopy],  [GShort mutableCopy], nil],
      [NSMutableArray arrayWithObjects: [AShort mutableCopy],  [BShort mutableCopy],  [CShort mutableCopy],  [Break mutableCopy],  [DShort1 mutableCopy],  [Lunch2 mutableCopy],  [EShort1 mutableCopy],  [FLong mutableCopy],  [CommonTime mutableCopy], nil],
      [NSMutableArray arrayWithObjects: [BLong1 mutableCopy],  [CLong mutableCopy],  [Club mutableCopy],  [Lunch1 mutableCopy],  [DShort2 mutableCopy],  [EShort2 mutableCopy],  [FShort2 mutableCopy],  [GShort mutableCopy], nil],
      [NSMutableArray arrayWithObjects: [AShort mutableCopy],  [BShort mutableCopy],  [CShort mutableCopy],  [Break mutableCopy],  [DLong1 mutableCopy],  [Lunch8 mutableCopy],  [EShort2 mutableCopy],  [FShort2 mutableCopy],  [GShort mutableCopy], nil],
      [NSMutableArray arrayWithObjects: [AShort mutableCopy],  [BShort mutableCopy],  [CShort mutableCopy],  [Advisor mutableCopy],  [Lunch1 mutableCopy],  [DShort2 mutableCopy],  [ELong2 mutableCopy],  [GLong mutableCopy], nil],
      [NSMutableArray arrayWithObjects: [AShort mutableCopy],  [BShort mutableCopy],  [CShort mutableCopy],  [DShort0 mutableCopy],  [Lunch0 mutableCopy],  [EShort2 mutableCopy],  [FShort2 mutableCopy],  [GShort mutableCopy], nil], nil]];
    
    [CustomMethods deleteNotes];
    
    if(self.viewParent)
        [self.viewParent unlock];
    else if(self.editParent)
        [self.editParent unlock];
    //NSLog(@"!!!!! ERRRRRRRORROROROROR neither view nor edit were set!!!!!!!*******");
}
- (IBAction)use89Tapped:(id)sender{
    NSMutableDictionary *AShort = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"A", kClassName,
                                   @480, kStart,
                                   @527, kEnd,
                                   @0, kBlock,
                                   @NO, kIsFree, nil];
    NSMutableDictionary *ALong = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  @"A", kClassName,
                                  @480, kStart,
                                  @554, kEnd,
                                  @0, kBlock,
                                  @NO, kIsFree, nil];
    
    NSMutableDictionary *BShort = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"B", kClassName,
                                   @534, kStart,
                                   @581, kEnd,
                                   @1, kBlock,
                                   @NO, kIsFree, nil];
    NSMutableDictionary *BLong1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"B", kClassName,
                                   @480, kStart,
                                   @554, kEnd,
                                   @1, kBlock,
                                   @NO, kIsFree, nil];
    NSMutableDictionary *BLong2 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"B", kClassName,
                                   @561, kStart,
                                   @635, kEnd,
                                   @1, kBlock,
                                   @NO, kIsFree, nil];
    
    NSMutableDictionary *CShort = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"C", kClassName,
                                   @588, kStart,
                                   @635, kEnd,
                                   @2, kBlock,
                                   @NO, kIsFree, nil];
    NSMutableDictionary *CLong = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  @"C", kClassName,
                                  @561, kStart,
                                  @635, kEnd,
                                  @2, kBlock,
                                  @NO, kIsFree, nil];
    
    NSMutableDictionary *DShort1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                    @"D", kClassName,
                                    @696, kStart,
                                    @743, kEnd,
                                    @3, kBlock,
                                    @NO, kIsFree, nil];
    NSMutableDictionary *DShort2 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                    @"D", kClassName,
                                    @723, kStart,
                                    @770, kEnd,
                                    @3, kBlock,
                                    @NO, kIsFree, nil];
    NSMutableDictionary *DLong1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"D", kClassName,
                                   @696, kStart,
                                   @770, kEnd,
                                   @3, kBlock,
                                   @NO, kIsFree, nil];
    NSMutableDictionary *DLong2 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"D", kClassName,
                                   @723, kStart,
                                   @797, kEnd,
                                   @3, kBlock,
                                   @NO, kIsFree, nil];
    
    NSMutableDictionary *EShort1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                    @"E", kClassName,
                                    @750, kStart,
                                    @797, kEnd,
                                    @4, kBlock,
                                    @NO, kIsFree, nil];
    NSMutableDictionary *EShort2 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                    @"E", kClassName,
                                    @777, kStart,
                                    @824, kEnd,
                                    @4, kBlock,
                                    @NO, kIsFree, nil];
    NSMutableDictionary *ELong1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"E", kClassName,
                                   @750, kStart,
                                   @824, kEnd,
                                   @4, kBlock,
                                   @NO, kIsFree, nil];
    NSMutableDictionary *ELong2 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"E", kClassName,
                                   @777, kStart,
                                   @851, kEnd,
                                   @4, kBlock,
                                   @NO, kIsFree, nil];
    
    NSMutableDictionary *FShort1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                    @"F", kClassName,
                                    @804, kStart,
                                    @851, kEnd,
                                    @5, kBlock,
                                    @NO, kIsFree, nil];
    NSMutableDictionary *FShort2 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                    @"F", kClassName,
                                    @831, kStart,
                                    @878, kEnd,
                                    @5, kBlock,
                                    @NO, kIsFree, nil];
    NSMutableDictionary *FLong = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  @"F", kClassName,
                                  @804, kStart,
                                  @878, kEnd,
                                  @5, kBlock,
                                  @NO, kIsFree, nil];
    
    NSMutableDictionary *GShort = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"G", kClassName,
                                   @885, kStart,
                                   @932, kEnd,
                                   @6, kBlock,
                                   @NO, kIsFree, nil];
    
    NSMutableDictionary *Lunch = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  @"Lunch", kClassName,
                                  @642, kStart,
                                  @682, kEnd,
                                  @7, kBlock,
                                  @NO, kIsFree, nil];
    
    NSMutableDictionary *Advisor = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                    @"Advisor Time", kClassName,
                                    @689, kStart,
                                    @716, kEnd,
                                    @8, kBlock,
                                    @NO, kIsFree, nil];
    NSMutableDictionary *Assembly = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                     @"Grade Assembly", kClassName,
                                     @689, kStart,
                                     @716, kEnd,
                                     @8, kBlock,
                                     @NO, kIsFree, nil];
    NSMutableDictionary *CommonTime0 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                     @"Common Time", kClassName,
                                     @689, kStart,
                                     @716, kEnd,
                                     @8, kBlock,
                                     @NO, kIsFree, nil];
    NSMutableDictionary *Club = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                 @"Club", kClassName,
                                 @689, kStart,
                                 @716, kEnd,
                                 @8, kBlock,
                                 @NO, kIsFree, nil];
    NSMutableDictionary *CommonTime = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       @"Common Time", kClassName,
                                       @689, kStart,
                                       @743, kEnd,
                                       @8, kBlock,
                                       @NO, kIsFree, nil];
    NSMutableDictionary *DinkyFree = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                      @"Free", kClassName,
                                      @682, kStart,
                                      @696, kEnd,
                                      @8, kBlock,
                                      @YES, kIsFree, nil];
    NSMutableDictionary *OtherFree = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                      @"Free", kClassName,
                                      @858, kStart,
                                      @878, kEnd,
                                      @8, kBlock,
                                      @YES, kIsFree, nil];
    NSMutableDictionary *AdvisorStudy = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"Advisor Study Hall", kClassName,
                                   @885, kStart,
                                   @932, kEnd,
                                   @6, kBlock,
                                   @NO, kIsFree, nil];
    [CustomMethods saveSchedule:
     [NSMutableArray arrayWithObjects:
     [NSMutableArray arrayWithObjects: [ALong mutableCopy],  [BLong2 mutableCopy],  [Lunch mutableCopy],  [Club mutableCopy],  [DShort2 mutableCopy],  [EShort2 mutableCopy],  [FShort2 mutableCopy],  [GShort mutableCopy], nil],
     [NSMutableArray arrayWithObjects: [AShort mutableCopy],  [BShort mutableCopy],  [CShort mutableCopy],  [Lunch mutableCopy],  [DinkyFree mutableCopy],  [DShort1 mutableCopy],  [EShort1 mutableCopy],  [FLong mutableCopy],  [GShort mutableCopy], nil],
     [NSMutableArray arrayWithObjects: [AShort mutableCopy],  [BShort mutableCopy],  [CShort mutableCopy],  [Lunch mutableCopy],  [Advisor mutableCopy],  [DLong2 mutableCopy],  [FShort1 mutableCopy],  [OtherFree mutableCopy],  [GShort mutableCopy], nil],
     [NSMutableArray arrayWithObjects: [ALong mutableCopy],  [CLong mutableCopy],  [Lunch mutableCopy],  [Club mutableCopy],  [DShort2 mutableCopy],  [EShort2 mutableCopy],  [FShort2 mutableCopy],  [GShort mutableCopy], nil],
     [NSMutableArray arrayWithObjects: [AShort mutableCopy],  [BShort mutableCopy],  [CShort mutableCopy],  [Lunch mutableCopy],  [DinkyFree mutableCopy],  [DShort1 mutableCopy],  [ELong1 mutableCopy],  [FShort2 mutableCopy],  [GShort mutableCopy], nil],
     [NSMutableArray arrayWithObjects: [AShort mutableCopy],  [BShort mutableCopy],  [CShort mutableCopy],  [Lunch mutableCopy],  [CommonTime mutableCopy],  [EShort1 mutableCopy],  [FLong mutableCopy],  [GShort mutableCopy], nil],
     [NSMutableArray arrayWithObjects: [BLong1 mutableCopy],  [CLong mutableCopy],  [Lunch mutableCopy],  [Club mutableCopy],  [DShort2 mutableCopy],  [EShort2 mutableCopy],  [FShort2 mutableCopy],  [GShort mutableCopy], nil],
     [NSMutableArray arrayWithObjects: [AShort mutableCopy],  [BShort mutableCopy],  [CShort mutableCopy],  [Lunch mutableCopy],  [DinkyFree mutableCopy],  [DLong1 mutableCopy],  [EShort2 mutableCopy],  [FShort2 mutableCopy],  [GShort mutableCopy], nil],
     [NSMutableArray arrayWithObjects: [AShort mutableCopy],  [BShort mutableCopy],  [CShort mutableCopy],  [Lunch mutableCopy],  [Assembly mutableCopy],  [DShort2 mutableCopy],  [ELong2 mutableCopy],  [OtherFree mutableCopy],  [AdvisorStudy mutableCopy], nil],
     [NSMutableArray arrayWithObjects: [AShort mutableCopy],  [BShort mutableCopy],  [CShort mutableCopy],  [Lunch mutableCopy],  [CommonTime0 mutableCopy],  [DShort2 mutableCopy],  [EShort2 mutableCopy],  [FShort2 mutableCopy],  [GShort mutableCopy], nil], nil]];
    
    [CustomMethods deleteNotes];

    if(self.viewParent)
        [self.viewParent unlock];
    else if(self.editParent)
        [self.editParent unlock];
    //NSLog(@"!!!!! ERRRRRRRORROROROROR neither view nor edit were set!!!!!!!*******");
}
- (IBAction)use67Tapped:(id)sender{
    [CustomMethods saveSchedule:
     [NSMutableArray arrayWithObjects:
      [NSMutableArray arrayWithObjects: [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                         @"Free", kClassName,
                                         @480, kStart,
                                         @932, kEnd,
                                         @0, kBlock,
                                         @YES, kIsFree, nil], nil],
      [NSMutableArray arrayWithObjects: [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                         @"Free", kClassName,
                                         @480, kStart,
                                         @932, kEnd,
                                         @1, kBlock,
                                         @YES, kIsFree, nil], nil],
      [NSMutableArray arrayWithObjects: [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                         @"Free", kClassName,
                                         @480, kStart,
                                         @932, kEnd,
                                         @2, kBlock,
                                         @YES, kIsFree, nil], nil],
      [NSMutableArray arrayWithObjects: [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                         @"Free", kClassName,
                                         @480, kStart,
                                         @932, kEnd,
                                         @3, kBlock,
                                         @YES, kIsFree, nil], nil],
      [NSMutableArray arrayWithObjects: [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                         @"Free", kClassName,
                                         @480, kStart,
                                         @932, kEnd,
                                         @4, kBlock,
                                         @YES, kIsFree, nil], nil],
      [NSMutableArray arrayWithObjects: [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                         @"Free", kClassName,
                                         @480, kStart,
                                         @932, kEnd,
                                         @5, kBlock,
                                         @YES, kIsFree, nil], nil],
      [NSMutableArray arrayWithObjects: [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                         @"Free", kClassName,
                                         @480, kStart,
                                         @932, kEnd,
                                         @6, kBlock,
                                         @YES, kIsFree, nil], nil],
      [NSMutableArray arrayWithObjects: [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                         @"Free", kClassName,
                                         @480, kStart,
                                         @932, kEnd,
                                         @7, kBlock,
                                         @YES, kIsFree, nil], nil],
      [NSMutableArray arrayWithObjects: [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                         @"Free", kClassName,
                                         @480, kStart,
                                         @932, kEnd,
                                         @8, kBlock,
                                         @YES, kIsFree, nil], nil],
      [NSMutableArray arrayWithObjects: [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                         @"Free", kClassName,
                                         @480, kStart,
                                         @932, kEnd,
                                         @0, kBlock,
                                         @YES, kIsFree, nil], nil], nil]];
    
    [CustomMethods deleteNotes];

    if(self.viewParent)
        [self.viewParent unlock];
    else if(self.editParent)
        [self.editParent unlock];
    //NSLog(@"!!!!! ERRRRRRRORROROROROR neither view nor edit were set!!!!!!!*******");
}
/*- (IBAction)useSampleTapped:(id)sender{
    NSMutableDictionary *AFreeShort = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       @"Free", kClassName,
                                       @480, kStart,
                                       @527, kEnd,
                                       @0, kBlock,
                                       @YES, kIsFree, nil];
    NSMutableDictionary *AFreeShortCopy = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                           @"Free", kClassName,
                                           @480, kStart,
                                           @527, kEnd,
                                           @0, kBlock,
                                           @YES, kIsFree, nil];
    NSMutableDictionary *AFreeLong = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                      @"Free", kClassName,
                                      @480, kStart,
                                      @554, kEnd,
                                      @0, kBlock,
                                      @YES, kIsFree, nil];
    
    NSMutableDictionary *BShort1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                    @"AP Calc AB", kClassName,
                                    @507, kStart,
                                    @554, kEnd,
                                    @1, kBlock,
                                    @NO, kIsFree,
                                    @"S101", kRoom, nil];
    NSMutableDictionary *BShort2 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                    @"AP Calc AB", kClassName,
                                    @534, kStart,
                                    @581, kEnd,
                                    @1, kBlock,
                                    @NO, kIsFree,
                                    @"S101", kRoom, nil];
    NSMutableDictionary *BLong = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  @"AP Calc AB", kClassName,
                                  @561, kStart,
                                  @635, kEnd,
                                  @1, kBlock,
                                  @NO, kIsFree,
                                  @"S101", kRoom, nil];
    NSMutableDictionary *BFree = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  @"Free", kClassName,
                                  @480, kStart,
                                  @507, kEnd,
                                  @1, kBlock,
                                  @YES, kIsFree, nil];
    
    NSMutableDictionary *CShort = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"Symph Band", kClassName,
                                   @588, kStart,
                                   @635, kEnd,
                                   @2, kBlock,
                                   @NO, kIsFree,
                                   @"M154", kRoom, nil];
    NSMutableDictionary *CFree = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  @"Free", kClassName,
                                  @561, kStart,
                                  @588, kEnd,
                                  @2, kBlock,
                                  @YES, kIsFree, nil];
    
    NSMutableDictionary *DFreeShort1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                        @"Free", kClassName,
                                        @642, kStart,
                                        @689, kEnd,
                                        @3, kBlock,
                                        @YES, kIsFree, nil];
    NSMutableDictionary *DFreeShort2 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                        @"Free", kClassName,
                                        @676, kStart,
                                        @723, kEnd,
                                        @3, kBlock,
                                        @YES, kIsFree, nil];
    NSMutableDictionary *DFreeLong = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                      @"Free", kClassName,
                                      @643, kStart,
                                      @716, kEnd,
                                      @3, kBlock,
                                      @YES, kIsFree, nil];
    
    NSMutableDictionary *EShort1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                    @"Hums", kClassName,
                                    @750, kStart,
                                    @797, kEnd,
                                    @4, kBlock,
                                    @NO, kIsFree,
                                    @"M16", kRoom, nil];
    NSMutableDictionary *EShort2 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                    @"Hums", kClassName,
                                    @777, kStart,
                                    @824, kEnd,
                                    @4, kBlock,
                                    @NO, kIsFree,
                                    @"M16", kRoom, nil];
    NSMutableDictionary *ELong1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"Hums", kClassName,
                                   @750, kStart,
                                   @824, kEnd,
                                   @4, kBlock,
                                   @NO, kIsFree,
                                   @"M16", kRoom, nil];
    NSMutableDictionary *ELong2 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"Hums", kClassName,
                                   @777, kStart,
                                   @851, kEnd,
                                   @4, kBlock,
                                   @NO, kIsFree,
                                   @"M16", kRoom, nil];
    NSMutableDictionary *EGroup = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"Large Group Hums", kClassName,
                                   @655, kStart,
                                   @702, kEnd,
                                   @4, kBlock,
                                   @NO, kIsFree, nil];
    NSMutableDictionary *EFree1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"Free", kClassName,
                                   @750, kStart,
                                   @797, kEnd,
                                   @4, kBlock,
                                   @YES, kIsFree, nil];
    NSMutableDictionary *EFree2 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"Free", kClassName,
                                   @777, kStart,
                                   @824, kEnd,
                                   @4, kBlock,
                                   @YES, kIsFree, nil];
    
    NSMutableDictionary *FShort1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                    @"AP Physics I", kClassName,
                                    @804, kStart,
                                    @851, kEnd,
                                    @5, kBlock,
                                    @NO, kIsFree,
                                    @"S212", kRoom, nil];
    NSMutableDictionary *FShort2 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                    @"AP Physics I", kClassName,
                                    @831, kStart,
                                    @878, kEnd,
                                    @5, kBlock,
                                    @NO, kIsFree,
                                    @"S212", kRoom, nil];
    NSMutableDictionary *FLong = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  @"AP Physics I", kClassName,
                                  @804, kStart,
                                  @878, kEnd,
                                  @5, kBlock,
                                  @NO, kIsFree,
                                  @"S212", kRoom, nil];
    NSMutableDictionary *FFree = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  @"Free", kClassName,
                                  @831, kStart,
                                  @878, kEnd,
                                  @5, kBlock,
                                  @YES, kIsFree, nil];
    
    NSMutableDictionary *GShort = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"English IV", kClassName,
                                   @885, kStart,
                                   @932, kEnd,
                                   @6, kBlock,
                                   @NO, kIsFree,
                                   @"B404", kRoom, nil];
    NSMutableDictionary *GLong = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  @"English IV", kClassName,
                                  @858, kStart,
                                  @932, kEnd,
                                  @6, kBlock,
                                  @NO, kIsFree,
                                  @"B404", kRoom, nil];
    NSMutableDictionary *GFree = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                  @"Free", kClassName,
                                  @885, kStart,
                                  @932, kEnd,
                                  @6, kBlock,
                                  @YES, kIsFree, nil];
    
    NSMutableDictionary *Lunch1 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"Lunch", kClassName,
                                   @696, kStart,
                                   @743, kEnd,
                                   @7, kBlock,
                                   @NO, kIsFree, nil];
    NSMutableDictionary *Lunch2 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"Lunch", kClassName,
                                   @709, kStart,
                                   @743, kEnd,
                                   @7, kBlock,
                                   @NO, kIsFree, nil];
    NSMutableDictionary *Lunch3Short = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                        @"Lunch", kClassName,
                                        @723, kStart,
                                        @770, kEnd,
                                        @7, kBlock,
                                        @NO, kIsFree, nil];
    NSMutableDictionary *Lunch3Long = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       @"Lunch", kClassName,
                                       @723, kStart,
                                       @797, kEnd,
                                       @7, kBlock,
                                       @NO, kIsFree, nil];
    NSMutableDictionary *Lunch4 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"Lunch", kClassName,
                                   @730, kStart,
                                   @770, kEnd,
                                   @7, kBlock,
                                   @NO, kIsFree, nil];
    NSMutableDictionary *Lunch0 = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"Lunch", kClassName,
                                   @696, kStart,
                                   @770, kEnd,
                                   @7, kBlock,
                                   @NO, kIsFree, nil];
    
    NSMutableDictionary *Club = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                 @"Club", kClassName,
                                 @642, kStart,
                                 @669, kEnd,
                                 @8, kBlock,
                                 @NO, kIsFree, nil]; //block 8 and type 3 are both "other"
    NSMutableDictionary *DivAss = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"Division Assembly", kClassName,
                                   @642, kStart,
                                   @669, kEnd,
                                   @8, kBlock,
                                   @NO, kIsFree, nil];
    NSMutableDictionary *Common = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                   @"Common Time", kClassName,
                                   @885, kStart,
                                   @932, kEnd,
                                   @8, kBlock,
                                   @NO, kIsFree, nil];
    NSMutableDictionary *DinkyFree = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                      @"Free", kClassName,
                                      @635, kStart,
                                      @655, kEnd,
                                      @8, kBlock,
                                      @YES, kIsFree, nil];
    
    [CustomMethods saveSchedule:
     [NSMutableArray arrayWithObjects:
     [NSMutableArray arrayWithObjects: [AFreeLong mutableCopy], [BLong mutableCopy], [DivAss mutableCopy], [DFreeShort2 mutableCopy], [Lunch4 mutableCopy], [EShort2 mutableCopy], [FShort2 mutableCopy], [GShort mutableCopy], nil],
     [NSMutableArray arrayWithObjects: [AFreeShortCopy mutableCopy], [BShort2 mutableCopy], [CShort mutableCopy], [DFreeLong mutableCopy], [Lunch3Long mutableCopy], [FLong mutableCopy], [GShort mutableCopy], nil],
     [NSMutableArray arrayWithObjects: [AFreeShort mutableCopy], [BShort2 mutableCopy], [CShort mutableCopy], [Club mutableCopy], [DFreeShort2 mutableCopy], [Lunch4 mutableCopy], [EShort2 mutableCopy], [FShort2 mutableCopy], [GFree mutableCopy], nil],
     [NSMutableArray arrayWithObjects: [AFreeLong mutableCopy], [CFree mutableCopy], [CShort mutableCopy], [DFreeShort1 mutableCopy], [Lunch1 mutableCopy], [ELong1 mutableCopy], [FFree mutableCopy], [GShort mutableCopy], nil],
     [NSMutableArray arrayWithObjects: [AFreeShort mutableCopy], [BShort2 mutableCopy], [CShort mutableCopy], [DinkyFree mutableCopy], [EGroup mutableCopy], [Lunch2 mutableCopy], [EShort1 mutableCopy], [FShort1 mutableCopy], [GLong mutableCopy], nil],
     [NSMutableArray arrayWithObjects: [AFreeShort mutableCopy], [BShort2 mutableCopy], [CShort mutableCopy], [DFreeLong mutableCopy], [Lunch3Short mutableCopy], [EFree2 mutableCopy], [FShort2 mutableCopy], [GShort mutableCopy], nil],
     [NSMutableArray arrayWithObjects: [BFree mutableCopy], [BShort1 mutableCopy], [CFree mutableCopy], [CShort mutableCopy], [DivAss mutableCopy], [DFreeShort2 mutableCopy], [Lunch4 mutableCopy], [EShort2 mutableCopy], [FShort2 mutableCopy], [GShort mutableCopy], nil],
     [NSMutableArray arrayWithObjects: [AFreeShort mutableCopy], [BShort2 mutableCopy], [CShort mutableCopy], [DFreeShort1 mutableCopy], [Lunch1 mutableCopy], [EFree1 mutableCopy], [FLong mutableCopy], [Common mutableCopy], nil],
     [NSMutableArray arrayWithObjects: [AFreeShort mutableCopy], [BShort2 mutableCopy], [CShort mutableCopy], [Club mutableCopy], [DFreeShort2 mutableCopy], [Lunch4 mutableCopy], [ELong2 mutableCopy], [GLong mutableCopy], nil],
     [NSMutableArray arrayWithObjects: [AFreeShort mutableCopy], [BShort2 mutableCopy], [CShort mutableCopy], [DFreeShort1 mutableCopy], [Lunch0 mutableCopy], [EShort2 mutableCopy], [FShort2 mutableCopy], [GShort mutableCopy], nil], nil]];
    
    
    if(self.viewParent)
        [self.viewParent unlock];
    else if(self.editParent)
        [self.editParent unlock];
    //NSLog(@"!!!!! ERRRRRRRORROROROROR neither view nor edit were set!!!!!!!*******");
    
}*/


@end
