/*
 * Copyright 2013 Taptera Inc. All rights reserved.
 */


#import <Foundation/Foundation.h>
#import "MTLModel.h"
#import "MTLJSONAdapter.h"


@interface TUTTwitterStatus : MTLModel <MTLJSONSerializing>
@property (nonatomic, strong) NSString *text;

@end
