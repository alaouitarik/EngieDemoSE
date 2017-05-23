//
//  EngieSETests.m
//  EngieSETests
//
//  Created by Tarik ALAOUI on 23/05/2017.
//  Copyright © 2017 Alaoui.me. All rights reserved.
//

#import <XCTest/XCTest.h>

@interface EngieSETests : XCTestCase

@end

@implementation EngieSETests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

-(void) testIsLogged{
    BOOL isLoggedIn = [[NSUserDefaults standardUserDefaults] boolForKey:@"isLoggedIn"];
    XCTAssert(isLoggedIn == true, "User is logged In");
}

-(void) testCurlPost{
        dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);

        
        NSString *parameters = @"email=demo@test.com&name=DemoName&surname=DemoSurname";
        NSData *PostData = [parameters dataUsingEncoding:NSUTF8StringEncoding];
        
        NSURL *url = [NSURL URLWithString:@"http://jsonplaceholder.typicode.com/users"];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        [request setHTTPMethod:@"POST"];
        [request setHTTPBody:PostData];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];

        
        
                NSURLSession *session = [NSURLSession sharedSession];
                [[session dataTaskWithRequest:request
                            completionHandler:^(NSData *data,
                                                NSURLResponse *response,
                                                NSError *error) {
                                
                                XCTAssertNil(error, @"dataTaskWithURL error %@", error);
                                
                                long status_code = (long)[(NSHTTPURLResponse *)response statusCode];
                                
                                if(!error && data){
                                    XCTAssertNil(error, "Error should be null");
                                    XCTAssertEqual(status_code, 201, "Success response should be 201");
                                }else{
                                    XCTAssertNotNil(error, "Error shouldn't be null");
                                    XCTFail("Response was not NSHTTPURLResponse");

                                }
                                dispatch_semaphore_signal(semaphore);
                            }] resume];

        
        long rc = dispatch_semaphore_wait(semaphore, dispatch_time(DISPATCH_TIME_NOW, 60.0 * NSEC_PER_SEC));
        XCTAssertEqual(rc, 0, @"network request timed out");
}
@end
