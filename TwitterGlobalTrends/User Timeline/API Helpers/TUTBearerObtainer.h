/*
 * Copyright 2013 Taptera Inc. All rights reserved.
 */


#import <Foundation/Foundation.h>

@class STTwitterAPIWrapper;
@class TUTBearerObtainer;

@protocol TUTBearerObtainerDelegate <NSObject>

- (void)bearerObtainer:(TUTBearerObtainer *)obtainer didObtainBearerToken:(NSString *)token;

@end

@interface TUTBearerObtainer : NSObject
@property(nonatomic, weak) id <TUTBearerObtainerDelegate> delegate;
@property(nonatomic, strong) STTwitterAPIWrapper *apiWrapper;

+ (instancetype)obtainerWithTwitterAPIWrapper:(STTwitterAPIWrapper *)wrapper;

- (void)obtainBearer;

@end
