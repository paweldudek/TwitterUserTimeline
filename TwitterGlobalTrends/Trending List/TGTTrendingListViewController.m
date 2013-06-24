/*
 * Copyright 2013 Taptera Inc. All rights reserved.
 */


#import "TGTTrendingListViewController.h"
#import "STTwitterAPIWrapper.h"
#import "STTwitterOAuthProtocol.h"
#import "STTwitterAppOnly.h"
#import "TGTBearerObtainer.h"
#import "MTLJSONAdapter.h"
#import "TGTTwitterStatus.h"

@implementation TGTTrendingListViewController

- (id)init {
    self = [super init];
    if (self) {
        self.twitterAPIWrapper = [STTwitterAPIWrapper twitterAPIApplicationOnlyWithConsumerKey:@"aCxyQ1aWHicXTbBCg4jQ"
                                                                                consumerSecret:@"15whlIaMrHCzOb0BnO2bvrHCnbggbFB866Q7HSWygk8"];

        self.bearerObtainer = [TGTBearerObtainer obtainerWithTwitterAPIWrapper:self.twitterAPIWrapper];
        self.bearerObtainer.delegate = self;
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    [self.bearerObtainer obtainBearer];
}

#pragma mark - Bearer Obtainer Delegate

- (void)bearerObtainer:(TGTBearerObtainer *)obtainer didObtainBearerToken:(NSString *)token {
    [self.twitterAPIWrapper getUserTimelineWithScreenName:@"eldudi" count:5
                                             successBlock:^(NSArray *statuses) {
                                                 [self parseStatuses:statuses];
                                             }
                                               errorBlock:^(NSError *error) {
                                                   NSLog(@"error = %@", error);
                                               }];
}

#pragma mark - Parsing helper methods

- (void)parseStatuses:(NSArray *)array {
    NSMutableArray *parsedStatuses = [NSMutableArray array];

    for (NSDictionary *jsonStatus in array) {
        id status = [MTLJSONAdapter modelOfClass:[TGTTwitterStatus class] fromJSONDictionary:jsonStatus
                                   error:nil];
        [parsedStatuses addObject:status];
    }

    self.statuses = parsedStatuses;
}

@end
