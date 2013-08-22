//
//  WCFService.h
//  VenusIOSGatway
//
//  Created by Marius Gächter on 20.08.13.
//  Copyright (c) 2013 leafit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WCFServiceDelegate.h"

@interface WCFService : NSObject <NSURLConnectionDelegate>
@property (nonatomic) id<WCFServiceDelegate> delegate;

-(id)initWithDelegate:(id<WCFServiceDelegate>)delegate;

-(void) start;
@end
