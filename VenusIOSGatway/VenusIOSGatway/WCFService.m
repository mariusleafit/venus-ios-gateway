//
//  WCFService.m
//  VenusIOSGatway
//
//  Created by Marius Gächter on 20.08.13.
//  Copyright (c) 2013 leafit. All rights reserved.
//

#import "WCFService.h"

@interface WCFService()
    @property NSMutableData *responseData;
@end

@implementation WCFService

@synthesize delegate;

-(id)initWithDelegate:(id<WCFServiceDelegate>)pDelegate {
    self = [super init];
    if(self) {
        self.delegate = pDelegate;
    }
    return self;
}

-(void)start {
    //download
    //NSURLRequest *request = [[NSURLRequest alloc] initWithURL:self.downloadUrl cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData timeoutInterval:[Constants DOWNLOADTIMEOUT]];
    
    /*NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"https://172.16.0.209:9590/Services/GAT_ExternalUserAccess"]];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    //[request setValue:@"www.webservicex.net" forHTTPHeaderField:@"Host"];
    [request setValue:@"http://xmlns.leafit.ch/venus/externaluseraccess/IExternalUserAccessServices/GetDDSScreen" forHTTPHeaderField:@"SOAPAction"];
    
    NSString *authStr = @"Basic a:a";
    NSData *authData = [authStr dataUsingEncoding:NSUTF8StringEncoding];
   
    NSString *authValue = [NSString stringWithFormat:@"%@", [WCFService base64forData:authData]];
    [request setValue:authValue forHTTPHeaderField:@"Authorization"];
    
    [request setValue:messageLength forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody:[soapMessage dataUsingEncoding:NSUTF8StringEncoding]];*/
    
}

#pragma mark - NSURLConnectionDelegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    // A response has been received, this is where we initialize the instance var you created
    // so that we can append data to it in the didReceiveData method
    // Furthermore, this method is called each time there is a redirect so reinitializing it
    // also serves to clear it
    self.responseData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // Append the new data to the instance variable you declared
    [self.responseData appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    // Return nil to indicate not necessary to store a cached response for this connection
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    
    [self.delegate wcfService:self finishedSuccessfully:[NSData dataWithData:self.responseData]];
    
    self.responseData = nil;
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [self.delegate wcfService:self finishedWithError:error];
}


#pragma mark Handle SSL
// Accept Self Signed SSL Cert
- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace {
    return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust])
    {
        [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust] forAuthenticationChallenge:challenge];
    }
    [challenge.sender continueWithoutCredentialForAuthenticationChallenge:challenge];
}

@end
