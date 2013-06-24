/*
 * Copyright 2013 Taptera Inc. All rights reserved.
 */


#import <STTwitter/STTwitterAPIWrapper.h>
#import "TUTBearerObtainer.h"


@implementation TUTBearerObtainer

+ (instancetype)obtainerWithTwitterAPIWrapper:(STTwitterAPIWrapper *)wrapper {
    TUTBearerObtainer *bearerObtainer = [[self alloc] init];
    bearerObtainer.apiWrapper = wrapper;
    return bearerObtainer;
}

- (void)obtainBearer {
    [self.apiWrapper verifyCredentialsWithSuccessBlock:^(NSString *bearerToken) {
        [self.delegate bearerObtainer:self didObtainBearerToken:bearerToken];
    }                                              errorBlock:nil];
}

@end
