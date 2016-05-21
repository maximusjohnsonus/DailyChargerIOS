//
//  CustomMethods.m
//  AA Schedule
//

#import "CustomMethods.h"
#import "KeyDefinitions.h"
#import "UIColor+Custom.h"

int cycleDays[] = {0, 1, -1, -1, 2, 3, 4, 5, 0, -1, -1, 6, 7, 8, 9, 1, -1, -1, -1, 2, 3, 4, 5, -1, -1, 6, 7, 8, 9, 1, -1, -1, 2, 3, 4, 5, 6, -1, -1, 0, 7, 8, 9, 1, -1, -1, 2, 3, 4, 5, -1, -1, -1, -1, 6, 0, 7, 8, -1, -1, 9, 1, 2, 3, 4, -1, -1, 5, 6, 7, 8, 9, -1, -1, 1, 2, 3, 4, -1, -1, -1, 5, 6, 7, 8, 9, -1, -1, 1, 2, 3, 4, 5, -1, -1, 6, 7, -1, -1, -1, -1, -1, 8, 9, 1, 2, 3, -1, -1, 4, 5, 6, 7, 0, -1, -1, 0, 0, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 1, 2, 3, 4, 5, -1, -1, 6, 7, 8, 9, 1, -1, -1, -1, 2, 3, 4, 5, -1, -1, 6, 7, 8, 0, 9, -1, -1, 1, 2, 3, 4, 5, -1, -1, 6, 7, 8, 9, 1, -1, -1, -1, 2, 3, 4, 5, -1, -1, 6, 7, 8, 9, 1, -1, -1, 2, 3, 4, 5, 6, -1, -1, 7, 8, 9, 1, 2, -1, -1, 3, 4, 0, 5, 6, -1, -1, 7, 8, 9, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, 1, 2, 3, -1, -1, 4, 5, 6, 7, 8, -1, -1, 9, 1, 2, 3, 4, -1, -1, 5, 6, 7, 8, -1, -1, -1, 9, 1, 2, 3, 4, -1, -1, 5, 6, 7, 8, 9, -1, -1, 1, 2, 0, 0, 0};

static NSMutableArray *scheduleArray;

@implementation CustomMethods{
    
}

+ (void) saveSchedule:(NSMutableArray *)newSchedule{
    NSError *error;
    if(![NSPropertyListSerialization propertyList:newSchedule isValidForFormat:NSPropertyListXMLFormat_v1_0]){ //kCFPropertyListXMLFormat_v1_0
        //NSLog(@"invalid plist");
        return;
    }
    NSData *writeData = [NSPropertyListSerialization dataWithPropertyList:newSchedule format:NSPropertyListXMLFormat_v1_0 options:0 error:&error];
    if(writeData == nil){
        //NSLog(@"error making data: %@", error);
        return;
    }
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *appFile = [documentsDirectory stringByAppendingPathComponent:@"schedule"];
    if(! [writeData writeToFile:appFile options:0 error:&error]){
        //NSLog(@"error saving data: %@", error);
        return;
    }
    scheduleArray = newSchedule;
    //NSLog(@"made it phew");
    /*NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    //[prefs removeObjectForKey:kSchedule];
    [prefs setObject:newSchedule forKey:kSchedule];
    [prefs synchronize];*/
}
+ (NSMutableArray *) getSchedule{
    //NSLog(@"place 10");
    if(!scheduleArray){
        //scheduleArray = [[[NSUserDefaults standardUserDefaults] objectForKey:kSchedule] mutableCopy];
        NSError *error;
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *appFile = [documentsDirectory stringByAppendingPathComponent:@"schedule"];
        NSData *readData = [NSData dataWithContentsOfFile:appFile options:0 error:&error];
        if(readData == nil){
            //NSLog(@"data failed to read: %@", error);
            return nil;
        }
        NSPropertyListFormat format;
        id plist = [NSPropertyListSerialization propertyListWithData:readData options:NSPropertyListMutableContainersAndLeaves format:&format error:&error];
        if(plist == nil){
            //NSLog(@"error deserializing: %@", error);
            return nil;
        }
        scheduleArray = plist;
    }
    //NSLog(@"place 11");
    return scheduleArray;
}

