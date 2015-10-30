//
//  SCMessageParameter.h
//  Socially Server
//
//  Created by Abel Duarte on 10/22/15.
//  Copyright © 2015 Abel Duarte. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SCMessageParameter : NSObject
{
}

+ (id)decodeMessageParameterWithData:(NSData *)data;

- (id)initWithName:(NSString *)name value:(NSData *)value;

@property (nonatomic, readonly, retain) NSString *name;
@property (nonatomic, readonly, retain) NSData *value;

@property (nonatomic, readonly) NSData *data;

@end
