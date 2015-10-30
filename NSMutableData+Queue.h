//
//  NSMutableData+Queue.h
//  Test
//
//  Created by Abel Duarte on 10/28/15.
//  Copyright © 2015 Abel Duarte. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableData(Queue)
{
}

- (NSData *)read:(NSUInteger)length;

- (void)removeBytes:(NSUInteger)length;

@end
