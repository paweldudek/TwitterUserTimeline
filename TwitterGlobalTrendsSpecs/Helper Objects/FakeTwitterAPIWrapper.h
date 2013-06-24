/*
 * Copyright 2013 Taptera Inc. All rights reserved.
 */


#import <Foundation/Foundation.h>
#import "STTwitterAPIWrapper.h"


@interface FakeTwitterAPIWrapper : STTwitterAPIWrapper
@property(nonatomic, copy) void (^lastSuccessBlock)(NSArray *);
@property(nonatomic, copy) void (^lastFailureBlock)(NSError *);
@property(nonatomic, copy) NSString *lastScreenName;

+ (instancetype)fakeWrapper;

- (void)simulateUserTimelineDownloadWithStatuses:(NSArray *)array;
@end
