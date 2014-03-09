//
//  UIColor+HexAdditions.m
//  

#import "UIColor+HexAdditions.h"

@implementation UIColor (HexAdditions)

+ (UIColor *)colorWithHexValue:(NSUInteger)hexValue {
    return [UIColor colorWithHexValue:hexValue alpha:1.0f];
}

+ (UIColor *)colorWithHexValue:(NSUInteger)hexValue alpha:(CGFloat)alpha{
    return [UIColor colorWithRed:(((hexValue & 0xFF0000) >> 16) / 255.0) green:(((hexValue & 0xFF00) >> 8) / 255.0) blue:((hexValue & 0xFF) / 255.0) alpha:alpha];
}

@end
