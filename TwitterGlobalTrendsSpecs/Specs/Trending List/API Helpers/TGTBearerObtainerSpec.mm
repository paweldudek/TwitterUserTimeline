#import <Cedar-iOS/SpecHelper.h>
#import <STTwitter/STTwitterAPIWrapper.h>

#import "TUTBearerObtainer.h"

using namespace Cedar::Matchers;

SPEC_BEGIN(TGTBearerObtainerSpec)

describe(@"TUTBearerObtainer", ^{
    __block TUTBearerObtainer *bearerObtainer;
    
    beforeEach(^{
        bearerObtainer = [TUTBearerObtainer obtainerWithTwitterAPIWrapper:nil];
    });

    describe(@"obtain bearer", ^{
        beforeEach(^{
            [bearerObtainer obtainBearer];
        });
    });
});

SPEC_END
