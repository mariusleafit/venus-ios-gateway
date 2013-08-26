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
        if(pNPA.length > 0) {
            self.npa = pNPA;
        } else {
            self.npa = @"0";
        }
        if(pPhone.length > 0) {
            self.phone = pPhone;
        } else {
            self.phone = @"0";
        }
        self.url = pUrl;
    }
    return self;
}

-(void)start {
    //concat url
    NSURL *requestUrl = nil;
    requestUrl = [NSURL URLWithString:[self.url absoluteString]];

    
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData];
    [request setURL:requestUrl];
    [request setHTTPMethod:@"PUT"];
    [request setValue:@"application/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    
    NSString *payload = [NSString stringWithFormat:@"<ExternalUserAccessDetails xmlns=\"http://xmlns.leafit.ch/venus/externaluseraccess\"><address>%@</address><city>%@</city><name>%@</name><npa>%@</npa><phone>%@</phone></ExternalUserAccessDetails>",self.address,self.city,self.name,self.npa,self.phone];
    
   
    [request setValue:[NSString stringWithFormat:@"%i",payload.length]  forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:[NSData dataWithBytes:[payload UTF8String] length:[payload length]]];
    
    // Send an asyncronous request
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self startImmediately:NO];
    
    [connection start];
}
@end
