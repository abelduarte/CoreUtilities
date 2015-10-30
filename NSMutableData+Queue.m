//
//  NSMutableData+Queue.m
//  Test
//
//  Created by Abel Duarte on 10/28/15.
//  Copyright © 2015 Abel Duarte. All rights reserved.
//

#import "NSMutableData+Queue.h"

@implementation NSMutableData (Queue)

- (NSData *)read:(NSUInteger)length
{
    if(length <= self.length && length > 0)
    {
        NSData *data = [self subdataWithRange:NSMakeRange(0, length)];
        [self replaceBytesInRange:NSMakeRange(0, length) withBytes:NULL length:0];
        return data;
    }
    
    return nil;
}

- (void)removeBytes:(NSUInteger)length
{
    if(length <= self.length && length > 0)
    {
        [self replaceBytesInRange:NSMakeRange(0, length) withBytes:NULL length:0];
    }
}

@end
