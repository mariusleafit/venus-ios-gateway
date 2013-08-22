//
//  ViewController.h
//  VenusIOSGatway
//
//  Created by Marius Gächter on 20.08.13.
//  Copyright (c) 2013 leafit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WCFServiceDelegate.h"  

@interface ScreenDisplayViewController : UIViewController <WCFServiceDelegate>
- (IBAction)send:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *image;

@end
