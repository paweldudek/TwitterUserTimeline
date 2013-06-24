/*
 * Copyright 2013 Taptera Inc. All rights reserved.
 */


#import <Foundation/Foundation.h>
#import "TUTBearerObtainer.h"

@class TUTBearerObtainer;


@interface TUTUserTimelineViewController : UIViewController <TUTBearerObtainerDelegate, UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong) id twitterAPIWrapper;
@property(nonatomic, copy) NSString *bearerToken;
@property(nonatomic, strong) TUTBearerObtainer *bearerObtainer;
@property(nonatomic, strong) NSArray *statuses;
@property(nonatomic, strong) UITableView *tableView;
@end
