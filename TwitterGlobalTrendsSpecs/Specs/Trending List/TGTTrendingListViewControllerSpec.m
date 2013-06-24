#import <Cedar-iOS/SpecHelper.h>
#import <STTwitter/STTwitterAPIWrapper.h>

#import "TUTUserTimelineViewController.h"
#import "FakeTwitterAPIWrapper.h"
#import "TUTTwitterStatus.h"

#define MOCKITO_SHORTHAND
#import "OCMockito.h"

#define EXP_SHORTHAND
#import "Expecta.h"

SPEC_BEGIN(TGTTrendingListViewControllerSpec)

describe(@"TUTUserTimelineViewController", ^{
    __block TUTUserTimelineViewController *trendingListViewController;

    beforeEach(^{
        trendingListViewController = [[TUTUserTimelineViewController alloc] init];
    });

    it(@"should have a twitter client", ^{
        expect(trendingListViewController.twitterAPIWrapper).to.beKindOf([STTwitterAPIWrapper class]);
    });

    describe(@"bearer obtainer", ^{

        __block TUTBearerObtainer *bearerObtainer;

        beforeEach(^{
            bearerObtainer = trendingListViewController.bearerObtainer;
        });

        it(@"should have a twitter api wrapper", ^{
            expect(bearerObtainer.apiWrapper).to.equal(trendingListViewController.twitterAPIWrapper);
        });
    });

    describe(@"view will appear", ^{

        __block id mockBearerObtainer;

        beforeEach(^{
            mockBearerObtainer = mock([TUTBearerObtainer class]);
            trendingListViewController.bearerObtainer = mockBearerObtainer;
        });

        action(^{
            [trendingListViewController viewWillAppear:NO];
        });

        it(@"should tell the bearer to obtain the token", ^{
            [verify(mockBearerObtainer) obtainBearer];
        });
    });

    describe(@"bearer obtainer delegate", ^{
        describe(@"did obtain token", ^{

            __block FakeTwitterAPIWrapper *fakeAPIWrapper;

            beforeEach(^{
                fakeAPIWrapper = [FakeTwitterAPIWrapper fakeWrapper];
                trendingListViewController.twitterAPIWrapper = fakeAPIWrapper;
            });

            action(^{
                [trendingListViewController bearerObtainer:nil didObtainBearerToken:nil];
            });

            it(@"should start downloading the timeline for user", ^{
                expect(fakeAPIWrapper.lastScreenName).to.equal(@"eldudi");
            });

            describe(@"when obtaining is successful", ^{

                __block id statuses;

                beforeEach(^{
                    NSString *path = [[NSBundle mainBundle] pathForResource:@"UserStatuses" ofType:@"JSON"];
                    NSData *response = [NSData dataWithContentsOfFile:path];

                    statuses = [NSJSONSerialization JSONObjectWithData:response options:0 error:nil];
                });

                action(^{
                    [fakeAPIWrapper simulateUserTimelineDownloadWithStatuses:statuses];
                });

                describe(@"parsed statuses", ^{

                    __block NSArray *statuses;

                    action(^{
                        statuses = [trendingListViewController statuses];
                    });

                    describe(@"first status", ^{

                        __block TUTTwitterStatus *status;

                        action(^{
                            status = statuses[0];
                        });

                        it(@"should have a text", ^{
                            expect(status.text).to.equal(@"Fixture Status Text");
                        });
                    });
                });
            });
        });
    });

    describe(@"table view delegate", ^{
        describe(@"number of rows", ^{

            __block NSInteger numberOfRowsInSection;

            beforeEach(^{
                TUTTwitterStatus *status = [[TUTTwitterStatus alloc] init];
                trendingListViewController.statuses = @[status];
            });

            action(^{
                numberOfRowsInSection = [trendingListViewController tableView:nil numberOfRowsInSection:0];
            });

            it(@"should equal number of statuses", ^{
                expect(numberOfRowsInSection).to.equal(1);
            });
        });

        describe(@"cell for row", ^{

            __block UITableViewCell *tableViewCell;
            __block NSIndexPath *indexPath;

            beforeEach(^{
                indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            });

            action(^{
                tableViewCell = [trendingListViewController tableView:nil cellForRowAtIndexPath:indexPath];
            });

            it(@"should return a table view cell", ^{
                expect(tableViewCell).to.beKindOf(([UITableViewCell class]));
            });
        });
    });
});

SPEC_END
