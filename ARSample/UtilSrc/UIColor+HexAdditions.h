//
//  UIColor+HexAdditions.h
//

/**
 This is a category to UIColor and it contains methods for creating custom colors based on hex values
 
 @class UIColor(HexAdditions)
 **/

@interface UIColor (HexAdditions)

/**
 Gets the UIColor based on the hex value
 
 @method colorWithHexValue
 @param {NSUInteger} hexValue
 **/
+ (UIColor *)colorWithHexValue:(NSUInteger)hexValue;

/**
 Gets the UIColor based on the hex value
 
 @method colorWithHexValue
 @param {NSUInteger} hexValue
 @param {CGFloat} alpha
 **/
+ (UIColor *)colorWithHexValue:(NSUInteger)hexValue alpha:(CGFloat)alpha;

@end
