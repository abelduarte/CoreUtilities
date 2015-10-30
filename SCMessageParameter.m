//
//  SCMessageParameter.m
//  Socially Server
//
//  Created by Abel Duarte on 10/22/15.
//  Copyright © 2015 Abel Duarte. All rights reserved.
//

#import "SCMessageParameter.h"

@interface SCMessageParameter()
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSData *value;
@end

@implementation SCMessageParameter

- (id)initWithName:(NSString *)name value:(NSData *)value
{
	self = [super init];
	if(self)
	{
		self.name = [self validateName:name];
		self.value = value;
	}
	return self;
}

+ (id)decodeMessageParameterWithData:(NSData *)data
{
	if(!data.length)
	{
		return nil;
	}

	NSUInteger length = data.length;
	char *bytes = (char *)data.bytes;
	char *end = bytes + length;

	UInt8 nameLength = 0;
	char *nameBytes = NULL;

	UInt32 valueLength = 0;
	char *valueBytes = NULL;

	/* check for FS */
	if(*bytes == 0x1C)
	{
		/* move on to the name length byte */
		bytes++;
	}
	else
	{
		return nil;
	}

	/* get the length of the name */
	if(bytes < end)
	{
		nameLength = *bytes;
		bytes++;
	}
	else
	{
		return nil;
	}

	/* get the name */
	nameBytes = bytes;
	bytes += nameLength;

	/* get the length of the value */
	if(bytes < end)
	{
		valueLength = *(UInt32 *)bytes;
		bytes += 4;
	}
	else
	{
		return nil;
	}

	/* get the value */
	valueBytes = bytes;
	bytes += valueLength;

	/* If the data is complete then return a message parameter object */
	if(bytes == end)
	{
		NSData *nameData = [NSData dataWithBytes:nameBytes length:nameLength];
		NSData *valueData = [NSData dataWithBytes:valueBytes length:valueLength];

		NSString *name = [[NSString alloc] initWithData:nameData encoding:NSUTF8StringEncoding];

		SCMessageParameter *parameter = [[SCMessageParameter alloc] initWithName:name
																		   value:valueData];

		return parameter;
	}

	return nil;
}

- (NSData *)data
{
	char fs = 0x1C;

	NSData *nameData = [self nameData];
	UInt8 nameLength = [nameData length];

	NSData *valueData = self.value;
	UInt8 valueLength = valueData.length;

	NSMutableData *data = [NSMutableData data];

	[data appendBytes:&fs length:1];
	[data appendBytes:&nameLength length:1];
	[data appendData:nameData];
	[data appendBytes:&valueLength length:1];
	[data appendData:valueData];

	return data;
}

- (NSData *)nameData
{
	return [self.name dataUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *)validateName:(NSString *)name
{
	if(name.length > 255)
	{
		return [name substringToIndex:255];
	}

	return name;
}

@end
