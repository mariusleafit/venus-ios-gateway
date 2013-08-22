//
//  GetDDSScreenWCFService.m
//  VenusIOSGatway
//
//  Created by Marius Gächter on 22.08.13.
//  Copyright (c) 2013 leafit. All rights reserved.
//

#import "GetDDSScreenWCFService.h"

@interface GetDDSScreenWCFService() {
    
}
@property (nonatomic) NSURL *url;
@end

@implementation GetDDSScreenWCFService

-(id)initWithDelegate:(id<WCFServiceDelegate>)delegate andUrl:(NSURL *)pUrl; {
    self = [super initWithDelegate:delegate];
    if(self) {
        self.url = pUrl;
    }
    return self;
}

-(void)start {
    NSURLRequest *request = [NSURLRequest requestWithURL:self.url cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:5];
    
    // Send an asyncronous request
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:NO];
    
    [connection start];
}
@end
