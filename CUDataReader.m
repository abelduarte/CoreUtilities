//
//  NSDataIterator.m
//  Test
//
//  Created by Abel Duarte on 10/28/15.
//  Copyright © 2015 Abel Duarte. All rights reserved.
//

#import "CUDataReader.h"

@interface CUDataReader()
@property (nonatomic, assign) CUDataReaderEndianness endianness;
@property (nonatomic, retain) NSData *data;
@end

@implementation CUDataReader

#pragma mark - Init

- (id)initWithData:(NSData *)data
{
    self = [super init];
    if(self)
    {
        self.data = data;
        self.offset = 0;
        self.endianness = CUDataReaderDefaultEndian;
    }
    return self;
}

+ (id)dataReaderWithData:(NSData *)data
{
    return [[CUDataReader alloc] initWithData:data];
}

- (void)dealloc
{
    self.data = nil;
}

#pragma mark - Read

- (NSData *)read:(NSUInteger)length
{
    NSUInteger readLength = self.offset + length;
    
    if(readLength <= self.data.length && length > 0)
    {
        NSData *data = [self.data subdataWithRange:NSMakeRange(self.offset, length)];
        self.offset += length;
        
        return data;
    }
    
    return nil;
}

- (NSData *)readUntilData:(NSData *)data
{
    NSRange dataRange = [self.data rangeOfData:data
                                       options:0
                                         range:NSMakeRange(self.offset, self.data.length - self.offset)];
    
    if(dataRange.location != NSNotFound)
    {
        NSUInteger length = dataRange.location - self.offset;
        return [self read:length];
    }
    
    return nil;
}

- (NSData *)readUntilDelimeter:(char)delimeter
{
    NSData *data = [NSData dataWithBytes:&delimeter length:1];
    return [self readUntilData:data];
}

#pragma mark - Endianess

- (void)setEndianness:(CUDataReaderEndianness)endianness
{
    _endianness = endianness;
}

- (NSData *)endiannessDecodedData:(NSData *)data
{
    if(self.endianness == CUDataReaderLittleEndian)
    {
        return data;
    }
    else
    {
        NSMutableData *endiannessDecodedData = [NSMutableData data];
        
        NSUInteger length = data.length;
        char *bytes = (char *)[data bytes];
        
        for(NSInteger i = length - 1; i >= 0; i--)
        {
            char *byte = bytes + i;
            [endiannessDecodedData appendBytes:byte length:1];
        }
        
        return endiannessDecodedData;
    }
    
    return data;
}

#pragma mark - Type utilities

- (BOOL)readBoolean
{
    NSUInteger length = sizeof(BOOL);
    return *(BOOL *)[[self endiannessDecodedData:[self read:length]] bytes];
}

- (char)readCharacter
{
    NSUInteger length = sizeof(char);
    return *(char *)[[self endiannessDecodedData:[self read:length]] bytes];
}

- (short)readShort
{
    NSUInteger length = sizeof(short);
    return *(short *)[[self endiannessDecodedData:[self read:length]] bytes];
}

- (int)readInteger
{
    NSUInteger length = sizeof(int);
    return *(int *)[[self endiannessDecodedData:[self read:length]] bytes];
}

- (float)readFloat
{
    NSUInteger length = sizeof(float);
    return *(float *)[[self endiannessDecodedData:[self read:length]] bytes];
}

- (double)readDouble
{
    NSUInteger length = sizeof(double);
    return *(double *)[[self endiannessDecodedData:[self read:length]] bytes];
}

- (long)readLong
{
    NSUInteger length = sizeof(long);
    return *(long *)[[self endiannessDecodedData:[self read:length]] bytes];
}

#pragma mark - Offset

- (void)rewind
{
    self.offset = 0;
}

- (void)rewind:(NSUInteger)length
{
    if(length <= self.offset)
    {
        self.offset -= length;
    }
    else
    {
        self.offset = 0;
    }
}

- (void)setOffset:(NSUInteger)offset
{
    if(offset <= self.data.length)
        _offset = offset;
}

- (void)skip:(NSUInteger)offset
{
    NSUInteger x = self.offset + offset;
    [self setOffset:x];
}

- (NSUInteger)bytesRemaining
{
    return self.data.length - self.offset;
}

@end
