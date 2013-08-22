//
//  SendUserDataWCFService.m
//  VenusIOSGatway
//
//  Created by Marius Gächter on 22.08.13.
//  Copyright (c) 2013 leafit. All rights reserved.
//

#import "SendUserDataWCFService.h"

@interface SendUserDataWCFService()
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *address;
@property (nonatomic) NSString *city;
@property (nonatomic) NSString *npa;
@property (nonatomic) NSString *phone;
@property (nonatomic) NSURL *url;
@end

@implementation SendUserDataWCFService
-(id)initWithDelegate:(id<WCFServiceDelegate>)delegate url:(NSURL *)pUrl name:(NSString *)pName address:(NSString *)pAddress city:(NSString *)pCity npa:(NSString *)pNPA phone:(NSString *)pPhone {
    self = [super initWithDelegate:delegate];
    if(self) {
        self.name = pName;
        self.address = pAddress;
        self.city = pCity;
        self.npa = pNPA;
        self.phone = pPhone;
        self.url = pUrl;
    }
    return self;
}

-(void)start {
    //concat url
    NSURL *requestUrl = nil;
    NSString *urlString = [NSString stringWithFormat:@"%@?name=%@&address=%@&city=%@&npa=%@&phone=%@",[self.url absoluteString],self.name, self.address, self.city, self.npa, self.phone];
    requestUrl = [NSURL URLWithString:urlString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:requestUrl cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:5];
    
    // Send an asyncronous request
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:NO];
    
    [connection start];
}
@end
