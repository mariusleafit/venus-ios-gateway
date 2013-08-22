//
//  SendUserDataWCFService.h
//  VenusIOSGatway
//
//  Created by Marius Gächter on 22.08.13.
//  Copyright (c) 2013 leafit. All rights reserved.
//

#import "WCFService.h"


@interface SendUserDataWCFService : WCFService
-(id)initWithDelegate:(id<WCFServiceDelegate>)delegate url:(NSURL *)pUrl name:(NSString *)pName address:(NSString *)pAddress city:(NSString *)pCity npa:(NSString *)pNPA phone:(NSString *)pPhone;

-(void)start;
@end
