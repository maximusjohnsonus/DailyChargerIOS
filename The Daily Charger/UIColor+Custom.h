//
//  UIColor+Custom.h
//  AA Schedule
//

#import <UIKit/UIKit.h>

@interface UIColor (Custom)
+ (UIColor *)colorWithR:(CGFloat)red G:(CGFloat)green B:(CGFloat)blue A:(CGFloat)alpha;
+ (UIColor *)paleColor:(UIColor *)color withFactor:(CGFloat)factor;
+ (UIColor *)colorFromDictionary:(NSDictionary*)dictionary;
+ (NSDictionary *)dictionaryFromColor:(UIColor*)color;
@end
