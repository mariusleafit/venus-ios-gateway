//
//  WCFServiceDelegate.h
//  VenusIOSGatway
//
//  Created by Marius Gächter on 20.08.13.
//  Copyright (c) 2013 leafit. All rights reserved.
//

#import <Foundation/Foundation.h>
@class WCFService;

@protocol WCFServiceDelegate <NSObject>
-(void)wcfService:(WCFService *)wcfService finishedSuccessfully:(NSData *)data;
-(void)wcfService:(WCFService *)wcfService finishedWithError:(NSError *)error;
@end
