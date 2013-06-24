#import <Cedar-iOS/SpecHelper.h>
#import <STTwitter/STTwitterAPIWrapper.h>

#import "TGTTrendingListViewController.h"
#import "FakeTwitterAPIWrapper.h"
#import "TGTTwitterStatus.h"

using namespace Cedar::Matchers;

SPEC_BEGIN(TGTTrendingListViewControllerSpec)

describe(@"TGTTrendingListViewController", ^{
    __block TGTTrendingListViewController *trendingListViewController;

    beforeEach(^{
        trendingListViewController = [[TGTTrendingListViewController alloc] init];
    });

    it(@"should have a twitter client", ^{
        expect(trendingListViewController.twitterAPIWrapper).to(be_instance_of([STTwitterAPIWrapper class]));
    });

    describe(@"bearer obtainer", ^{

        __block TGTBearerObtainer *bearerObtainer;

        beforeEach(^{
            bearerObtainer = trendingListViewController.bearerObtainer;
        });

        it(@"should have a twitter api wrapper", ^{
            expect(bearerObtainer.apiWrapper).to(equal(trendingListViewController.twitterAPIWrapper));
        });
    });

    describe(@"view will appear", ^{
        beforeEach(^{
            trendingListViewController.twitterAPIWrapper = nil;

            [trendingListViewController viewWillAppear:NO];
        });

        it(@"should tell the bearer to obtain the token", ^{
              //TODO
        });
    });

    describe(@"bearer obtainer delegate", ^{
        describe(@"did obtain token", ^{

            __block FakeTwitterAPIWrapper *fakeAPIWrapper;

            beforeEach(^{
                fakeAPIWrapper = [FakeTwitterAPIWrapper fakeWrapper];
                trendingListViewController.twitterAPIWrapper = fakeAPIWrapper;

                [trendingListViewController bearerObtainer:nil didObtainBearerToken:nil];
            });

            it(@"should start downloading the timeline for user", ^{
                expect(fakeAPIWrapper.lastScreenName).to(equal(@"eldudi"));
            });

            describe(@"when obtaining is successful", ^{
                beforeEach(^{
                    NSString *path = [[NSBundle mainBundle] pathForResource:@"UserStatuses" ofType:@"JSON"];
                    NSData *response = [NSData dataWithContentsOfFile:path];

                    id statuses = [NSJSONSerialization JSONObjectWithData:response options:0 error:nil];

                    [fakeAPIWrapper simulateUserTimelineDownloadWithStatuses:statuses];
                });

                describe(@"parsed statuses", ^{

                    __block NSArray *statuses;

                    beforeEach(^{
                        statuses = [trendingListViewController statuses];
                    });

                    describe(@"first status", ^{

                        __block TGTTwitterStatus *status;

                        beforeEach(^{
                            status = statuses[0];
                        });

                        it(@"should have a text", ^{
                            expect(status.text).to(equal(@"Fixture Status Text"));
                        });
                    });
                });
            });
        });
    });
});

SPEC_END
