//
//  NSMutableData+NSString.m
//  Test
//
//  Created by Abel Duarte on 10/30/15.
//  Copyright © 2015 Abel Duarte. All rights reserved.
//

#import "NSData+NSString.h"

@implementation NSData(NSStringAdditions)

- (NSString *)stringWithEncoding:(NSStringEncoding)encoding
{
    return [[NSString alloc] initWithData:self encoding:encoding];
}

@end
