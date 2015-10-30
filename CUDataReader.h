//
//  NSDataIterator.h
//  Test
//
//  Created by Abel Duarte on 10/28/15.
//  Copyright © 2015 Abel Duarte. All rights reserved.
//

#import <Foundation/Foundation.h>

enum
{
    CUDataReaderBigEndian,
    CUDataReaderLittleEndian,
    CUDataReaderDefaultEndian = CUDataReaderLittleEndian
};
typedef NSUInteger CUDataReaderEndianness;

@interface CUDataReader : NSObject
{
}

@property (nonatomic, assign) NSUInteger offset;

- (id)initWithData:(NSData *)data;
+ (id)dataReaderWithData:(NSData *)data;

- (void)setEndianness:(CUDataReaderEndianness)endianness;

- (NSData *)read:(NSUInteger)length;
- (NSData *)readUntilData:(NSData *)data;
- (NSData *)readUntilDelimeter:(char)delimeter;

- (BOOL)readBoolean;
- (char)readCharacter;
- (short)readShort;
- (int)readInteger;
- (float)readFloat;
- (double)readDouble;
- (long)readLong;

- (void)rewind;
- (void)rewind:(NSUInteger)length;

- (void)skip:(NSUInteger)offset;
- (NSUInteger)bytesRemaining;

@end
