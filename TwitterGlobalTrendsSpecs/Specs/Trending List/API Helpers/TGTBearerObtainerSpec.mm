#import <Cedar-iOS/SpecHelper.h>
#import <STTwitter/STTwitterAPIWrapper.h>

#import "TGTBearerObtainer.h"

using namespace Cedar::Matchers;

SPEC_BEGIN(TGTBearerObtainerSpec)

describe(@"TGTBearerObtainer", ^{
    __block TGTBearerObtainer *bearerObtainer;
    
    beforeEach(^{
        bearerObtainer = [TGTBearerObtainer obtainerWithTwitterAPIWrapper:nil];
    });

    describe(@"obtain bearer", ^{
        beforeEach(^{
            [bearerObtainer obtainBearer];
        });
    });
});

SPEC_END