+ (NSMutableDictionary *) getNotesForDay:(NSInteger)index{
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *appFile = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"note%d",index]];
    NSData *readData = [NSData dataWithContentsOfFile:appFile options:0 error:&error];
    if(readData == nil){
        //NSLog(@"note data failed to read: for index %d", index);//error);
        return nil;
    }
    NSPropertyListFormat format;
    id plist = [NSPropertyListSerialization propertyListWithData:readData options:NSPropertyListMutableContainersAndLeaves format:&format error:&error];
    if(plist == nil){
        //NSLog(@"error deserializing notes: %@", error);
        return nil;
    }
    //NSLog(@"loaded notes for day %d. period 0 data: %@",index, [(NSMutableDictionary*)plist valueForKey:@"0"]);
    return plist;
}
+ (void) saveNotes:(NSMutableDictionary *)newNotes forDay:(NSInteger)index{
    if(newNotes.count>0){
        NSError *error;
        if(![NSPropertyListSerialization propertyList:newNotes isValidForFormat:NSPropertyListXMLFormat_v1_0]){
            //NSLog(@"invalid plist notes");
            return;
        }
        NSData *writeData = [NSPropertyListSerialization dataWithPropertyList:newNotes format:NSPropertyListXMLFormat_v1_0 options:0 error:&error];
        if(writeData == nil){
            //NSLog(@"error making notes data: %@", error);
            return;
        }
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *appFile = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"note%d",index]];
        if(! [writeData writeToFile:appFile options:0 error:&error]){
            //NSLog(@"error saving notes data: %@", error);
            return;
        }
    } else {
        //NSLog(@"notes are nil, attempting to delete");
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsPath = [paths objectAtIndex:0];
        NSString *filePath = [documentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"note%d",index]];
         //TODO: change this part maybe
        [fileManager removeItemAtPath:filePath error:NULL];
        
        
    }
}
+ (void) updateNoteTo:(NSString *)newNote forPath:(NSIndexPath *)index{
    NSMutableDictionary *notes = [CustomMethods getNotesForDay:index.section];
    if(notes==nil){
        notes = [[NSMutableDictionary alloc] init];
    }
    if(newNote==nil || [newNote isEqualToString:@""]){ //|| [newNote isEqualToString:placeHolderText]
        [notes removeObjectForKey:[NSString stringWithFormat:@"%d",index.row]]; //delete if note is empty
    } else
        [notes setObject:newNote forKey:[NSString stringWithFormat:@"%d",index.row]]; //else update note
    //[dict isKindOfClass:[NSNull class]];

    [CustomMethods saveNotes:notes forDay:index.section];
}


+ (NSString *) intToTimeString:(NSInteger)time{
    return [NSString stringWithFormat:@"%ld:%@%ld", (long)((time/60 - 1) % ([CustomMethods use24HourTime] ? 24 : 12)) + 1, (time%60<10 ? @"0":@""), (long)(time%60)];
}

+ (BOOL) use24HourTime{
    return [[NSUserDefaults standardUserDefaults] boolForKey:KEY_TIME24];
}
+ (BOOL) showWeekends{
    return [[NSUserDefaults standardUserDefaults] boolForKey:KEY_WEEKEND];
}
+ (BOOL) enableNotes{
    return [[NSUserDefaults standardUserDefaults] boolForKey:KEY_NOTES];
}
+ (NSInteger) minimumPeriodLength{
    return 14 ;
}
+ (NSInteger) getCycleDayForIndex:(NSInteger)index{
    return cycleDays[index];
}
+ (UIColor *) getColor:(NSMutableDictionary *)periodData {
    NSArray *defaultColors = [NSArray arrayWithObjects:
                     [UIColor colorWithR:255 G:174 B:201 A:1], //A (pink)
                     [UIColor colorWithR:255 G:127 B:39 A:1],  //B (red)
                     [UIColor colorWithR:255 G:201 B:14 A:1],  //C (orange
                     [UIColor colorWithR:255 G:255 B:74 A:1],  //D (yellow)
                     [UIColor colorWithR:34 G:189 B:255 A:1],  //E (blue)
                     [UIColor colorWithR:102 G:111 B:215 A:1], //F (indigo)
                     [UIColor colorWithR:163 G:73 B:164 A:1],  //G (purple)
                     [UIColor colorWithR:181 G:230 B:29 A:1],  //Lunch (green)
                     [UIColor colorWithR:150 G:150 B:150 A:1], nil]; //Misc (grey);
    if (periodData[kColor] != nil){
        return [UIColor colorFromDictionary:periodData[kColor]];
    }
    else if ([periodData[kIsFree] boolValue]){
        return [UIColor paleColor:[defaultColors objectAtIndex:[periodData[kBlock] integerValue]] withFactor:[[[NSDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Constants" ofType:@"plist"]][@"Pale Factor"] integerValue]];
    }
    else {
        return [defaultColors objectAtIndex:[periodData[kBlock] integerValue]];
    }
}

@end
