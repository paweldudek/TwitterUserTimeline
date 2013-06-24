/*
 * Copyright 2013 Taptera Inc. All rights reserved.
 */


#import <Foundation/Foundation.h>

@class STTwitterAPIWrapper;
@class TGTBearerObtainer;

@protocol TUTBearerObtainerDelegate <NSObject>

- (void)bearerObtainer:(TGTBearerObtainer *)obtainer didObtainBearerToken:(NSString *)token;

@end

@interface TGTBearerObtainer : NSObject
@property(nonatomic, weak) id <TUTBearerObtainerDelegate> delegate;
@property(nonatomic, strong) STTwitterAPIWrapper *apiWrapper;

+ (instancetype)obtainerWithTwitterAPIWrapper:(STTwitterAPIWrapper *)wrapper;

- (void)obtainBearer;

@end
