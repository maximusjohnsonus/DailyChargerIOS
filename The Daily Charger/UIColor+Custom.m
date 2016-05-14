//
//  UIColor+Custom.m
//  AA Schedule
//

#import "UIColor+Custom.h"

const NSString *redKey = @"redKey";
const NSString *greenKey = @"greenKey";
const NSString *blueKey = @"blueKey";
const NSString *alphaKey = @"alphaKey";

@implementation UIColor (Custom)

+ (UIColor *)colorWithR:(CGFloat)red G:(CGFloat)green B:(CGFloat)blue A:(CGFloat)alpha{
    return [UIColor colorWithRed:(red/255.0) green:(green/255.0) blue:(blue/255.0) alpha:alpha];
}
+ (UIColor *)paleColor:(UIColor *)color withFactor:(CGFloat)factor{
    CGFloat red, green, blue, alpha;
    [color getRed:&red green:&green blue:&blue alpha:&alpha];
    return [UIColor colorWithRed:1.0-(1.0-red)/factor green:1.0-(1.0-green)/factor blue:1.0-(1.0-blue)/factor alpha:alpha];
}
+ (UIColor *)colorFromDictionary:(NSDictionary*)dictionary{
    return [UIColor colorWithRed:[dictionary[redKey] floatValue] green:[dictionary[greenKey] floatValue] blue:[dictionary[blueKey] floatValue] alpha:[dictionary[alphaKey] floatValue]];
}
+ (NSDictionary *)dictionaryFromColor:(UIColor*)color{
    CGFloat red, green, blue, alpha;
    [color getRed:&red green:&green blue:&blue alpha:&alpha];
    return [[NSDictionary alloc] initWithObjectsAndKeys:
            @(red), redKey,
            @(green), greenKey,
            @(blue), blueKey,
            @(alpha), alphaKey, nil];
}
@end
