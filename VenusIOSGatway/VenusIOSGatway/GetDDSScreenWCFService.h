//
//  GetDDSScreenWCFService.h
//  VenusIOSGatway
//
//  Created by Marius Gächter on 22.08.13.
//  Copyright (c) 2013 leafit. All rights reserved.
//

#import "WCFService.h"

@interface GetDDSScreenWCFService : WCFService
-(id)initWithDelegate:(id<WCFServiceDelegate>)delegate andUrl:(NSURL *)pUrl;

-(void)start;
@end
