/*
 * Copyright 2013 Taptera Inc. All rights reserved.
 */


#import <Foundation/Foundation.h>
#import "TGTBearerObtainer.h"

@class TGTBearerObtainer;


@interface TUTUserTimelineViewController : UIViewController <TUTBearerObtainerDelegate, UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, strong) id twitterAPIWrapper;
@property(nonatomic, copy) NSString *bearerToken;
@property(nonatomic, strong) TGTBearerObtainer *bearerObtainer;
@property(nonatomic, strong) NSArray *statuses;
@property(nonatomic, strong) UITableView *tableView;
@end
