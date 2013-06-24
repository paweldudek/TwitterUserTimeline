/*
 * Copyright 2013 Taptera Inc. All rights reserved.
 */


#import "FakeTwitterAPIWrapper.h"


@implementation FakeTwitterAPIWrapper

+ (instancetype)fakeWrapper {
    return [[self alloc] init];
}

- (void)getUserTimelineWithScreenName:(NSString *)screenName count:(NSUInteger)optionalCount successBlock:(void (^)(NSArray *statuses))successBlock errorBlock:(void (^)(NSError *error))errorBlock {
    self.lastSuccessBlock = [successBlock copy];
    self.lastFailureBlock = [errorBlock copy];

    self.lastScreenName = screenName;
}

- (void)simulateUserTimelineDownloadWithStatuses:(NSArray *)array {
    if (self.lastSuccessBlock) {
        self.lastSuccessBlock(array);
    }
}

@end
